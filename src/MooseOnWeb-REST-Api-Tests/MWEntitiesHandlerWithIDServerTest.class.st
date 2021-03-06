"
A MWEntitiesHandlerWithIDServerTest is a test unit for MWEntitiesHandlerWithID.
"
Class {
	#name : #MWEntitiesHandlerWithIDServerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> setUp [
	super setUp.
	client headerAt: 'Accept' put: 'application/json'; addPathSegment: #entities
]

{ #category : #tests }
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

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetANonExistingQuery [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'dontExists'.
	client get.

	self assert: client response statusLine equals: ZnStatusLine notFound .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #tests }
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

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetEntityActionResultAccessID [
	|  clientTemp |
	
	clientTemp := ZnClient new
		url: server localUrl;
		yourself.
		
	self modelTest do:[:entity| 
		(entity allDeclaredProperties reject: [ :p | {#accesses . #accessors .  #sourceAnchor}anySatisfy: [ :symbol | p implementingSelector = symbol ]])
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

{ #category : #tests }
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

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetExecuteActionExistingButNotAllowed [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: 'browse'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self deny: client response statusLine = ZnStatusLine internalServerError.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #tests }
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

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetExecuteComplexAction [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: '(allClasses,allPackages)!size,allClasses*allPackages,allMethods!(name,cyclomaticComplexity)'.
	client get.
	self assert: client isSuccess.
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 
]

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetExecutingAnNonExistingAction [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'action' put: 'doesnt exists !'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetInvalidID [

	client addPathSegment: '0'.
	client get.
	self deny: client isSuccess.
	self assert: client response statusLine equals: ZnStatusLine notFound.
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetListAction [

	|  output |
	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'actions'.
	output := client get.
	self assert: client isSuccess.
	self modelTest allDeclaredProperties do: [ :p | self assert: (output includesSubstring: '"' , p implementingSelector , '"') ].
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8
]

{ #category : #tests }
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
	self assert: self rootModelForTestServer isEmpty not
	
		
	
	
	

	
	

]

{ #category : #tests }
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

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetSearchLt1 [

	| output |
	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'search'.
	client queryAt: 'key' put: 'cyclomaticComplexity'.
	client queryAt: 'op' put: 'lt'.
	client queryAt: 'value' put: '10'.
	client queryAt: 'onAction' put: 'allMethods'.
	output := client get.
	self assert: client isSuccess.
	self modelTest allMethods
		do: [ :e | |cyclo|
			cyclo := e cyclomaticComplexity.
			 cyclo < 10
				ifTrue: [ 
					self assert: (output includesSubstring: e mooseName asString).
					self assert: (output includesSubstring: e mooseID asString) ]
				ifFalse: [
					self deny: (output includesSubstring: e mooseName).
					self deny: (output includesSubstring: e mooseID asString)
					]].
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8 
]

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetSearchLt2 [
	| output |
	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'search'.
	client queryAt: 'key' put: 'cyclomaticComplexity'.
	client queryAt: 'op' put: 'lt'.
	client queryAt: 'value' put: '2'.
	client queryAt: 'onAction' put: 'allMethods'.
	output := client get.
	self assert: client isSuccess.
	self modelTest allMethods
		do: [ :e | 
			| cyclo |
			cyclo := e cyclomaticComplexity.
			cyclo < 2
				ifTrue: [ 
					self assert: (output includesSubstring: e mooseName).
					self assert: (output includesSubstring: '"id" : ' , e mooseID asString , ',') ]
				ifFalse: [ 
					self deny: (output includesSubstring: e mooseName).
					self deny: (output includesSubstring: '"id" : ' , e mooseID asString , ',') ] ].
	self assert: client response headers contentType equals: ZnMimeType applicationJson setCharSetUTF8
]

{ #category : #tests }
MWEntitiesHandlerWithIDServerTest >> testGetSearchWithoutParameters [

	client addPathSegment: self modelTest mooseID asString.
	client queryAt: 'q' put: 'search'.
	client get.
	self assert: client response statusLine equals: ZnStatusLine notFound .
	self assert: client response headers contentType equals: ZnMimeType applicationJson
]
