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
MWModelsHandler >> addModel: aMSEFile withName: aName [
	| model stream |
	model := MooseModel new.
	aMSEFile isEmptyOrNil ifTrue: [MWEmptyRessource signal].
	stream := ReadStream on: aMSEFile asString.
	model importFromMSEStream: stream.
	model name: (aName asString ifNil: [self defaultModelName ]).
	model isEmpty
		ifTrue: [ MWEmptyRessource signal ].
	self delegate mooseModelList add: model.
	^model
]

{ #category : #public }
MWModelsHandler >> contentMatching [
	^ {(ZnMimeType textPlain -> [ self addModel: self request contents withName: self defaultModelName ]).
	(ZnMimeType multiPartFormData -> [ 
			self
				addModel: (request entity partNamed: 'mseFile') contents
				withName: (request entity partNamed: 'nameModel' ifNone: [ self defaultModelName ]) contents ])} asDictionary
]

{ #category : #public }
MWModelsHandler >> defaultModelName [ 
	^ 'Imported Model-', ($- join: Date dateAndTimeNow)
]

{ #category : #public }
MWModelsHandler >> delete [
	<mooseonweb: 'DELETE' name: '/models?id=<mooseID>' description: 'Delete a moose model knowing its ID'>
	| id |
	[ 
	id := (self request uri queryAt: 'id') ifNil: [ MWRessourceNotFound signalFor: self request contents ].
	self deleteModel: id asInteger.
	self okWithNoContent .
	] on: MWRessourceNotFound do: [ :ex | self notFound ] 
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
	(self isAcceptableRequest: request withAcceptedMimeType: { ZnMimeType applicationJson  }) ifTrue: [  
	 	self sendJsonFrom: self listMooseModels ] ifFalse: [ self notAcceptable ]
	
]

{ #category : #public }
MWModelsHandler >> options [
	self response: (
		ZnResponse new
		statusLine: (ZnStatusLine code: 204);	"No content response"
		headers:
				(ZnHeaders
						defaultRestResponseHeaders
						at: 'Access-Control-Allow-Methods' put: 'POST, GET, DELETE';
						yourself);				
		yourself)
]

{ #category : #public }
MWModelsHandler >> post [
	<mooseonweb: 'POST' name: '/models' description: 'Create a new moose model from a MSE file (works with text/plain or multipart/form'>
	| model contentType |
	(self isAcceptableRequest: request withAcceptedMimeType: {ZnMimeType applicationJson . ZnMimeType textPlain})
		ifTrue: [ 
			[[ 
				contentType := (self acceptedMimeTypesFrom: request containing: { ZnMimeType textPlain . ZnMimeType multiPartFormData } at: 'content-type' )first.
				model := (self contentMatching at: contentType) value.
				self created: '/entities/' , model mooseID asString ]
			on: MWEmptyRessource  
			do: [ :e | self badRequest: 'MSE file expected' ]]
			on: FMSyntaxError
			do: [ :e | self badRequest: 'MSE valid file expected' ]
		]
		ifFalse: [ self notAcceptable ]
]
