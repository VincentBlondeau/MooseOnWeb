"
A HelpHandler is a catcher for the GET help request.

Instance Variables

"
Class {
	#name : #MWHelpHandler,
	#superclass : #MWRestCallHandler,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWHelpHandler class >> pattern [
	^ #('mooseOnWeb' 'help')
]

{ #category : #public }
MWHelpHandler >> get [ 
	<mooseonweb:'GET' name:'/help' description:'List the commands available' >
	"answer  := Dictionary new.
	MooseOnWebRestCall allSubclasses do:[ :class | 
		(Pragma allNamed: #mooseonweb:name:description: in: class )
		do: [:p | answer at: (p arguments at:2) put: (p arguments at:3) ].].
	"
	answer := String
		streamContents: [ :stream | 
			MWRestCallHandler allSubclasses do:[ :class | 
				(Pragma allNamed: #mooseonweb:name:description: in: class )
				do: [:p | 
					stream 
						nextPutAll: (p arguments first); 
						nextPutAll: ' : ';
						nextPutAll: (p arguments second);
						nextPutAll: ' : ';
						nextPutAll: (p arguments third);
						nextPutAll: String crlf 
				]
			].
				
		].
	self sendText.
]
