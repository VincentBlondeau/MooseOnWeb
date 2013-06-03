Class {
	#name : #RequestHandler,
	#superclass : #WARestfulHandler,
	#category : #'MooseOnWeb-REST-Api-SeasideOnly'
}

{ #category : #'as yet unclassified' }
RequestHandler class >> initialize [ 
	WAAdmin register: self at: 'modelRoot'
]

{ #category : #'as yet unclassified' }
RequestHandler >> listMooseModel [
	"renvoie un fichier brut nomé todo-api."

	<get>
	self requestContext
		respond: [ :response | 
			response contentType: 'application/json'.
			response
				nextPutAll:
					(String
						streamContents: [ :stream | 
							(NeoJSONWriter on: stream)
								nextPut:
									(MooseModel root
										collect: [ :each | 
											Dictionary new
												at: #mooseID put: each mooseID;
												at: #name put: each name;
												yourself ])	"replaceAll: Character cr with: Character" ]) ]
]

{ #category : #'as yet unclassified' }
RequestHandler >> mooseModelAt: aNum [
	<get>
	self requestContext
		respond: [ :response | 
			response contentType: 'text/json'.
			response
				nextPutAll:
					(String
						streamContents: [ :stream | 
							(NeoJSONWriter on: stream)
								nextPut:
									((MooseModel root at: aNum asInteger) entities
										collect: [ :each | 
											Dictionary new
												at: #mooseID put: each mooseID;
												at: #name put: each name;
												yourself ])	"replaceAll: Character cr with: Character" ]) ]
]

{ #category : #'as yet unclassified' }
RequestHandler >> mooseModelAt: aNum do: aMessage [
	<get>
	self requestContext
		respond: [ :response | 
			response contentType: 'text/json'.
			(MooseModel root at: aNum asInteger) entities do: [ :each | response nextPutAll: each mooseID asString, String crlf ] ]
		

]
