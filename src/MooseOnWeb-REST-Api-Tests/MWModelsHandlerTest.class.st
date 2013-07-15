Class {
	#name : #MWModelsHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testAccessibilityIDs [
	| model clientTemp |
	model := MooseModel root last. " to change"
	clientTemp := ZnClient new
		url: server localUrl;
		yourself.

	model entities
		do: [ :e | 
			clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , e mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson ].
		clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , model mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson.
]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testDelete [
	|  id |
	client addPathSegment: 'models'.
	id := MooseModel root last mooseID.
	client contents: id asString.
	client delete.
	
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType textPlain.
	

	self deny: ( (MooseModel root isEmpty not) and: [ MooseModel root last mooseID = id ]).
	self model install
]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testGet [
	| output root |
	client addPathSegment: 'models'.
	output := client get.
	root := MooseModel root.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson.
	self assert: (output includesSubstring: root mooseName).
	self deny: (output includesSubstring: '"id" : ',root mooseID asString,',').
	root entities
		do: [ :e | 
			self assert: (output includesSubstring: e mooseName).
			self assert: (output includesSubstring: e mooseID asString) ]
]

{ #category : #'as yet unclassified' }
MWModelsHandlerTest >> testPost [
	|  size |
	client addPathSegment: 'models'.
	size := MooseModel root size.
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
	

	self assert: MooseModel root size equals: size +1.
	MooseModel root remove: MooseModel root last.
]
