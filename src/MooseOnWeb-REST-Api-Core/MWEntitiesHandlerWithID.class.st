"
An EntitiesHandlerWithID is a catcher for the GET entities/ID request. 

Instance Variables
	entity:		<MooseEntity>

entity
	- MooseEntity associated to the Id in the request

"
Class {
	#name : #MWEntitiesHandlerWithID,
	#superclass : #MWRestCallHandler,
	#instVars : [
		'entity',
		'uri'
	],
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWEntitiesHandlerWithID class >> pattern [
	^#( 'mooseOnWeb' 'entities' '*' )
]

{ #category : #query }
MWEntitiesHandlerWithID >> action [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?action=<action name>' description:
		'Apply an action on an entity'>
	| action |
	action := uri queryAt: 'action'.
	answer := self performAction: action.
]

{ #category : #accessing }
MWEntitiesHandlerWithID >> entity [
	^entity
	
]

{ #category : #accessing }
MWEntitiesHandlerWithID >> entity: anEntity [
	anEntity ifNil: [ MWRessourceNotFound signal ] ifNotNil: [ entity := anEntity ]
]

{ #category : #public }
MWEntitiesHandlerWithID >> get [
	<mooseonweb:'GET' name:'/entities/<mooseID>' description:'Get the informations on the entity <mooseID>' >
	
[	[ 
	self entity: (MooseEntity objectWithID: variables first asInteger).
	uri := request uri.
	uri hasQuery
		ifFalse: [ answer := entity ]
		ifTrue: [ 
			| predicateKeys |
			predicateKeys := uri queryKeys.
			(predicateKeys includes: 'q')
				ifTrue: [ self query ]
				ifFalse: [ 
					(predicateKeys includes: 'action')
						ifTrue: [ self action ]
						ifFalse: [ MWInvalidSymbol signal ] ] ].
	self sendJson ]
		on: MWRessourceNotFound
			do: [ :ex | self notFound ]]
		on: MWInvalidSymbol
			do: [ :ex | self badRequest: 'Erreur dans la requete' ]
]

{ #category : #private }
MWEntitiesHandlerWithID >> listActions [
	^ self entity allPropertySelectors values
		select: [ :aSelector | 
			| r |
			r := self entity perform: aSelector.
			r isMooseGroup
				ifTrue: [ r isEmpty not ]
				ifFalse: [ r isNil not ] ]
]

{ #category : #private }
MWEntitiesHandlerWithID >> performAction: action. [
	(self listActions includes: action)
		ifTrue: [ ^entity perform: action asSymbol ]
		ifFalse: [ MWRessourceNotFound signal ]
]

{ #category : #query }
MWEntitiesHandlerWithID >> query [
<mooseonweb:'GET' name:'/entities/<mooseID>?q=actions' description:'List the operations getting the properties of the <mooseID> entities' >
	"/entities/<mooseID>?q=actions : liste des opérations de lecture applicable sur l'entité : allPropertySelectors"

	| q |
	q := uri queryAt: 'q'.
	(q equalsTo: 'actions')
		ifTrue: [ 
			answer := (self listActions) sort ]
		ifFalse: [ 
			(q equalsTo: 'search')
				ifTrue: [ self search ]
				ifFalse: [ MWRessourceNotFound  signal ] ]
]

{ #category : #query }
MWEntitiesHandlerWithID >> search [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?q=search&[action=<value>&]key=<propriete>&op=<op>&value=<value>'
	description:
		'Search the entities of the group <mooseID> which verify :  <property> <op> <value>. If the action is provided, the search will be done in the result group of the action.'>
	| key op value action data |
	[ 
	key := uri queryAt: 'key'.
	value := uri queryAt: 'value'.
	op := uri queryAt: 'op' ]
		on: KeyNotFound
		do: [ MWRessourceNotFound signal ].
	[ 
	action := uri queryAt: 'action'.
	data := self performAction: action ]
		on: KeyNotFound
		do: [ data := entity ].
	data isCollection
		ifFalse: [ NotYetImplemented signalFor: 'Only moose groups !' ].
	answer := ((data select: [ :el | el respondsTo: key asSymbol ])
		select: [ :el | (el perform: key asSymbol) asString perform: op asMessage with: value ]) asOrderedCollection.
	
]

{ #category : #query }
MWEntitiesHandlerWithID >> uri [
	uri
]

{ #category : #query }
MWEntitiesHandlerWithID >> uri: anUri [
	uri := anUri

]
