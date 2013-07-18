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
	| id |
	id := self request contents asInteger ifNil: [ MWRessourceNotFound signalFor: self request contents ].
	self deleteModel: id.
	self emptyOkResponse.

]

{ #category : #public }
MWModelsHandler >> deleteModel: id [
	| modelsToDelete |
	modelsToDelete := self delegate mooseModelList select: [ :m | m mooseID = id ].
	modelsToDelete ifEmpty: [ MWRessourceNotFound signalFor: id ].
	self delegate mooseModelList removeAllSuchThat: [ :m | m mooseID = id ] 
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
	model importFromMSEStream: stream .
	model name: 'Imported Model'.
	model isEmpty
		ifTrue: [ MWEmptyRessource signal ].
	self delegate mooseModelList add: model.
	id := model mooseID.
	self created: '/entities/' , id asString ]
		on: Error
		do: [ :e | self badRequest: 'MSE file expected' ]
]
