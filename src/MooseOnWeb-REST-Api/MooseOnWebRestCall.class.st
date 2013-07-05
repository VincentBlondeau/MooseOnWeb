"
A MooseOnWebRestCall is xxxxxxxxx.

Instance Variables
	answer:		<Object>

answer
	- contains the Json formated data for being sent.

"
Class {
	#name : #MooseOnWebRestCall,
	#superclass : #ZnMooseJSONRestCall,
	#instVars : [
		'answer'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
MooseOnWebRestCall class >> isAbstract [
	^ self = MooseOnWebRestCall    
]

{ #category : #conversion }
MooseOnWebRestCall >> answer [
	^answer
]

{ #category : #conversion }
MooseOnWebRestCall >> sendJson [
	self jsonResponse: self answer	"aResult isMooseEntity
		ifTrue: [ self jsonResponseFromJson: aResult asJson ]
		ifFalse: [ self jsonResponse: aResult ]"
]

{ #category : #conversion }
MooseOnWebRestCall >> sendText [	
	self response: (ZnResponse ok: (ZnEntity with: self answer type: ZnMimeType textPlain)).
	
]
