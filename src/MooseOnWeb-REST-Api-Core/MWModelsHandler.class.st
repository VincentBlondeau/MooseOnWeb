"
A ModelsHandler is a catcher for the GET models request.
"
Class {
	#name : #MWModelsHandler,
	#superclass : #MWRestCallHandler,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWModelsHandler class >> pattern [
	^ #('mooseOnWeb' 'models')
]

{ #category : #public }
MWModelsHandler >> delete [
	<mooseonweb: 'DELETE' name: '/models' description: 'Delete a moose model (put the id in the body of the request)'>
	| id model |
	[ 
		self flag: 'What we do if the same model is loaded several times ?'.
		id := self request contents asInteger.
		model := MooseModel root select: [ :m | m mooseID = id ].
		model ifEmpty: [ MWRessourceNotFound signal ].
		model size > 1 ifTrue: [ Error signal ].
		model first remove.
		self emptyOkResponse.
	]
		on: Error
		do: [ self badRequest: 'Not deleted' ].
]

{ #category : #public }
MWModelsHandler >> get [
	<mooseonweb:'GET' name:'/models' description:'Lists the models provided  by the API' >
	"the method asZnMimeType doesn't work properly !"
	
	"request accept asZnMimeType = ZnMimeType applicationJson ifTrue: [ "
 	self sendJsonFrom: self listMooseModels." ] ifFalse:  [ self unsupportedMediaType ]"
	
]

{ #category : #public }
MWModelsHandler >> post [
	<mooseonweb: 'POST' name: '/models' description: 'Create a new moose model from a MSE file'>
	| data model stream id |
	self flag: 'Remove Notification on the next version'.
	[ 
	data := self request contents.
	model := MooseModel new.
	stream := ReadStream on: data.
	[ model importFromMSEStream: stream ]
		on: Notification
		do: [ :e | e resume ].
	model name: 'Imported Model'.
	model isEmpty
		ifTrue: [ MWEmptyRessource signal ].
	[ id := model install mooseID ]
		on: Notification
		do: [ :e | e resume ].
	self created: '/entities/' , id asString ]
		on: Error
		do: [ :e | self badRequest: 'MSE file expected' ]
]
