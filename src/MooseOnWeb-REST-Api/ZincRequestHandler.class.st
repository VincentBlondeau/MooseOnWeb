Class {
	#name : #ZincRequestHandler,
	#superclass : #ZnJSONRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
ZincRequestHandler class >> match: request [
	^ request uri firstPathSegment = 'modelRootZinc'
		ifTrue: [ request uri pathSegments allButFirst ]
		ifFalse: [ nil ]    
]

{ #category : #public }
ZincRequestHandler >> get [

	self flag: 'si la requete contient seulement / ca compte comme un caractere.... et size vaut 1...'.
	variables size == 0 ifTrue: [ self listMooseModels ] ifFalse: [ self listEntities ].
	
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
]

{ #category : #encapsulation }
ZincRequestHandler >> listEntities [
	self jsonResponse:  (self mooseEntitiesFromRootNumber: variables first asInteger)

]

{ #category : #encapsulation }
ZincRequestHandler >> listMooseModels [
	self jsonResponse: self mooseModelsAsCollection 
]

{ #category : #collectionsCreators }
ZincRequestHandler >> mooseEntitiesFromRootNumber: aNum [
	^(MooseModel root at: aNum) collect: [ :each | Dictionary new at:#mooseID put: each mooseID ; at:#name put: each name;yourself ] 
]

{ #category : #collectionsCreators }
ZincRequestHandler >> mooseModelsAsCollection [
	^ (MooseModel root
		collect: [ :each | 
			Dictionary new
				at: #mooseID put: each mooseID;
				at: #name put: each name;
				yourself ])" copyWith: (MooseModel superclass methodDict keys )".
]
