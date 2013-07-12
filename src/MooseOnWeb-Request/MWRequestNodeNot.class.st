Class {
	#name : #MWRequestNodeNot,
	#superclass : #MWRequestNode,
	#instVars : [
		'expression'
	],
	#category : #'MooseOnWeb-Request-AST'
}

{ #category : #visit }
MWRequestNodeNot >> acceptVisitor: aVisitor [
	aVisitor visitMWRequestNodeNot: self
]

{ #category : #accessing }
MWRequestNodeNot >> expression [
	^ expression
]

{ #category : #accessing }
MWRequestNodeNot >> expression: anObject [
	expression := anObject
]
