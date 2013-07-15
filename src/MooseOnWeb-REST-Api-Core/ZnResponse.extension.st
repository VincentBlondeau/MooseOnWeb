Extension { #name : #ZnResponse }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
ZnResponse class >> okRest: entity [
	^ self new
		statusLine: ZnStatusLine ok;
		headers: ZnHeaders defaultRestResponseHeaders;
		entity: entity;
		yourself
]
