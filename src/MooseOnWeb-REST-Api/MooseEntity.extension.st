Extension { #name : #MooseEntity }

{ #category : #'*MooseOnWeb-REST-Api' }
MooseEntity >> isMooseEntity [
	^ true
]

{ #category : #'*MooseOnWeb-REST-Api' }
MooseEntity >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseEntity: self.

]

{ #category : #'*MooseOnWeb-REST-Api' }
MooseEntity classSide >> objectWithID: elementID [
	| collection |
	collection := (MooseModel root collect: [ :e | e objectWithID: elementID ]) select: [ :a | a isNil not ].
	collection isEmptyOrNil
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ collection first ]
]
