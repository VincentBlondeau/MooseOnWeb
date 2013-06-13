"
A HelpHandler is a catcher for the GET help request.

Instance Variables

"
Class {
	#name : #HelpHandler,
	#superclass : #MooseOnWebRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #'as yet unclassified' }
HelpHandler class >> pattern [
	^ #('mooseOnWeb' 'help')
]

{ #category : #'as yet unclassified' }
HelpHandler >> get [ 
	self notImplemented .
]
