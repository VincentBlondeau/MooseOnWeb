"
A MWEntitiesHandlerTest is a test unit for MWEntitiesHandler.


"
Class {
	#name : #MWEntitiesHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #tests }
MWEntitiesHandlerTest >> testGet [
	
	client addPathSegment: 'entities'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]
