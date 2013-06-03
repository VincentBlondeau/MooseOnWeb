Class {
	#name : #ToDoHandler,
	#superclass : #WARestfulHandler,
	#instVars : [
		'data'
	],
	#category : #'MooseOnWeb-REST-Api-SeasideOnly'
}

{ #category : #'class initialization' }
ToDoHandler class >> initialize [ 
	WAAdmin register: self at: 'todo-api'
]

{ #category : #'as yet unclassified' }
ToDoHandler >> create [
	"en theorie ca marche..... la requete est bien reconnue car toto s'affiche"

	<post>
	self data: self requestContext request rawBody.
	Transcript show: 'POST'.
	Transcript show: self requestContext request rawBody.
	Transcript show: String cr.
	^ '<Debut>' , data asString , '<FIN>'
]

{ #category : #'class initialization' }
ToDoHandler >> data [
	^data
]

{ #category : #'class initialization' }
ToDoHandler >> data: aData [
	data := aData .
]

{ #category : #'as yet unclassified' }
ToDoHandler >> list [
	"renvoie un fichier brut nomé todo-api."

	<update>
	Transcript show: 'UPDATE'.
	^ String
		streamContents: [ :stream | 
			Object methods
				do: [ :each | 
					stream
						nextPutAll: each name;
						crlf ] ]	"html  heading level2; with: 'Méthodes'.
	classe methods do: [:each | 
		 html  heading level3; with: each name.
		 html paragraph: each comment asString]."
]

{ #category : #'as yet unclassified' }
ToDoHandler >> listv2 [
	"Cette balise signifie qu'il faut executer la requete sur GET. Il ne faut qu'une seule methode contenant la primitive."

	"retourne un champ lisible par le navigateur -> ie page html"

	<get>
	Transcript show: 'GET'.
	self requestContext
		respond: [ :response | 
			Object methods
				do: [ :each | 
					response contentType: 'text/plain'.
					response
						nextPutAll: each name;
						nextPutAll: String crlf ] ]
]
