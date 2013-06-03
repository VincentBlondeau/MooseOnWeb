Class {
	#name : #ZincRequestHandler,
	#superclass : #ZnJSONRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
ZincRequestHandler class >> match: request [
	^ request uri firstPathSegment = 'modelRoot'
		ifTrue: [ request uri pathSegments allButFirst ]
		ifFalse: [ nil ]    
]

{ #category : #public }
ZincRequestHandler >> get [
	variables size == 0
		ifTrue: [ self listMooseModels ]
		ifFalse: [ [self listEntities] on: Error do: [self badRequest: 'Cannot access !'] ] .
	"
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

{ #category : #encapsulation }
ZincRequestHandler >> listEntities [
	self jsonResponseFromJson:  (MooseModel root at: variables first asInteger) asJson

]

{ #category : #encapsulation }
ZincRequestHandler >> listMooseModels [
	self jsonResponseFromJson: MooseModel root asJson
]
