"
A MWEntitiesHandlerWithIDServerTest is a test unit for MWHelpHandler 

"
Class {
	#name : #MWHelpHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #tests }
MWHelpHandlerTest >> testGet [
	client headerAt: 'Accept' put: 'text/*'; addPathSegment: 'help'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine ok  .
	self assert: client response headers contentType equals: ZnMimeType textPlain 
]
