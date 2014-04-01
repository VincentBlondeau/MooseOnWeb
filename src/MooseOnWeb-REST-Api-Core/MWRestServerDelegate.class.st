"
A MooseOnWebRestServerDelegate is the entry point of the mooseOnWeb REST Api.

To launch the server (look class side): 
Do: MWRestServerDelegate serverStartOn: 8080 to launch the mooseOnWeb server on http://localhost:8080 with the models presents in MooseModels root.

If you want provide accesses to others models you can precise a MooseModels collections with the serverStartOn:models: method.
Only one server is runable by the Api so when you start a new server it will be stop the old.
If you want to stop the server, you can do: MWRestServerDelegate serverStop.
The server instance is accessible by 'server'. 

By default all exceptions are catched by Zinc-Rest and converted to html error codes. So for debugs it in pharo do:
MWRestServerDelegate server debugMode: true

To browse the api with a server go to: 
http://localhost:8080/mooseOnWeb/help
"
Class {
	#name : #MWRestServerDelegate,
	#superclass : #ZnJSONRestServerDelegate,
	#instVars : [
		'mooseModelList',
		'mooseProjectList'
	],
	#classVars : [
		'jsonWriterClass',
		'server'
	],
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWRestServerDelegate class >> jsonWriterClass [
	^ jsonWriterClass ifNil: [ jsonWriterClass := MWNeoJSONWriter ]
]

{ #category : #accessing }
MWRestServerDelegate class >> jsonWriterClass: aClass [
	jsonWriterClass := aClass
]

{ #category : #accessing }
MWRestServerDelegate class >> server [
	^server
]

{ #category : #managing }
MWRestServerDelegate class >> serverStartOn: port [
	self serverStartOn: port models: MooseModel root entities
]

{ #category : #managing }
MWRestServerDelegate class >> serverStartOn: port models: aMooseModelCollection [
	self server
		ifNotNil: [ 
			self server isRunning
				ifTrue: [ self serverStop ] ].
	server := ZnServer startOn: port.
	server
		delegate:
			(self new
				mooseModelList: aMooseModelCollection;
				yourself).
	server register
]

{ #category : #managing }
MWRestServerDelegate class >> serverStartOn: port projects: aProjectCollection [
	self server
		ifNotNil: [ 
			self server isRunning
				ifTrue: [ self serverStop ] ].
	server := ZnServer startOn: port.
	server
		delegate:
			(self new
				mooseModelList: (Array with: aProjectCollection first latestGeneratedVersion mooseModel);
				mooseProjectList: aProjectCollection;
				yourself).
	server register
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

{ #category : #'as yet unclassified' }
MWRestServerDelegate >> mooseModelList [
	^ mooseModelList
]

{ #category : #'as yet unclassified' }
MWRestServerDelegate >> mooseModelList: aCollectionOfMooseModels [
	mooseModelList := aCollectionOfMooseModels
]

{ #category : #accessing }
MWRestServerDelegate >> mooseProjectList [
	
	^ mooseProjectList
]

{ #category : #accessing }
MWRestServerDelegate >> mooseProjectList: anObject [
	
	mooseProjectList := anObject
]
