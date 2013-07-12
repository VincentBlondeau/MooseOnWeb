Class {
	#name : #MWRequestNodeAnd,
	#superclass : #MWRequestNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #'MooseOnWeb-Request-AST'
}

{ #category : #visit }
MWRequestNodeAnd >> acceptVisitor: aVisitor [
	aVisitor visitMWRequestNodeAnd: self
]

{ #category : #accessing }
MWRequestNodeAnd >> left [
	^ left
]

{ #category : #accessing }
MWRequestNodeAnd >> left: anObject [
	left := anObject
]

{ #category : #accessing }
MWRequestNodeAnd >> right [
	^ right
]

{ #category : #accessing }
MWRequestNodeAnd >> right: anObject [
	right := anObject
]
