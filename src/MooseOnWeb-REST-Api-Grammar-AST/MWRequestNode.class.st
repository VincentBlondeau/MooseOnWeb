Class {
	#name : #MWRequestNode,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #'as yet unclassified' }
MWRequestNode >> acceptVisitor: aVisitor [
	self subclassResponsibility 
]
