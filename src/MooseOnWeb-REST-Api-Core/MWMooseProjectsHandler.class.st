"
A ModelsHandler is a catcher for the GET /mooseProjects request. 
"
Class {
	#name : #MWMooseProjectsHandler,
	#superclass : #MWRestCallHandler,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #'as yet unclassified' }
MWMooseProjectsHandler class >> pattern [
	^ #('mooseOnWeb' 'mooseProjects')
]

{ #category : #'as yet unclassified' }
MWMooseProjectsHandler >> get [
	<mooseonweb:'GET' name:'/mooseProjects' description:'Lists the mooseProjects provided  by the API' >
	"the method asZnMimeType doesn't work properly !"
	(self isAcceptableRequest: request withAcceptedMimeType: { ZnMimeType applicationJson  }) ifTrue: [  
	 	self sendJsonFrom: self listMooseProjects ] ifFalse: [ self notAcceptable ]
	
]

{ #category : #'as yet unclassified' }
MWMooseProjectsHandler >> listMooseProjects [
	^self delegate mooseProjectList
]
