Extension { #name : #ZnResponse }

{ #category : #'*MooseOnWeb-REST-Api' }
ZnResponse class >> okRest: entity [
	^ self new
		statusLine: ZnStatusLine ok;
		headers: ZnHeaders defaultRestResponseHeaders;
		entity: entity;
		yourself
]
