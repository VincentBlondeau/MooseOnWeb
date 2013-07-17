Class {
	#name : #MWRequestNodeAction,
	#superclass : #MWRequestNode,
	#instVars : [
		'selector',
		'argument'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-AST'
}

{ #category : #'as yet unclassified' }
MWRequestNodeAction class >> selector: aSelectorName argument: anArgument [
	^ self new
		selector: aSelectorName;
		argument: anArgument;
		yourself
]

{ #category : #visit }
MWRequestNodeAction >> acceptVisitor: aVisitor [
	^ aVisitor visitMWRequestNodeAction: self
]

{ #category : #accessing }
MWRequestNodeAction >> argument [
	^ argument
]

{ #category : #accessing }
MWRequestNodeAction >> argument: anObject [
	argument := anObject
]

{ #category : #accessing }
MWRequestNodeAction >> selector [
	^ selector
]

{ #category : #accessing }
MWRequestNodeAction >> selector: anObject [
	selector := anObject
]
