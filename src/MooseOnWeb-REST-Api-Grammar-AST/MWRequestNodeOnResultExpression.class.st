Class {
	#name : #MWRequestNodeOnResultExpression,
	#superclass : #MWRequestNodeBinaryExpression,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #visit }
MWRequestNodeOnResultExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeOnResultExpression: self
]
