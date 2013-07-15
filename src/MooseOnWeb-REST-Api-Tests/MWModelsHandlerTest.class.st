Class {
	#name : #MWModelsHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'tests-public' }
MWModelsHandlerTest >> testDelete [
	|  id |
	
	self assert: (self rootModelForTestServer includes: modelTest).
	
	client addPathSegment: 'models'.
	id := self modelTest mooseID.
	client contents: id asString.
	client delete.
	
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType textPlain.
	
	self deny: (self rootModelForTestServer includes: modelTest).

]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testGet [
	| output|
	client addPathSegment: 'models'.
	output := client get.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8.
	self assert: (output includesSubstring: self rootModelForTestServer mooseName).
	self deny: (output includesSubstring: '"id" : ',self rootModelForTestServer mooseID asString,',').
	self rootModelForTestServer entities
		do: [ :e | 
			self assert: (output includesSubstring: e mooseName).
			self assert: (output includesSubstring: e mooseID asString) ]
]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testGetModelAccessIDFromAction [
	
	| clientTemp |
	clientTemp := ZnClient new
		url: server localUrl;
		yourself.
	self modelTest allDeclaredProperties
		do: [ :p | 
			| res |
			res := self modelTest perform: p implementingSelector.
			res isMooseEntity ifTrue: [
			clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , res mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 ]].
]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testGetModelEntitiesListAccessID [
	|  clientTemp |

	clientTemp := ZnClient new
		url: server localUrl;
		yourself.

	self modelTest entities
		do: [ :e | 
			clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , e mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8  ].
		clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , self modelTest mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8.
]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testPost [
	|  size |
	client addPathSegment: 'models'.
	size := self rootModelForTestServer size.
	client contents: '(
	(FAMIX.Namespace (id: 1) (name ''aNamespace''))

	(FAMIX.Class (id: 2) (name ''ClassA'') (container (ref: 1)) (parentPackage (ref: 201)))
	(FAMIX.Method (name ''methodA1'') (signature ''methodA1()'') (parentType (ref: 2)) (LOC 2))
	(FAMIX.Attribute (name ''attributeA1'') (parentType (ref: 2)))

	(FAMIX.Class (id: 3) (name ''ClassB'') (container (ref: 1)) (parentPackage (ref: 201)))

	(FAMIX.Inheritance (subclass (ref: 3)) (superclass (ref: 2)))

	(FAMIX.Package (id: 201) (name ''aPackage''))
	(FAMIX.Package (id: 202) (name ''aPackage'') (parentPackage (ref: 201)))
)'.
	client post.
	
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson .
	

	self assert: self rootModelForTestServer size equals: size +1.
	self rootModelForTestServer last remove
]
