"
A MWRequestNode is a abstract node. It's a node representing an element of the action request.

These nodes are built by the parser in MooseOnWeb-REST-Api-Grammar-Core and can be evaluated by the visitor in the MooseOnWeb-REST-Api-Visitor

"
Class {
	#name : #MWRequestNode,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #'as yet unclassified' }
MWRequestNode >> acceptVisitor: aVisitor [
	self subclassResponsibility 
]
