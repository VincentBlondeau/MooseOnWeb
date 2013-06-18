"
A ZnMooseJSONRestCall is a REST handler. 
Extends the ZnJSONRestCall for use NeoJSONMooseWriter.

To launch the server : 

	server := ZnServer startOn: 8080.
	server delegate: MooseOnWebRestServerDelegate new.
	
to stop the server : 
	server stop.

See http://localhost:8080/mooseOnWeb/help for the services provideed by the Api

"
Class {
	#name : #ZnMooseJSONRestCall,
	#superclass : #ZnJSONRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #public }
ZnMooseJSONRestCall >> created: uri [
	^ (response := ZnResponse new)
		statusLine: ZnStatusLine created;
		headers: ZnHeaders defaultResponseHeaders;
		setLocation: uri;
		entity: (ZnEntity with: (NeoJSONMooseWriter toString: uri) , String crlf type: ZnMimeType applicationJson);
		yourself
]

{ #category : #accessing }
ZnMooseJSONRestCall >> jsonResponse: data [
	| json |
	json := String
		streamContents: [ :stream | 
			(NeoJSONMooseWriter on: stream)
				prettyPrint: true;
				newLine: String crlf;
				nextPut: data.
			stream crlf ].
	self response: (ZnResponse okRest: (ZnEntity with: json type: ZnMimeType applicationJson))
]

{ #category : #'error handling' }
ZnMooseJSONRestCall >> notImplemented [
	response := self delegate 
		errorResponse: request 
		code: 501
		message: 'Not Implemented !'.
]

{ #category : #'error handling' }
ZnMooseJSONRestCall >> unsupportedMediaType [
	response := self delegate 
		errorResponse: request 
		code: 415
		message: 'Unsupported Media Type ', request accept.
]
