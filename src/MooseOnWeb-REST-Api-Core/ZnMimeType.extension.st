Extension { #name : #ZnMimeType }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
ZnMimeType >> > other [
	self weight ~= other weight ifTrue: [ ^self weight > other weight ].
	(self matches: other) ifFalse: [ ^false ].
	(self main = other main and: [ self sub = self sub ]) ifTrue: [  ^self parameters size > other parameters size ].
	^true
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
ZnMimeType >> weight [
	 ^(self parameterAt: #q ifAbsent: [ '1' ]) asNumber
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
ZnMimeType >> weight: aNumber [
	(aNumber between: 0 and: 1)
		ifFalse: [ DomainError signalFrom: 0 to: 1 ].
	self parameterAt: #q put: aNumber asString
]
