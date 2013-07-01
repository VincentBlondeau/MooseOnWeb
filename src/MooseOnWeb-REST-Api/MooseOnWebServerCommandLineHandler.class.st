Class {
	#name : #MooseOnWebServerCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
MooseOnWebServerCommandLineHandler class >> commandName [
	^ 'LaunchServer'
]

{ #category : #accessing }
MooseOnWebServerCommandLineHandler class >> description [
	^ 'A launcher for the MooseOnWebServer. Port can be specified by --port=8080'
]

{ #category : #activation }
MooseOnWebServerCommandLineHandler >> activate [
	| port |
	port := self arguments at: 1.
	MooseOnWebRestServerDelegate serverStartOn: port  asInteger.
]
