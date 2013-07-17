Class {
	#name : #MWRequestNodeOnEachExpression,
	#superclass : #MWRequestNodeBinaryExpression,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #visit }
MWRequestNodeOnEachExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeOnEachExpression: self
]
