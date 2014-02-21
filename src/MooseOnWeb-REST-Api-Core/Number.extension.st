Extension { #name : #Number }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
Number >> compareTo: anOtherObject withOp: operator [
	^ [ self perform: operator with: anOtherObject asNumber ] on: Error do: [ MWValueNotComparable signal ] 

]
