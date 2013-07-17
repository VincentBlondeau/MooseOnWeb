Class {
	#name : #MWRequestNodeMultipleExpression,
	#superclass : #MWRequestNode,
	#instVars : [
		'expressions'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #'as yet unclassified' }
MWRequestNodeMultipleExpression class >> expressions: aCollectionOfExpressions [
	^ self new
		expressions: aCollectionOfExpressions;
		yourself
]

{ #category : #visit }
MWRequestNodeMultipleExpression >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeMultipleExpression: self
]

{ #category : #accessing }
MWRequestNodeMultipleExpression >> expressions [
	^ expressions
]

{ #category : #accessing }
MWRequestNodeMultipleExpression >> expressions: anObject [
	expressions := anObject
]
