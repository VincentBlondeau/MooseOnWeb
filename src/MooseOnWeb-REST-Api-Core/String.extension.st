Extension { #name : #String }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
String >> asMWComposedMimeType [
	^ MWComposedMimeType fromString: self
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
String >> asMessage [
	self = 'eq' ifTrue: [ ^#= ].
	self = 'gt' ifTrue: [ ^#> ].
	self = 'lt' ifTrue: [ ^#< ].
	self = 'ge' ifTrue: [ ^#>= ].
	self = 'le' ifTrue: [ ^#<= ].
	MWRessourceNotFound signal. 
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
String >> compareTo: anOtherObject withOp: operator [
	operator = #= ifTrue: [ operator = #includesSubstring: ].
	^ [ self perform: operator with: anOtherObject asString ] on: Error do: [ MWValueNotComparable signal ]
]
