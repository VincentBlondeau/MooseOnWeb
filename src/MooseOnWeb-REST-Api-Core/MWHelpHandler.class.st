"
A HelpHandler is a handler for the GET /help request. It uses the #mooseonweb:name:description: pragma to create the online help.
So if you want to add a line to the help just add a pragma to your method.

The response will be in text/plain.
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

	(self isAcceptableRequest: request withAcceptedMimeType: { ZnMimeType textPlain }) ifTrue: [  
		self sendText: (String
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
				]
			])
		] ifFalse: [ self notAcceptable ]
]
