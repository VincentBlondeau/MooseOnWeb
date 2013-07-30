Class {
	#name : #MWModelsHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #accessing }
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

{ #category : #tests }
MWModelsHandlerTest >> testDeleteAnEntityShouldNotWorking [
	|  id |
	
	self assert: (server delegate mooseModelList includes: modelTest).
	self deny: server delegate mooseModelList isSequenceable .
	client addPathSegment: 'models'.
	id := self modelTest entities first mooseID.
	client queryAt: 'id' put: id asString.
	client delete.
	
	self deny: client isSuccess.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	
	

]

{ #category : #tests }
MWModelsHandlerTest >> testDeleteShouldRemoveTheModelFromTheList [
	|  id |
	
	self assert: (server delegate mooseModelList includes: modelTest).
	self deny: server delegate mooseModelList isSequenceable .
	client addPathSegment: 'models'.
	id := self modelTest mooseID.
	client queryAt: 'id' put: id asString.
	client delete.
	
	self assert: client isSuccess.	
	self deny: (server delegate mooseModelList includes: modelTest).

]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
MWModelsHandlerTest >> testGetShouldContainsAllTheModelsAndBeSuccess [
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

{ #category : #tests }
MWModelsHandlerTest >> testOptionsShouldContainsTheGoodHeaders [
	client addPathSegment: 'models'.
	client method: #OPTIONS; execute.
	self assert: client isSuccess.
	self assert: (client response headers at: 'Access-Control-Allow-Methods') equals: 'POST, GET, DELETE'.
	

]

{ #category : #tests }
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

{ #category : #tests }
MWModelsHandlerTest >> testPostWithMultipart [
	|  size content |
	client addPathSegment: 'models';
		headerAt: 'content-type' put: 'multipart/form-data';
		multiPartFormDataEntity.
	content := ZnEntity with: self MSEtestfile type: ZnMimeType applicationOctetStream .
	client request entity addPart: (ZnMimePart fieldName: 'mseFile' fileName: 'modelMSE.mse' entity: content).
	client request entity addPart: (ZnMimePart fieldName: 'nameModel' value: 'aMooseName') .
	size := server delegate mooseModelList size.
	client post.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson .
	self assert: (server delegate mooseModelList anySatisfy: [ :model | model mooseName = 'aMooseName' ]).
	self assert: server delegate mooseModelList size equals: size +1.
]

{ #category : #tests }
MWModelsHandlerTest >> testPostWithMultipartNameMissing [
	|  size content |
	client addPathSegment: 'models';
		headerAt: 'content-type' put: 'multipart/form-data';
		multiPartFormDataEntity.
	content := ZnEntity with: self MSEtestfile type: ZnMimeType applicationOctetStream .
	client request entity addPart: (ZnMimePart fieldName: 'mseFile' fileName: 'modelMSE.mse' entity: content).
	
	size := server delegate mooseModelList size.
	client post.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson .
	self assert: server delegate mooseModelList size equals: size +1.
]
