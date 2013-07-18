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
