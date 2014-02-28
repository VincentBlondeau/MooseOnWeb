Class {
	#name : #MWFamixDiffHandler,
	#superclass : #MWRestCallHandler,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #'as yet unclassified' }
MWFamixDiffHandler class >> pattern [
	^#( 'mooseOnWeb' 'famixDiff' )
]

{ #category : #public }
MWFamixDiffHandler >> actionMapping [
	^ {('q' -> [ self query ])} asDictionary
]

{ #category : #'as yet unclassified' }
MWFamixDiffHandler >> authorizedActions [
	^ (self class methodsInProtocol: 'actions') collect: [ :aMethod | aMethod selector ]
]

{ #category : #actions }
MWFamixDiffHandler >> diff [
	<mooseonweb: 'GET' name: '/entities/<mooseID>?q=diff&id1=<value>&id2=<value>'
	description:
		'Sends diff message to the entity passing to <mooseID> with argment <value>. Returns a Set of FamixChanges'>
	| uri   id1 id2 |
	[ 
	uri := request uri.
	id1 := uri queryAt: 'id1'.
	id2 := uri queryAt: 'id2']
		on: KeyNotFound
		do: [ MWRessourceNotFound signal ].
	^  ((FamixDiff new
		base: (self findEntityInModelWithID: id1 asNumber)first;
		target: (self findEntityInModelWithID: id2 asNumber)first;
		diff;
		yourself) changes reject: #isVersion) asSet
	
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
