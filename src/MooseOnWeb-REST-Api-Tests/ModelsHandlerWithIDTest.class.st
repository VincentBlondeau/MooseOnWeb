Class {
	#name : #ModelsHandlerWithIDTest,
	#superclass : #MooseOnWebServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
ModelsHandlerWithIDTest >> testAccessibilityIDs [
	| root clientTemp |
	root := MooseModel root.
	clientTemp := ZnClient new
		url: server localUrl;
		yourself.

	root entities
		do: [ :e | 
			clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , e mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson ].
		clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , root mooseID asString).
			self deny: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson.
]

{ #category : #'as yet unclassified' }
ModelsHandlerWithIDTest >> testGet [
	| output root |
	client addPathSegment: 'models'.
	output := client get.
	root := MooseModel root.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson.
	self assert: (output includesSubstring: root mooseName).
	self assert: (output includesSubstring: root mooseID asString).
	root entities
		do: [ :e | 
			self assert: (output includesSubstring: root mooseName).
			self assert: (output includesSubstring: root mooseID asString) ]
]
