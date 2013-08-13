"
A MWRequestExecutorVisitor is a visitor of AST created by MooseOnWeb-REST-Api-Grammar-AST.
A verification of the actions's validity is realized. If the action isn't valide a MWInvalidAction is risen

The result is composed of dictionary where the key is the name of the action and the value is the result of the action.

Instance Variables
	currentEntity:		a Moose Entity

currentEntity
	- the current entity on which the action will be executed

"
Class {
	#name : #MWRequestMapExecutorVisitor,
	#superclass : #MWRequestVisitor,
	#instVars : [
		'currentEntity'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-Visitor'
}

{ #category : #visit }
MWRequestMapExecutorVisitor >> checkActionsAreAllowed: aCollectionOfActions on: anEntity [
	| allowedActionsList |
	allowedActionsList := self listAllowedActions: anEntity.
	^ aCollectionOfActions allSatisfy: [ :anAction | allowedActionsList includes: anAction ]
]

{ #category : #accessing }
MWRequestMapExecutorVisitor >> currentEntity [
	^ currentEntity
]

{ #category : #accessing }
MWRequestMapExecutorVisitor >> currentEntity: anObject [
	currentEntity := anObject
]

{ #category : #visit }
MWRequestMapExecutorVisitor >> listAllowedActions: anEntity [
	^ ([anEntity allPropertySelectors values] on: MessageNotUnderstood do: [#()]) , { 'size' . 'sumInteger' . 'sum' .'allClients' }
]

{ #category : #visit }
MWRequestMapExecutorVisitor >> performAction: anAction on: anEntity [
	^ anEntity perform: anAction asSymbol
]

{ #category : #visit }
MWRequestMapExecutorVisitor >> visitMWRequestNodeAction: aMWRequestNodeAction [
	(self checkActionsAreAllowed: {(aMWRequestNodeAction selector)} on: currentEntity)
		ifFalse: [ MWInvalidAction signal ].
	^ { aMWRequestNodeAction selector -> (self performAction: aMWRequestNodeAction selector on: currentEntity) } asDictionary 
]

{ #category : #visit }
MWRequestMapExecutorVisitor >> visitMWRequestNodeMultipleExpression: aMWRequestNodeMultipleExpression [
	| entity |
	entity := self currentEntity.
	^ aMWRequestNodeMultipleExpression expressions inject: Dictionary new into: [ :dict :nextExpr  | self currentEntity: entity. dict at: 
	nextExpr selector put: (nextExpr acceptVisitor: self) values first; yourself  ]
]

{ #category : #visit }
MWRequestMapExecutorVisitor >> visitMWRequestNodeOnEachExpression: aMWRequestNodeOnEachExpression [
	| groupEntity |
	groupEntity := aMWRequestNodeOnEachExpression left acceptVisitor: self.
	^ { aMWRequestNodeOnEachExpression left selector -> (groupEntity values first
		collect: [ :entity | 
			self currentEntity: entity.
			aMWRequestNodeOnEachExpression right acceptVisitor: self ]) asOrderedCollection } asDictionary 
]

{ #category : #visit }
MWRequestMapExecutorVisitor >> visitMWRequestNodeOnResultExpression: aMWRequestNodeOnResultExpression [
	self currentEntity: (aMWRequestNodeOnResultExpression left acceptVisitor: self) values first.
	^ aMWRequestNodeOnResultExpression right acceptVisitor: self
]

{ #category : #visit }
MWRequestMapExecutorVisitor >> visitMWRequestNodeUnionExpression: aMWRequestNodeUnionExpression [
	| entity result |
	entity := self currentEntity.
	result := aMWRequestNodeUnionExpression left acceptVisitor: self.
	self currentEntity: entity.
	^ (result, (aMWRequestNodeUnionExpression right acceptVisitor: self)) asOrderedCollection 
]
