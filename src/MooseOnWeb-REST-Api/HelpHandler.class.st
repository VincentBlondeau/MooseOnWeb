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
	<mooseonweb:'GET' name:'/help' description:'Liste des services disponibles' >
	answer  := Dictionary new.
	MooseOnWebRestCall allSubclasses do:[ :class | 
		(Pragma allNamed: #mooseonweb:name:description: in: class )
		do: [:p | answer at: (p arguments at:2) put: (p arguments at:3) ].].
	self sendJson.
]
