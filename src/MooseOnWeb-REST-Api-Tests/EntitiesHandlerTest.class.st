Class {
	#name : #EntitiesHandlerTest,
	#superclass : #MooseOnWebServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
EntitiesHandlerTest >> testGet [
	
	client addPathSegment: 'entities'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notImplemented  .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]
