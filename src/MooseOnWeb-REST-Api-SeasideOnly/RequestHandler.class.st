Class {
	#name : #RequestHandler,
	#superclass : #WARestfulHandler,
	#category : #'MooseOnWeb-REST-Api-SeasideOnly'
}

{ #category : #'as yet unclassified' }
RequestHandler class >> initialize [ 
	"WAAdmin register: self at: 'modelRoot'"
]

{ #category : #'as yet unclassified' }
RequestHandler >> listMooseModel [
   <get>
	"renvoie un fichier brut nomé todo-api."
	|i|
	i:=1.
	 self requestContext respond: [ :response |
       MooseModel root do: [ :each | 
         response contentType: 'text/plain'.
         response
            nextPutAll: i asString, ' : ', each name, String crlf. i := i+1 ] ]
]

{ #category : #'as yet unclassified' }
RequestHandler >> mooseModelAt: aNum [
	<get>
	self requestContext
		respond: [ :response | 
			response contentType: 'text/json'.
			(MooseModel root at: aNum asInteger) entities do: [ :each | response nextPutAll: each mooseID asString, String crlf ] ]
]

{ #category : #'as yet unclassified' }
RequestHandler >> mooseModelAt: aNum do: aMessage [
	<get>
	self requestContext
		respond: [ :response | 
			response contentType: 'text/json'.
			(MooseModel root at: aNum asInteger) entities do: [ :each | response nextPutAll: each mooseID asString, String crlf ] ]
		

]
