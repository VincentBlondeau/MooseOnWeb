Class {
	#name : #ZincRequestHandler,
	#superclass : #ZnAutoMatchedRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
ZincRequestHandler class >> match: request [
	^ request uri firstPathSegment = 'modelRootZinc'
		ifTrue: [ request uri pathSegments allButFirst ]
		ifFalse: [ nil ]    
]

{ #category : #'as yet unclassified' }
ZincRequestHandler >> get [

	variables size == 0 ifTrue: [ self listMooseModels ] ifFalse: [  ].
	
	"
	objectUri := '/modelRootZinc/{1}' format: { variables first }.
	
	data := self delegate storage at: objectUri ifAbsent: [ ^ self notFound ].
	
	
	self jsonResponse: data."
	

"	i:=1.
	 self requestContext respond: [ :response |
       MooseModel root do: [ :each | 
         response contentType: 'text/plain'.
         response
            nextPutAll: i asString, ' : ', each name, String crlf. i := i+1 ] ].
	
	self response: (ZnResponse ok: (ZnEntity with: 1 asString))"
]

{ #category : #'as yet unclassified' }
ZincRequestHandler >> listMooseModels [
	self
		response:
			(ZnResponse
				ok:
					(ZnEntity
						with: self mooseModelsAsCollection asString))
]

{ #category : #'as yet unclassified' }
ZincRequestHandler >> mooseModelsAsCollection [
	^MooseModel root collect: [ :each | each mooseID asString , ' : ' , each name , String crlf ] 
]
