Class {
	#name : #MWEntitiesHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
MWEntitiesHandlerTest >> testGet [
	
	client addPathSegment: 'entities'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notImplemented  .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]
