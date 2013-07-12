Class {
	#name : #MWRequestNodeOr,
	#superclass : #MWRequestNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #'MooseOnWeb-Request-AST'
}

{ #category : #visit }
MWRequestNodeOr >> acceptVisitor: aVisitor [
	aVisitor visitMWRequestNodeOr: self
]

{ #category : #accessing }
MWRequestNodeOr >> left [
	^ left
]

{ #category : #accessing }
MWRequestNodeOr >> left: anObject [
	left := anObject
]

{ #category : #accessing }
MWRequestNodeOr >> right [
	^ right
]

{ #category : #accessing }
MWRequestNodeOr >> right: anObject [
	right := anObject
]
