Extension { #name : #MooseEntity }

{ #category : #'*MooseOnWeb-REST-Api' }
MooseEntity >> isMooseEntity [
	^ true
]

{ #category : #'*MooseOnWeb-REST-Api' }
MooseEntity classSide >> objectWithID: elementID [
	| collection |
	collection := (MooseModel root collect: [ :e | e objectWithID: elementID ]) reject: [ :a | a isNil ].
	collection isEmptyOrNil
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ collection first ]
]
