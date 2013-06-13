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
		'entity'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
EntitiesHandlerWithID class >> pattern [
	^#( 'mooseOnWeb' 'entities' '*' )
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> action [
	| action |
	action:= request uri queryAt: 'action'.
	[answer:=entity perform: action asSymbol] on: MessageNotUnderstood do: [ InvalidSymbol signal ] .

]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> entity [
	^entity
	
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> entity: anEntity [
	anEntity ifNil: [ RessourceNotFound signal ] ifNotNil: [ entity := anEntity ]
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> get [
	| predicateKeys |
[	[ 
	self entity: (MooseEntity objectWithID: variables first asInteger).
	predicateKeys := request uri queryKeys.
	predicateKeys isEmpty
		ifTrue: [ answer := entity ]
		ifFalse: [ 
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

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> query [
	"/entities/<mooseID>?q=actions : liste des opérations de lecture applicable sur l'entité : allPropertySelectors"

	| q |
	q := request uri queryAt: 'q'.
	(q equalsTo: 'action')
		ifTrue: [ 
			answer := (entity allPropertySelectors values
				select: [ :aSelector | 
					| r |
					r := entity perform: aSelector.
					r isMooseGroup
						ifTrue: [ r isEmpty not ]
						ifFalse: [ r isNil not ] ]) sort ]
		ifFalse: [ 
			(q equalsTo: 'search')
				ifTrue: [ self search ]
				ifFalse: [ InvalidSymbol signal ] ]
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> search [
	" answer to a url of type : /entities/<mooseID>?q=search&<message>=<value>"

	| keys message value |
	keys := request uri query keys asArray.
	keys size = 2
		ifFalse: [ InvalidSymbol signal ].
	message := keys at: 2.
	value := request uri queryAt: message.
	entity isMooseGroup
		ifTrue: [ answer := entity select: [ :e | (e perform: message asSymbol) = value ] ]
		ifFalse: [ NotYetImplemented signalFor: 'Requests on moose entities' ]
]
