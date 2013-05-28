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
ZincRequestHandlerTest >> setUp [
	server := ZnServer startOn: 1710 + 10 atRandom.
	server delegate: 
		(ZnRestServerDelegate new 
			uriSpace: (ZnCallHierarchyRestUriSpace new 
							rootClass: ZincRequestHandler ;
							yourself); 
			yourself).
	client := ZnClient new
		url: server localUrl;
		addPathSegment: #modelRootZinc;
		yourself
]

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> tearDown [
	client close.
	server stop
]

{ #category : #'as yet unclassified' }
ZincRequestHandlerTest >> testUriSum [
	"Here we test doing a GET /sum/1/2/3"
	
	| input output |
	input := #(1 2 3).
	input do: [ :each | client addPathSegment: each asString ].
	output := client get.
	self assert: client isSuccess.
	self assert: output equals: input sum asString
]
