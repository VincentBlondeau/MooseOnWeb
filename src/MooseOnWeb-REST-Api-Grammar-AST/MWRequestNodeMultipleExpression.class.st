"
A MWRequestNodeMultipleExpression is a node representing an collection of expressions.

Instance Variables
	expressions:		Array of MWRequestNodes

expressions
	- each element of the array is representing an expression node

"
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
