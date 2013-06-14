Class {
	#name : #EntitiesHandlerWithIDServerTest,
	#superclass : #MooseOnWebServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> setUp [
	super setUp.
	client addPathSegment: #entities
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testEntityAccessibilityIDs [
	|  clientTemp |
	
	clientTemp := ZnClient new
		url: server localUrl;
		yourself.
		
	MooseModel root last do:[:entity|
	entity allDeclaredProperties
		do: [ :p | 
			| res |
			res := entity perform: p implementingSelector.
			res isMooseEntity ifTrue: [
			clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , res mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson ]].
		
	clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , entity mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson].
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGet [
	"teste la requete get"
	| output model |

	self assert: (MooseModel root size) > 0.
	model := MooseModel root last.
		
	
	client addPathSegment: model mooseID asString.
	output := client get.
	self assert: client isSuccess.
	
	model entities do: [:e |self assert: (output includesSubstring: e mooseID asString )].
	self assert: (output includesSubstring:  model mooseID asString).
	self assert: (output includesSubstring:  model mooseName).
	self assert: client response statusLine equals: ZnStatusLine ok.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
"	self assert: output equals: MooseModel root asJson."

	

	
	

]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetEntity [
	"teste la requete get"

	| entity output |
	self assert: MooseModel root size > 0.
	entity := MooseModel root last at: 1.
	client addPathSegment: entity mooseID asString.
	output := client get.
	self assert: client isSuccess.
	self assert: (output includesSubstring: entity mooseID asString).
	self assert: (output includesSubstring: entity mooseName).
	entity allDeclaredProperties
		do: [ :p | 
			| res |
			res := entity perform: p implementingSelector.
			res isNil not
				ifTrue: [ 
					self assert: (output includesSubstring: '"',(p implementingSelector),'"').
					self deny: res isMooseGroup.
					res isMooseEntity
						ifTrue: [ 
							self assert: (output includesSubstring: res mooseID asString).
							self assert: (output includesSubstring: res mooseName) ] ] ].
	self assert: (output includesSubstring: '[').
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetExecuteAction [
	"teste la requete get"

	| model output |
	self assert: MooseModel root size > 0.
	model := MooseModel root last.
	client addPathSegment: model mooseID asString.
	client queryAt: 'action' put: 'allClasses'.
	output := client get.
	self assert: client isSuccess.
	self deny: (output includesSubstring: model allClasses mooseID asString).
	self assert: (output includesSubstring: model allClasses mooseName).
	model allClasses entities
		do: [ :p | 
			self assert: (output includesSubstring: '"' , p mooseName , '"').
			self assert: (output includesSubstring: p mooseID asString ) ].
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetExecuteAction2 [
	"teste la requete get"

	| model |
	self assert: MooseModel root size > 0.
	model := MooseModel root last.
	client addPathSegment: model mooseID asString.
	client queryAt: 'action' put: 'doesnt exists !'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine badRequest.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetInvalidID [
	"teste la requete get"

	client addPathSegment: '0'.
	client get.
	self deny: client isSuccess.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetListAction [
	"teste la requete get"

	| model output |
	self assert: MooseModel root size > 0.
	model := MooseModel root last.
	client addPathSegment: model mooseID asString.
	client queryAt: 'q' put: 'action'.
	output := client get.
	self assert: client isSuccess.
	model allDeclaredProperties do: [ :p | self assert: (output includesSubstring: '"' , p implementingSelector , '"') ].
	self assert: (output includesSubstring: '[').
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetListAction2 [
	"teste la requete get"

	| model |
	self assert: MooseModel root size > 0.
	model := MooseModel root last.
	client addPathSegment: model mooseID asString.
	client queryAt: 'q' put: 'actions'.
	client get.

	self assert: client response statusLine equals: ZnStatusLine badRequest .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetSearch [
	"teste la requete get"

	| model output |
	self assert: MooseModel root size > 0.
	model := MooseModel root last.
	client addPathSegment: model mooseID asString.
	client queryAt: 'q' put: 'search'.
	client queryAt: 'mooseName' put: 'Smalltalk'.
	output := client get.
	self assert: client isSuccess.
	model entities
		do: [ :e | 
			e mooseName = 'Smalltalk'
				ifTrue: [ 
					self assert: (output includesSubstring: e mooseName).
					self assert: (output includesSubstring: e mooseID asString) ] ].
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testGetSearchWithoutParameters [
	"teste la requete get"

	| model |
	self assert: MooseModel root size > 0.
	model := MooseModel root last.
	client addPathSegment: model mooseID asString.
	client queryAt: 'q' put: 'search'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine badRequest .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
EntitiesHandlerWithIDServerTest >> testModelAccessibilityIDs [
	| model clientTemp |
	model := MooseModel root last.
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
	self assert: (MooseModel root size) > 0.
	
		
	
	
	

	
	

]