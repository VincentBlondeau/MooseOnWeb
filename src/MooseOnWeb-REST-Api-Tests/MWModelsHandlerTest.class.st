Class {
	#name : #MWModelsHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> MSEtestfile [
	^'(
	(FAMIX.Namespace (id: 1) (name ''aNamespace''))

	(FAMIX.Class (id: 2) (name ''ClassA'') (container (ref: 1)) (parentPackage (ref: 201)))
	(FAMIX.Method (name ''methodA1'') (signature ''methodA1()'') (parentType (ref: 2)) (LOC 2))
	(FAMIX.Attribute (name ''attributeA1'') (parentType (ref: 2)))

	(FAMIX.Class (id: 3) (name ''ClassB'') (container (ref: 1)) (parentPackage (ref: 201)))

	(FAMIX.Inheritance (subclass (ref: 3)) (superclass (ref: 2)))

	(FAMIX.Package (id: 201) (name ''aPackage''))
	(FAMIX.Package (id: 202) (name ''aPackage'') (parentPackage (ref: 201)))
)'
]

{ #category : #'tests-public' }
MWModelsHandlerTest >> testDelete [
	|  id |
	
	self assert: (server delegate mooseModelList includes: modelTest).
	self deny: server delegate mooseModelList isSequenceable .
	client addPathSegment: 'models'.
	id := self modelTest mooseID.
	client contents: id asString.
	client delete.
	
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType textPlain.
	
	self deny: (server delegate mooseModelList includes: modelTest).

]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testGet [
	| output|
	client addPathSegment: 'models'.
	output := client get.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8.
	self assert: (output includesSubstring: '[').
	self rootModelForTestServer 
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
	size := server delegate mooseModelList size.
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


	self assert: server delegate mooseModelList size equals: size +1.
]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testPostWithMultipart [
	|  size content |
	client addPathSegment: 'models';
		headerAt: 'content-type' put: 'multipart/form-data';
		multiPartFormDataEntity.
	content := ZnEntity with: self MSEtestfile type: ZnMimeType applicationOctetStream .
	client request entity addPart: (ZnMimePart fieldName: 'file' fileName: 'modelMSE.mse' entity: content).
	size := server delegate mooseModelList size.
	client post.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson .
	self assert: server delegate mooseModelList size equals: size +1.
]
