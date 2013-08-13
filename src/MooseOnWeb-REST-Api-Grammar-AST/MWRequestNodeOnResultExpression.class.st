"
A MWRequestNodeOnResultExpression is a node representing at left a group and at right an action to be executed on the group itself and not his elements.

"
Class {
	#name : #MWRequestNodeOnResultExpression,
	#superclass : #MWRequestNodeBinaryExpression,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #visit }
MWRequestNodeOnResultExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeOnResultExpression: self
]
