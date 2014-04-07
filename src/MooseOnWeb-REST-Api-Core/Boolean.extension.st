Extension { #name : #Boolean }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
Boolean >> compareTo: anOtherObject withOp: operator [
	^ operator = #= ifTrue: [ self = anOtherObject ] ifFalse: [ MWValueNotComparable signal ]
]
