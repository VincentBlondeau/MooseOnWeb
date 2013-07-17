Class {
	#name : #MWRequestNodeUnionExpression,
	#superclass : #MWRequestNodeBinaryExpression,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #visit }
MWRequestNodeUnionExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeUnionExpression: self
]
