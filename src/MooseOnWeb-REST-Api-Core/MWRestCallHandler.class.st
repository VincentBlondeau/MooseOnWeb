"
A MooseOnWebRestCall is a handler for http requests. See MWRestServerDelegate to configure and launch the server.

This Rest handler extends the Zinc REST server to handle the client's requests. It's add some server features not implemented in Zinc-Rest like some messages with http codes or for using the moose objects.
 
All the responses are in JSON or text/plain. It uses an extension of Neo Json to serialize standard objects and mooseObjects. See MooseOnWebMoose-JSONWriter-Core package to have more details.

You can sent 2 types of ok reponses:
- with content: 
	- use sendJsonFrom: with a collection or a moose Entity in parameter or sendText: with a string as Parameter on a get request.
	- use created: with the newly created ressource on a post request
- with no content: use 
	- use okWithNoContent on a delete request or if the content of the message is empty.  The emptyOkResponse shouldn't be used...
	
If you want to throw an error use the methods in error handling protocol of this class or superclasses.
See http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for the standard of answer code

For the mime type matching you can send acceptMimeTypesFrom: containing: if you want to use the accept header or the message: acceptedMimeTypesFrom:  containing:  at: with the name of the header (e.g. 'content-type'). If your request can send only one type of data use isAcceptableRequest:  withAcceptedMimeType: answer true if the mimeType is accepted by the client.
	
None IV is declared in this classe and subclasses and that must not be changed.




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
	^self acceptedMimeTypesFrom: aRequest containing: aMimeTypeCollection at: 'Accept'
]

{ #category : #public }
MWRestCallHandler >> acceptedMimeTypesFrom: aRequest containing: aMimeTypeCollection at: aHeaderKey [
	| accept  |
	accept := (aRequest headers at: aHeaderKey ifAbsent: [ ^OrderedCollection new ]) asMWComposedMimeType.
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

{ #category : #'as yet unclassified' }
MWRestCallHandler >> listMooseProjects [
	^self delegate mooseProjectList
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

{ #category : #public }
MWRestCallHandler >> okWithNoContent [
	self
		response:
			(ZnResponse new
				statusLine: (ZnStatusLine code: 204);
				headers: ZnHeaders defaultRestResponseHeaders)
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
