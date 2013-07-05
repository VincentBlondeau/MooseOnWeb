"
A HelpHandler is a catcher for the GET help request.

Instance Variables

"
Class {
	#name : #HelpHandler,
	#superclass : #MooseOnWebRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
HelpHandler class >> pattern [
	^ #('mooseOnWeb' 'help')
]

{ #category : #public }
HelpHandler >> get [ 
	<mooseonweb:'GET' name:'/help' description:'List the commands available' >
	"answer  := Dictionary new.
	MooseOnWebRestCall allSubclasses do:[ :class | 
		(Pragma allNamed: #mooseonweb:name:description: in: class )
		do: [:p | answer at: (p arguments at:2) put: (p arguments at:3) ].].
	"
	answer := String
		streamContents: [ :stream | 
			MooseOnWebRestCall allSubclasses do:[ :class | 
				(Pragma allNamed: #mooseonweb:name:description: in: class )
				do: [:p | stream nextPutAll: (p arguments at:1), ' : ', (p arguments at:2), ' : ' , (p arguments at:3), String crlf  ].].
		].
	self sendText.
]
