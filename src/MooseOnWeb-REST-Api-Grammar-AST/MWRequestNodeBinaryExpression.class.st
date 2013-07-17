Class {
	#name : #MWRequestNodeBinaryExpression,
	#superclass : #MWRequestNode,
	#instVars : [
		'left',
		'right'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #'as yet unclassified' }
MWRequestNodeBinaryExpression class >> left: left right: right [
	^ self new
		left: left;
		right: right;
		yourself
]

{ #category : #accessing }
MWRequestNodeBinaryExpression >> left [
	^ left
]

{ #category : #accessing }
MWRequestNodeBinaryExpression >> left: anObject [
	left := anObject
]

{ #category : #accessing }
MWRequestNodeBinaryExpression >> right [
	^ right
]

{ #category : #accessing }
MWRequestNodeBinaryExpression >> right: anObject [
	right := anObject
]
