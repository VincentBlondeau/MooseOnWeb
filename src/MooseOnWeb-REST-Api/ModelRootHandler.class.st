Class {
	#name : #ModelRootHandler,
	#superclass : #ZnJSONRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
ModelRootHandler class >> match: request [
	^ request uri firstPathSegment = 'modelRoot'
		ifTrue: [ request uri pathSegments allButFirst ]
		ifFalse: [ nil ]    
]

{ #category : #operations }
ModelRootHandler >> applyMethod [
	| resultat |
	resultat := self model perform: self operation.
	self send: resultat.
]

{ #category : #public }
ModelRootHandler >> get [
	[variables size == 0
		ifTrue: [ self listMooseModels ].
	variables size == 1	
		ifTrue: [ self listMethods ].
				
	variables size == 2 
		ifTrue:[ self applyMethod ].
	variables size > 2 ifTrue: [self badRequest: 'Bad request !']
	]on: Error
				do: [ self badRequest: 'Bad request !' ] .
		
		


	
	"	[self listEntities]"
	"
	objectUri := '/modelRootZinc/{1}' format: { }.
	
	data := self delegate storage at: objectUri ifAbsent: [ ^ self notFound ].
	
	
	self jsonResponse: data."
	"	
	i:=1.
	 self requestContext respond: [ :response |
       MooseModel root do: [ :each | 
         response contentType: 'text/plain'.
         response
            nextPutAll: i asString, ' : ', each name, String crlf. i := i+1 ] ].
	
	self response: (ZnResponse ok: (ZnEntity with: 1 asString))"
		"	[self listEntities]"	"
	objectUri := '/modelRootZinc/{1}' format: { }.
	
	data := self delegate storage at: objectUri ifAbsent: [ ^ self notFound ].
	
	
	self jsonResponse: data."	"	
	i:=1.
	 self requestContext respond: [ :response |
       MooseModel root do: [ :each | 
         response contentType: 'text/plain'.
         response
            nextPutAll: i asString, ' : ', each name, String crlf. i := i+1 ] ].
	
	self response: (ZnResponse ok: (ZnEntity with: 1 asString))"
]

{ #category : #operations }
ModelRootHandler >> listEntities [
	self flag: 'not used'.
	self send: self model
]

{ #category : #operations }
ModelRootHandler >> listMethods [
	| list |
	list := self model allPropertySelectors values.
	self
		send:
			(list
				select: [ :aSelector | 
					| r |
					r := self model perform: aSelector.
					r isMooseGroup
						ifTrue: [ r isEmpty not ]
						ifFalse: [ r isNil not ] ])
]

{ #category : #operations }
ModelRootHandler >> listMooseModels [
	self send: MooseModel root
]

{ #category : #accessing }
ModelRootHandler >> model [
	^MooseModel root at: variables first asInteger
]

{ #category : #accessing }
ModelRootHandler >> operation [
"faire la verification"
	^(variables at:2) asSymbol
			"self allPropertySelectors  do: [:aSelector |
		(entity perform: aSelector) isNil ifFalse: [result add: aSelector].
		]." 
]

{ #category : #conversion }
ModelRootHandler >> send: aResult [
	aResult isMooseEntity
		ifTrue: [ self jsonResponseFromJson: aResult asJson ]
		ifFalse: [ self jsonResponse: aResult ]
]
