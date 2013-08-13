"
A MWRequestNodeOnEachExpression is a node representing at left a group and at right an action to be executed on each item of the group.


"
Class {
	#name : #MWRequestNodeOnEachExpression,
	#superclass : #MWRequestNodeBinaryExpression,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #visit }
MWRequestNodeOnEachExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeOnEachExpression: self
]
