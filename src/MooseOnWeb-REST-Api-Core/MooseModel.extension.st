Extension { #name : #MooseModel }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
MooseModel >> objectWithID: elementID [
	self sourceLanguage mooseID = elementID ifTrue: [ 
		^self sourceLanguage
	] ifFalse: [  
		^super objectWithID: elementID
	]
	
]
