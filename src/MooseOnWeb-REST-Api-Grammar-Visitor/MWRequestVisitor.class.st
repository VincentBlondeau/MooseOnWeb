Class {
	#name : #MWRequestVisitor,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Grammar-Visitor'
}

{ #category : #visit }
MWRequestVisitor >> visitMWRequestNodeAction: aMWRequestNodeAction [
	self subclassResponsibility
]

{ #category : #visit }
MWRequestVisitor >> visitMWRequestNodeBinaryExpression: aMWRequestNodeBinaryExpression [
	self subclassResponsibility
]

{ #category : #visit }
MWRequestVisitor >> visitMWRequestNodeMultipleExpression: aMWRequestNodeMultipleExpression [
	self subclassResponsibility
]

{ #category : #visit }
MWRequestVisitor >> visitMWRequestNodeOnEachExpression: aMWRequestNodeOnEachExpression [
	self subclassResponsibility
]

{ #category : #visit }
MWRequestVisitor >> visitMWRequestNodeOnResultExpression: aMWRequestNodeOnResultExpression [
	self subclassResponsibility
]

{ #category : #visit }
MWRequestVisitor >> visitMWRequestNodeUnionExpression: aMWRequestNodeUnionExpression [
	self subclassResponsibility
]
