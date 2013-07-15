Extension { #name : #MooseAbstractGroup }

{ #category : #'*MooseOnWeb-REST-Api' }
MooseAbstractGroup >> isMooseGroup [
	^ true
]

{ #category : #'*MooseOnWeb-REST-Api' }
MooseAbstractGroup >> objectWithID: elementID [
	^ (self entityStorage includesID: elementID)
		ifFalse: [ (self mooseID = elementID) ifTrue: [ ^self ] ifFalse: [ ^nil ] ]
		ifTrue: [ self entityStorage detect: [ :e | e mooseID = elementID ] ]
]
