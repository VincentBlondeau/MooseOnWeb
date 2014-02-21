Extension { #name : #Object }

{ #category : #'*MooseOnWeb-REST-Api-Core-Core' }
Object >> compareTo: anOtherObject withOp: operator [
	MWValueNotComparable signal 
]

{ #category : #'*MooseOnWeb-REST-Api-Core-Core' }
Object >> isMooseEntity [
	^false
]

{ #category : #'*MooseOnWeb-REST-Api-Core-Core' }
Object >> isMooseGroup [
	^false
]
