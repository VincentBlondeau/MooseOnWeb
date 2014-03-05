Class {
	#name : #MWFamixDiffHandler,
	#superclass : #MWRestCallHandler,
	#classVars : [
		'ChangesComputation'
	],
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #'as yet unclassified' }
MWFamixDiffHandler class >> pattern [
	^#( 'mooseOnWeb' 'famixDiff' )
]

{ #category : #'as yet unclassified' }
MWFamixDiffHandler >> DoItIn: ThisContext [
	^ (self changesComputation changeMetrics associations
		collect: [ :anAssoc | anAssoc key -> (anAssoc value collect: [ :aFamixIndicator | aFamixIndicator label ]) ])
		asDictionary
]

{ #category : #public }
MWFamixDiffHandler >> actionMapping [
	^ {('q' -> [ self query ])} asDictionary
]

{ #category : #'as yet unclassified' }
MWFamixDiffHandler >> authorizedActions [
	^ (self class methodsInProtocol: 'actions') collect: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
MWFamixDiffHandler >> changesComputation [
	
	^ ChangesComputation
]

{ #category : #accessing }
MWFamixDiffHandler >> changesComputation: anObject [
	
	ChangesComputation := anObject
]

{ #category : #actions }
MWFamixDiffHandler >> diff [
	<mooseonweb: 'GET' name: '/famixDiff?q=diff&id1=<value>&id2=<value>'
	description:
		'Sends diff message to the entity passing to <mooseID> with argment <value>. Returns a Set of FamixChanges'>
	| uri   id1 id2 |
	[ 
	uri := request uri.
	id1 := uri queryAt: 'id1'.
	id2 := uri queryAt: 'id2']
		on: KeyNotFound
		do: [ MWRessourceNotFound signal ].
	self changesComputation: (FamixDiffChangesComputation new initializeDiffwith: (self findEntityWithID: id1 asNumber) and: (self findEntityWithID: id2 asNumber)) .
	^  Dictionary new 
		at: 'changeTypes' put: (self changesComputation changeTypes);
		at: 'typesChanged' put: ((self changesComputation changeMetrics associations) collect: [ :anAssoc | (anAssoc key) -> (anAssoc value collect: [ :aFamixIndicator | aFamixIndicator label] )])asDictionary;
		at: 'changes' put: self changesComputation changes;
		yourself
]

{ #category : #actions }
MWFamixDiffHandler >> filter [
	<mooseonweb: 'GET' name: 'famixDiff?q=filter&metrics=<value>&typesChanged=<value>&changesType=<value>'
	description:
		'Filters the changes you want to display'>
	| uri   metrics changesType typesChanged filterParameters |
	[ 
	uri := request uri.
	changesType := uri queryAt: 'changesType'.
	typesChanged := uri queryAt: 'typesChanged'.
	metrics := uri queryAt: 'metrics'.]
		on: KeyNotFound
		do: [ MWRessourceNotFound signal ].
	filterParameters := FamixDiffFilterParameters new
		changes:  (NeoJSONReader fromString: changesType );
		types: (NeoJSONReader fromString: typesChanged);
		metrics: (NeoJSONReader fromString: metrics);
		yourself.
		^ self changesComputation filterChangesWith: filterParameters.
]

{ #category : #public }
MWFamixDiffHandler >> get [
	<mooseonweb: 'GET' name: '/famixDiff' description: 'Get some actions on famix changes'>
	| mapping   uri requestedActions |
	mapping := self actionMapping.
	(self isAcceptableRequest: request withAcceptedMimeType: {ZnMimeType applicationJson}) ifTrue: [ [ [ 
		uri := request uri.
		uri hasQuery
			ifFalse: [ self jsonResponse: self authorizedActions ]
			ifTrue: [ 
				requestedActions := uri queryKeys select: [ :aKey | mapping includesKey: aKey ].
				requestedActions size = 1
				ifFalse: [ self badRequest: 'One action per request' ]
				ifTrue: [ self sendJsonFrom: ((mapping at: requestedActions first) value) ] ] ] 
	on: MWRessourceNotFound
		do: [ :ex | self notFound ] ] 
		on: MWInvalidAction
		do: [ :ex | self notFound ]
		]
	ifFalse: [ self notAcceptable ]
]

{ #category : #'as yet unclassified' }
MWFamixDiffHandler >> query [
	<mooseonweb: 'GET' name: '/famixDiff?q=<action>' description: 'Allows you to do actions with famix diff '>
	|q|
	q := request uri queryAt: 'q'.
	^ (q equalsTo: 'diff')
		ifTrue: [ self diff ]
		ifFalse: [ 
			(q equalsTo: 'filter')
			ifTrue: [ self filter ]
			ifFalse: [ MWRessourceNotFound signal ] ]
]
