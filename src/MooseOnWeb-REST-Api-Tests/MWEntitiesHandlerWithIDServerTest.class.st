Class {
	#name : #MWEntitiesHandlerWithIDServerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> setUp [
	super setUp.
	client addPathSegment: #entities
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGet [
	"teste la requete get"
	| output |	
	
	client addPathSegment: self modelTest mooseID asString.
	output := client get.
	self assert: client isSuccess.
	
	self modelTest entities do: [:e |self assert: (output includesSubstring: e mooseID asString )].
	self assert: (output includesSubstring:  self modelTest mooseID asString).
	self assert: (output includesSubstring:  self modelTest mooseName).
	self assert: client response statusLine equals: ZnStatusLine ok.
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8


	

	
	

]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetANonExistingQuery [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'dontExists'.
	client get.

	self assert: client response statusLine equals: ZnStatusLine notFound .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetEntity [
	"teste la requete get"

	| entity output stream |
	entity := self modelTest first.
	client addPathSegment: entity mooseID asString.
	output := client get.
	self assert: client isSuccess.
	self assert: (output includesSubstring: entity mooseID asString).
	stream := WriteStream with: ''.
	entity mooseDisplayStringOn: stream.
	
	self assert: (output includesSubstring: stream contents).
	entity allDeclaredProperties
		do: [ :p | 
			| res |
			res := entity perform: p implementingSelector.
			(res isNil not and: [ ((res isKindOf: Collection) and: [ res isEmpty]) not ])
				ifTrue: [ 
					self assert: (output includesSubstring: '"',(p implementingSelector),'"').
					self deny: res isMooseGroup.
					res isMooseEntity
						ifTrue: [ 
							self assert: (output includesSubstring: res mooseID asString).
							self assert: (output includesSubstring: res mooseName) ] ] ].
	self assert: (output includesSubstring: '{').
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetEntityActionResultAccessID [
	|  clientTemp |
	
	clientTemp := ZnClient new
		url: server localUrl;
		yourself.
		
	self modelTest do:[:entity| 
		entity allDeclaredProperties
		do: [ :p | 
			| res |
			res := entity perform: p implementingSelector.
			res isMooseEntity ifTrue: [
			clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , res mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 ]].
		
	clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , entity mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8].
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetExecuteAction [
	"teste la requete get"

	| output |

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: 'allClasses'.
	output := client get.
	self assert: client isSuccess.
	self deny: (output includesSubstring: self modelTest allClasses mooseID asString).
	self assert: (output includesSubstring: self modelTest allClasses mooseName ).
	self modelTest allClasses entities
		do: [ :p | 
			self assert: (output includesSubstring: '"' , p mooseName , '"').
			self assert: (output includesSubstring: p mooseID asString ) ].
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetExecuteActionExistingButNotAllowed [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: 'browse'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self deny: client response statusLine = ZnStatusLine internalServerError.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetExecuteActions [

	| output |
	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: 'allClasses,numberOfPackages'.
	output := client get.
	self assert: client isSuccess.
	self assert: (output includesSubstring: '"name" : "All famixclasses (46)"').
	self assert: (output includesSubstring: '7').
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetExecuteComplexAction [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: '(allClasses,allPackages)!size,allClasses*allPackages,allMethods!(name,cyclomaticComplexity)'.
	client get.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetExecutingAnNonExistingAction [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: 'doesnt exists !'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetInvalidID [

	client addPathSegment: '0'.
	client get.
	self deny: client isSuccess.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetListAction [

	|  output |
	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'actions'.
	output := client get.
	self assert: client isSuccess.
	self modelTest allDeclaredProperties do: [ :p | self assert: (output includesSubstring: '"' , p implementingSelector , '"') ].
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetModelEntitiesAccessID [
	| clientTemp |
	clientTemp := ZnClient new
		url: server localUrl;
		yourself.

	self modelTest entities
		do: [ :e | 
			clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , e mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 ].
	clientTemp get: (ZnUrl fromString: 'mooseOnWeb/entities/' , self modelTest mooseID asString).
			self assert: clientTemp isSuccess.
			self assert: clientTemp response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 .
	self assert: self rootModelForTestServer size > 0
	
		
	
	
	

	
	

]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetSearch [

	| output |
	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'search'.
	client queryAt: 'key' put: 'fanIn'.
	client queryAt: 'op' put: 'eq'.
	client queryAt: 'value' put: '5'.
	client queryAt: 'onAction' put: 'allClasses'.
	output := client get.
	self assert: client isSuccess.
	self modelTest allClasses
		do: [ :e | 
			e fanIn = '5'
				ifTrue: [ 
					self assert: (output includesSubstring: e mooseName).
					self assert: (output includesSubstring: e mooseID asString) ] ].
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 
]

{ #category : #testing }
MWEntitiesHandlerWithIDServerTest >> testGetSearchWithoutParameters [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'search'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notFound .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]
