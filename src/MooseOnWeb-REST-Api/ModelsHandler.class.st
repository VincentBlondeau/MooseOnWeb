"
A ModelsHandler is a catcher for the GET models request.
"
Class {
	#name : #ModelsHandler,
	#superclass : #MooseOnWebRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
ModelsHandler class >> pattern [
	^ #('mooseOnWeb' 'models')
]

{ #category : #public }
ModelsHandler >> delete [
	"<mooseonweb: 'POST' name: '/models' description: 'Delete a moose model'>
	| id model |
	[ 
		id := self request contents asInteger.
		model := MooseModel root select: [ :m | m mooseID = id ].
		model ifEmpty: [ RessourceNotFound signal ].
		(model at: 1) remove.
		self emptyOkResponse.
	]
		on: Error
		do: [ self badRequest: 'Not deleted' ]."
	self notImplemented 
]

{ #category : #public }
ModelsHandler >> get [
	<mooseonweb:'GET' name:'/models' description:'Lists the models provided  by the API' >
	"the method asZnMimeType doesn't work properly !"
	
	"request accept asZnMimeType = ZnMimeType applicationJson ifTrue: [ "
 	self listMooseModels." ] ifFalse:  [ self unsupportedMediaType ]"
	self sendJson 
]

{ #category : #operations }
ModelsHandler >> listMooseModels [
	answer:= MooseModel root
]

{ #category : #public }
ModelsHandler >> post [
	"<mooseonweb: 'POST' name: '/models' description: 'Create a new moose model from a MSE file'>
	| data model stream id |
	[ 
	data := self request contents.
	model := MooseModel new.
	stream := ReadStream on: data.
	model importFromMSEStream: stream.
	model name: 'Imported Model'.
	model isEmpty ifTrue: [ EmptyRessource signal ].
	id := model install mooseID.
	self created: '/entities/' , id asString ]
		on: Error
		do: [ self badRequest: 'MSE file expected' ]."
	self notImplemented 
]
