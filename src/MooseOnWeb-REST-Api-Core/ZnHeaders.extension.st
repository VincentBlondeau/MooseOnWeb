Extension { #name : #ZnHeaders }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
ZnHeaders class >> defaultRestResponseHeaders [
	^ self new
		at: 'Server' put: ZnConstants defaultServerString;
		at: 'Date' put: ZnUtils httpDate;
		at: 'Access-Control-Allow-Origin' put: '*';
		yourself
]
