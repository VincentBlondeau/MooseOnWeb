"
An EntitiesHandlerWithID is a handler for the GET entities/ID request. 

The entry point is the get method which dispatch all the subrequests (the parameter is always the entity of the request):
- entities/ID?action= is handled by the action: method which use actionMapping to go to the right method.
- entities/ID?q= is handled by query: 
- entities/ID?search=  is handled by search: 

The lookup of the entity in the model is made by findEntityWithID:.
The execution of a method on an entity is made by performAction: on: . It raise MWInvalidAction if the action is not allowed or not existing.

listActionsSelectors: retrieves the executable actions on an moose entity. Using allPropertySelectors which uses pragmas and metamodel to sees what are the understandable methods. If the methods doesn't exists and you want to add it, add a pragma and do MooseModel resetMeta to refresh the meta model.

The action exectution is delegated to an expression parser. It's allowing complex requests. See MooseOnWeb-REST-API-Grammar-*.

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
	<mooseonweb: 'GET' name: '/entities/<mooseID>?action=<action1 name>,<action2 name>,...' description:
		'Execute all actions on an Entity and return a dictionary with action name as keys and results as values'>
	| parsedRequest |
	parsedRequest := MWActionRequestBuilder parse: (request uri queryAt: 'action').
	parsedRequest isPetitFailure
		ifTrue: [ MWInvalidAction signalFor: (request uri queryAt: 'action') ]
		ifFalse: [ 
			^ parsedRequest
				acceptVisitor:
					(MWRequestExecutorVisitor new
						currentEntity: anEntity;
						yourself) ]
]

{ #category : #public }
MWEntitiesHandlerWithID >> actionMapping [
	^ {('q' -> [ :anEntity | self query: anEntity ]).
	('action' -> [ :anEntity | self action: anEntity ])} asDictionary
]

{ #category : #query }
MWEntitiesHandlerWithID >> compare: aStringOrANumberOrABoolean to: anOtherObject withOp: operator [
	^ aStringOrANumberOrABoolean compareTo: anOtherObject withOp: operator
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
	(self isAcceptableRequest: request withAcceptedMimeType: { ZnMimeType applicationJson }) ifTrue: [  
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
		on: MWInvalidAction
		do: [ :ex | self notFound ]
		]
	ifFalse: [ self notAcceptable ]
]

{ #category : #private }
MWEntitiesHandlerWithID >> listActions: anEntity [
	^ (self listActionsSelectors: anEntity)
		collect: [ :methodSymbol |
			 methodSymbol -> (anEntity getCommentInMethod: methodSymbol) ]
]

{ #category : #private }
MWEntitiesHandlerWithID >> listActionsSelectors: anEntity [
	^ anEntity allPropertySelectors values
		
]

{ #category : #query }
MWEntitiesHandlerWithID >> performAction: anActionSymbol on: anEntity [
	((self listActionsSelectors: anEntity) includes: anActionSymbol)
		ifTrue: [ ^anEntity perform: anActionSymbol asSymbol ]
		ifFalse: [ MWInvalidAction signalFor: anActionSymbol ]
]

{ #category : #query }
MWEntitiesHandlerWithID >> query: anEntity [
<mooseonweb:'GET' name:'/entities/<mooseID>?q=actions' description:'List the operations getting the properties of the <mooseID> entities' >

	| q |
	q := request uri queryAt: 'q'.
	^ (q equalsTo: 'actions')
		ifTrue: [ 
			(self listActions: anEntity)  asDictionary.  ]
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
	uri := request uri.
	key := uri queryAt: 'key'.
	value := uri queryAt: 'value'.
	op := uri queryAt: 'op' ]
		on: KeyNotFound
		do: [ MWRessourceNotFound signal ].
	[ 
	action := uri queryAt: 'onAction'.
	data := self performAction: action on: anEntity ]
		on: KeyNotFound
		do: [ data := anEntity ].
	data isCollection
		ifFalse: [ NotYetImplemented signalFor: 'Only moose groups !' ].
	^ ((data select: [ :el | el respondsTo: key asSymbol ])
		select: [ :el | self compare: (el perform: key asSymbol) to: value withOp: op asMessage  ]) asOrderedCollection
]
