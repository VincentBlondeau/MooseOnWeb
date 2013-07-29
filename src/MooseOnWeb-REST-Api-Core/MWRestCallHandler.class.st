"
A MooseOnWebRestCall is xxxxxxxxx.

Instance Variables
	answer:		<Object>

answer
	- contains the Json formated data for being sent.

"
Class {
	#name : #MWRestCallHandler,
	#superclass : #ZnJSONRestCall,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWRestCallHandler class >> isAbstract [
	^ self = MWRestCallHandler  
]

{ #category : #public }
MWRestCallHandler >> acceptMimeTypesFrom: aRequest containing: aMimeTypeCollection [
	| accept  |
	accept := (aRequest headers at: 'Accept' ifAbsent: [ ^OrderedCollection new ]) asMWComposedMimeType.
	^ accept findMatchesWith: aMimeTypeCollection.
]

{ #category : #public }
MWRestCallHandler >> created: uri [
	^ (response := ZnResponse new)
		statusLine: ZnStatusLine created;
		headers: ZnHeaders defaultResponseHeaders;
		setLocation: uri;
		entity: (ZnEntity with: (MWNeoJSONWriter toString: uri) , String crlf type: ZnMimeType applicationJson);
		yourself
]

{ #category : #public }
MWRestCallHandler >> isAcceptableRequest: aRequest withAcceptedMimeType: aMimeTypeCollection [
	^ (self acceptMimeTypesFrom: aRequest containing: aMimeTypeCollection) isEmpty not
 
]

{ #category : #public }
MWRestCallHandler >> jsonResponse: data [
	| json |
	json := String
		streamContents: [ :stream | 
			(MWNeoJSONWriter on: stream)
				prettyPrint: true;
				newLine: String crlf;
				nextPut: data.
			stream crlf ].
	self response: (ZnResponse okRest: (ZnEntity with: json type: ZnMimeType applicationJson setCharSetUTF8))
]

{ #category : #accessing }
MWRestCallHandler >> listMooseModels [
	^ self delegate mooseModelList
]

{ #category : #'error handling' }
MWRestCallHandler >> notAcceptable [
	response := self delegate 
		errorResponse: request 
		code: 406 
		message: 'Not Acceptable'
]

{ #category : #'error handling' }
MWRestCallHandler >> notImplemented [
	response := self delegate 
		errorResponse: request 
		code: 501
		message: 'Not Implemented !'.
]

{ #category : #conversion }
MWRestCallHandler >> sendJsonFrom: aData [
	
	self jsonResponse: aData
]

{ #category : #conversion }
MWRestCallHandler >> sendText: aText [
	self response: (ZnResponse ok: (ZnEntity with: aText type: ZnMimeType textPlain)).
	
]

{ #category : #'error handling' }
MWRestCallHandler >> unsupportedMediaType [
	response := self delegate 
		errorResponse: request 
		code: 415
		message: 'Unsupported Media Type ', request accept.
]
