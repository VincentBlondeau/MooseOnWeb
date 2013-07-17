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
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWEntitiesHandlerWithID class >> pattern [
	^#( 'mooseOnWeb' 'entities' '*' )
]

{ #category : #query }
MWEntitiesHandlerWithID >> action: anEntity [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?action=<action name>' description:
		'Apply an action on an entity'>
	| action |
	action := request uri queryAt: 'action'.
	^ self performAction: action on: anEntity.
]

{ #category : #public }
MWEntitiesHandlerWithID >> actionMapping [
	^ {('q' -> [ :anEntity | self query: anEntity ]).
	('action' -> [ :anEntity | self action: anEntity ]).
	('actions' -> [ :anEntity | self actions: anEntity ])} asDictionary
]

{ #category : #query }
MWEntitiesHandlerWithID >> actions: anEntity [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?actions=<action1 name>,<action2 name>,...' description:
		'Execute all actions on an Entity and return a dictionary with action name as keys and results as values'>
	| actions actionList |
	actionList := self listActions: anEntity.
	actions := (request uri queryAt: 'actions') subStrings: ','.
	actions
		do: [ :anAction | 
			(actionList includes: anAction)
				ifFalse: [ MWRessourceNotFound signalFor: anAction ] ].
	^ (actions collect: [ :anAction | anAction -> (anEntity perform: anAction asSymbol) ]) asDictionary
]

{ #category : #accessing }
MWEntitiesHandlerWithID >> findEntityWithID: anEntityID [
	^ (self listMooseModels collect: [ :m | m objectWithID: anEntityID ])
		detect: [ :anEntity | anEntity notNil ]
		ifNone: [ MWRessourceNotFound signalFor: anEntityID ]
]

{ #category : #public }
MWEntitiesHandlerWithID >> get [
	<mooseonweb: 'GET' name: '/entities/<mooseID>' description: 'Get the informations on the entity <mooseID>'>
	| mapping requestedActions currentEntity uri |
	mapping := self actionMapping.
	[ 
	[ 
	currentEntity := self findEntityWithID: variables first asInteger.
	uri := request uri.
	uri hasQuery
		ifFalse: [ self sendJsonFrom: currentEntity ]
		ifTrue: [ 
			requestedActions := uri queryKeys select: [ :aKey | mapping includesKey: aKey ].
			requestedActions size = 1
				ifFalse: [ self badRequest: 'One action per request' ]
				ifTrue: [ self sendJsonFrom: ((mapping at: requestedActions first) value: currentEntity) ] ] ]
		on: MWRessourceNotFound
		do: [ :ex | self notFound ] ]
		on: MWInvalidSymbol
		do: [ :ex | self badRequest: 'Erreur dans la requete' ]
]

{ #category : #private }
MWEntitiesHandlerWithID >> listActions: anEntity [
	^ anEntity allPropertySelectors values
]

{ #category : #private }
MWEntitiesHandlerWithID >> performAction: action on: anEntity [
	((self listActions:anEntity) includes: action)
		ifTrue: [ ^anEntity perform: action asSymbol ]
		ifFalse: [ MWRessourceNotFound signalFor: action ]
]

{ #category : #query }
MWEntitiesHandlerWithID >> query: anEntity [
<mooseonweb:'GET' name:'/entities/<mooseID>?q=actions' description:'List the operations getting the properties of the <mooseID> entities' >
	"/entities/<mooseID>?q=actions : liste des opérations de lecture applicable sur l'entité : allPropertySelectors"

	| q |
	q := request uri queryAt: 'q'.
	^ (q equalsTo: 'actions')
		ifTrue: [ 
			(self listActions: anEntity) sort ]
		ifFalse: [ 
			(q equalsTo: 'search')
				ifTrue: [ self search: anEntity ]
				ifFalse: [ MWRessourceNotFound  signal ] ]
]

{ #category : #query }
MWEntitiesHandlerWithID >> search: anEntity [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?q=search&[onAction=<action>&]key=<propriete>&op=<op>&value=<value>'
	description:
		'Search the entities of the group <mooseID> which verify :  <property> <op> <value>. If the action is provided, the search will be done in the result group of the action.'>
	| key op value action data uri |
	[ 
	uri:= request uri.
	key := uri queryAt: 'key'.
	value := uri queryAt: 'value'.
	op := uri queryAt: 'op' ]
		on: KeyNotFound
		do: [ MWRessourceNotFound signal ].
	[ 
	action := uri queryAt: 'onAction'.
	data := self performAction: action ]
		on: KeyNotFound
		do: [ data := anEntity ].
	data isCollection
		ifFalse: [ NotYetImplemented signalFor: 'Only moose groups !' ].
	^ ((data select: [ :el | el respondsTo: key asSymbol ])
		select: [ :el | (el perform: key asSymbol) asString perform: op asMessage with: value ]) asOrderedCollection.
	
]
