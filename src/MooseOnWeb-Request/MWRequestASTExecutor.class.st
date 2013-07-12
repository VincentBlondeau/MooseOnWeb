Class {
	#name : #MWRequestASTExecutor,
	#superclass : #MWRequestASTVisitor,
	#instVars : [
		'entity'
	],
	#category : #'MooseOnWeb-Request-ASTVisitor'
}

{ #category : #accessing }
MWRequestASTExecutor >> entity [
	^ entity
]

{ #category : #accessing }
MWRequestASTExecutor >> entity: anObject [
	entity := anObject
]

{ #category : #visit }
MWRequestASTExecutor >> visitMWRequestNodeAnd: aMWRequestNodeAnd [
	self shouldBeImplemented
]

{ #category : #visit }
MWRequestASTExecutor >> visitMWRequestNodeCondition: aMWRequestNodeCondition [
	self shouldBeImplemented
]

{ #category : #visit }
MWRequestASTExecutor >> visitMWRequestNodeNot: aMWRequestNodeNot [
	self shouldBeImplemented
]

{ #category : #visit }
MWRequestASTExecutor >> visitMWRequestNodeOr: aMWRequestNodeOr [
	self shouldBeImplemented
]
