Extension { #name : #String }

{ #category : #'*MooseOnWeb-REST-Api' }
String >> asMessage [
	self = 'eq' ifTrue: [ ^#includesSubstring: ].
	self = 'gt' ifTrue: [ ^#> ].
	self = 'lt' ifTrue: [ ^#< ].
	self = 'ge' ifTrue: [ ^#>= ].
	self = 'le' ifTrue: [ ^#<= ].
	RessourceNotFound signal. 
]
