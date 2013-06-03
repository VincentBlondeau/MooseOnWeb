Class {
	#name : #ZincRequestHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'client'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> mooseEntitiesFromRootNumber: aNum [
	self flag:	'TO BE DELETED'.
	^ (MooseModel root at: aNum)
		collect: [ :each | 
			Dictionary new
				at: #mooseID put: each mooseID;
				at: #name put: each name;
				yourself ]
]

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> mooseModelsAsCollection [
self flag: 'TO BE DELETED'.
	^ (MooseModel root
		collect: [ :each | 
			Dictionary new
				at: #mooseID put: each mooseID;
				at: #name put: each name;
				yourself ])" copyWith: (MooseModel superclass methodDict keys )".
]

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> setUp [
	server := ZnServer startOn: 1710 + 10 atRandom.
	server delegate: 
		(ZnRestServerDelegate new 
			uriSpace: (ZnCallHierarchyRestUriSpace new 
							rootClass: ZincRequestHandler ;
							yourself); 
			yourself).
	MooseModel root size = 0 ifTrue: [ MooseModel new ].
	client := ZnClient new
		url: server localUrl;
		addPathSegment: #modelRoot;
		yourself
]

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> tearDown [
	client close.
	server stop
]

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> testUriModelOne [
	"Here we test doing a GET /modelRootZinc/1"
	| output number |
	number :=1.
	client addPathSegment: number asString.
	output := client get.
	self assert: client isSuccess.
	self assert: output equals: (MooseModel root  at: number) asJson  .
]

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> testUriRoot [
	"Here we test doing a GET /modelRootZinc"
	| output |
	output := client get.
	self assert: client isSuccess.
	self assert: output equals: MooseModel root asJson.
]
