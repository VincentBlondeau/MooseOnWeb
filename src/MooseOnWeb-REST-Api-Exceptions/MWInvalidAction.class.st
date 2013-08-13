"
A MWInvalidAction is raise when the action we want to perform an an object is not allowed or possible.
"
Class {
	#name : #MWInvalidAction,
	#superclass : #MWError,
	#instVars : [
		'actionName'
	],
	#category : #'MooseOnWeb-REST-Api-Exceptions'
}

{ #category : #signalling }
MWInvalidAction class >> signalFor: anActionName [
	self new actionName: anActionName; signal
]

{ #category : #accessing }
MWInvalidAction >> actionName [
	^ actionName
]

{ #category : #accessing }
MWInvalidAction >> actionName: anObject [
	actionName := anObject
]
