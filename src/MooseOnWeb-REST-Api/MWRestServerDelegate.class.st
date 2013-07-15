"
A MooseOnWebRestServerDelegate is the entry point of the mooseOnWeb REST Api.

Instance Variables

"
Class {
	#name : #MWRestServerDelegate,
	#superclass : #ZnJSONRestServerDelegate,
	#classVars : [
		'server'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
MWRestServerDelegate class >> server [
	^server
]

{ #category : #managing }
MWRestServerDelegate class >> serverStartOn: port [
	server := ZnServer startOn: port.
	server delegate: self class new.
	server register.
]

{ #category : #managing }
MWRestServerDelegate class >> serverStop [
	server stop
]

{ #category : #'initialize-release' }
MWRestServerDelegate >> handleRequest: request [
	| call |
	(call := self match: request) 
		ifNil: [ ^ self noHandlerFound: request ].
	(self authenticate: call)
		ifFalse: [ ^ self callUnauthorized: request ].
	^ [ self execute: call ]
		on: Error
		do: [ :exception | 
			request server debugMode
				ifTrue: [ exception pass ]
				ifFalse: [ 
					request server logServerError: exception.
					self serverError: request exception: exception ] ]
]

{ #category : #'initialize-release' }
MWRestServerDelegate >> initialize [ 
	self uriSpace: ZnCallHierarchyRestUriSpace new.
	self uriSpace rootClass: MWRestCallHandler
]
