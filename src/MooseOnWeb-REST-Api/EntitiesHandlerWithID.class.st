"
An EntitiesHandlerWithID is a catcher for the GET entities/ID request. 

Instance Variables
	entity:		<MooseEntity>

entity
	- MooseEntity associated to the Id in the request

"
Class {
	#name : #EntitiesHandlerWithID,
	#superclass : #MooseOnWebRestCall,
	#instVars : [
		'entity',
		'uri'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
EntitiesHandlerWithID class >> pattern [
	^#( 'mooseOnWeb' 'entities' '*' )
]

{ #category : #query }
EntitiesHandlerWithID >> action [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?action=<action name>' description:
		'Apply an action on an entity'>
	| action |
	action := uri queryAt: 'action'.
	answer := self performAction: action.
]

{ #category : #accessing }
EntitiesHandlerWithID >> entity [
	^entity
	
]

{ #category : #accessing }
EntitiesHandlerWithID >> entity: anEntity [
	anEntity ifNil: [ RessourceNotFound signal ] ifNotNil: [ entity := anEntity ]
]

{ #category : #public }
EntitiesHandlerWithID >> get [
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
						ifFalse: [ InvalidSymbol signal ] ] ].
	self sendJson ]
		on: RessourceNotFound
			do: [ :ex | self notFound ]]
		on: InvalidSymbol
			do: [ :ex | self badRequest: 'Erreur dans la requete' ]
]

{ #category : #private }
EntitiesHandlerWithID >> listActions [
	^ self entity allPropertySelectors values
		select: [ :aSelector | 
			| r |
			r := self entity perform: aSelector.
			r isMooseGroup
				ifTrue: [ r isEmpty not ]
				ifFalse: [ r isNil not ] ]
]

{ #category : #private }
EntitiesHandlerWithID >> performAction: action. [
	(self listActions includes: action)
		ifTrue: [ ^entity perform: action asSymbol ]
		ifFalse: [ RessourceNotFound signal ]
]

{ #category : #query }
EntitiesHandlerWithID >> query [
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
				ifFalse: [ RessourceNotFound  signal ] ]
]

{ #category : #query }
EntitiesHandlerWithID >> search [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?q=search&[action=<value>&]key=<propriete>&op=<op>&value=<value>'
	description:
		'Search the entities of the group <mooseID> which verify :  <property> <op> <value>. If the action is provided, the search will be done in the result group of the action.'>
	| key op value action data |
	[ 
	key := uri queryAt: 'key'.
	value := uri queryAt: 'value'.
	op := uri queryAt: 'op' ]
		on: KeyNotFound
		do: [ RessourceNotFound signal ].
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
EntitiesHandlerWithID >> uri [
	uri
]

{ #category : #query }
EntitiesHandlerWithID >> uri: anUri [
	uri := anUri

]
