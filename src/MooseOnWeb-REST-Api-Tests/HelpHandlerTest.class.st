Class {
	#name : #HelpHandlerTest,
	#superclass : #MooseOnWebServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
HelpHandlerTest >> testGet [
	
	client addPathSegment: 'help'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notImplemented  .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]
