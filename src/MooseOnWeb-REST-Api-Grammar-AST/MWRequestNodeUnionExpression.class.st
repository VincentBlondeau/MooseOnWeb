"
A MWRequestNodeUnionExpression is a node representing the union of the elements in the left and right parameters
"
Class {
	#name : #MWRequestNodeUnionExpression,
	#superclass : #MWRequestNodeBinaryExpression,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #visit }
MWRequestNodeUnionExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeUnionExpression: self
]
