Extension { #name : #MooseEntity }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
MooseEntity >> getCommentInMethod: aMethodSymbol [
	^ self class getCommentInMethod: aMethodSymbol
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
MooseEntity classSide >> getCommentInMethod: aMethodSymbol [
	^ (Pragma inMethod: (self allMethods detect: [ :m | m selector = aMethodSymbol ]) named: #MSEComment:)
		ifNotNilDo: [ :pragma | pragma arguments first ]
		ifNil: [ 'no description for this method' ]
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
MooseEntity >> isMooseEntity [
	^ true
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
MooseEntity classSide >> objectWithID: elementID [
	| collection |
	collection := (MooseModel root collect: [ :e | e objectWithID: elementID ]) reject: [ :a | a isNil ].
	collection isEmptyOrNil
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ collection first ]
]

{ #category : #'*MooseOnWeb-REST-Api-Core' }
MooseEntity >> violatedRules [
	<navigation: 'Get all the rules violated by this entity'>
	^ self mooseModel violatedRulesFor: self.
]
