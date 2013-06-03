"
A ToDoHandlerTest is a test class for testing the behavior of ToDoHandler
"
Class {
	#name : #ToDoHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
ToDoHandlerTest >> setUp [ 
	"Launch the seaside server"
	server := ZnZincServerAdaptor port: 8089.
	server basicStart.
]

{ #category : #'as yet unclassified' }
ToDoHandlerTest >> tearDown [
	server basicStop.
]

{ #category : #'as yet unclassified' }
ToDoHandlerTest >> testSeasideServer [

	self assert: server isRunning.
	server stop.
	self assert: server isStopped.
]
