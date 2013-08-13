"
A MWRessourceNotFound is risen when the provided Id doesn't match to an existing object.
"
Class {
	#name : #MWRessourceNotFound,
	#superclass : #MWError,
	#instVars : [
		'entityId'
	],
	#category : #'MooseOnWeb-REST-Api-Exceptions'
}

{ #category : #signalling }
MWRessourceNotFound class >> signalFor: anEntityId [ 	
	self new entityId: anEntityId; signal
]

{ #category : #accessing }
MWRessourceNotFound >> entityId [
	^ entityId
]

{ #category : #accessing }
MWRessourceNotFound >> entityId: anObject [
	entityId := anObject
]
