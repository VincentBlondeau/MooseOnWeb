Extension { #name : #ZnJSONRestCall }

{ #category : #'*MooseOnWeb-REST-Api' }
ZnJSONRestCall >> jsonResponseFromJson: string [
	self response: (ZnResponse ok: (ZnEntity with: string type: ZnMimeType applicationJson))
]
