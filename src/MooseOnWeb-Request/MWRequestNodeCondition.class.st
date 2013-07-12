Class {
	#name : #MWRequestNodeCondition,
	#superclass : #MWRequestNode,
	#instVars : [
		'criteria',
		'operator',
		'value'
	],
	#category : #'MooseOnWeb-Request-AST'
}

{ #category : #visit }
MWRequestNodeCondition >> acceptVisitor: aVisitor [
	aVisitor visitMWRequestNodeCondition: self
]

{ #category : #accessing }
MWRequestNodeCondition >> criteria [
	^ criteria
]

{ #category : #accessing }
MWRequestNodeCondition >> criteria: anObject [
	criteria := anObject
]

{ #category : #accessing }
MWRequestNodeCondition >> operator [
	^ operator
]

{ #category : #accessing }
MWRequestNodeCondition >> operator: anObject [
	operator := anObject
]

{ #category : #accessing }
MWRequestNodeCondition >> value [
	^ value
]

{ #category : #accessing }
MWRequestNodeCondition >> value: anObject [
	value := anObject
]
