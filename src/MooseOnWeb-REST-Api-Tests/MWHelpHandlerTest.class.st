Class {
	#name : #MWHelpHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
MWHelpHandlerTest >> testGet [
	client headerAt: 'Accept' put: 'text/*'; addPathSegment: 'help'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine ok  .
	self assert: client response headers contentType equals: ZnMimeType textPlain 
]
