Class {
	#name : #MWRequestExecutorVisitor,
	#superclass : #MWRequestVisitor,
	#instVars : [
		'currentEntity'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-Visitor'
}

{ #category : #visit }
MWRequestExecutorVisitor >> checkActionsAreAllowed: aCollectionOfActions on: anEntity [
	| allowedActionsList |
	allowedActionsList := self listAllowedActions: anEntity.
	aCollectionOfActions
		do: [ :anAction | 
			(allowedActionsList includes: anAction)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
MWRequestExecutorVisitor >> currentEntity [
	^ currentEntity
]

{ #category : #accessing }
MWRequestExecutorVisitor >> currentEntity: anObject [
	currentEntity := anObject
]

{ #category : #visit }
MWRequestExecutorVisitor >> listAllowedActions: anEntity [
	^ ([anEntity allPropertySelectors values] on: MessageNotUnderstood do: [#()]) , { 'size' . 'sumInteger' . 'allClients' }
]

{ #category : #visit }
MWRequestExecutorVisitor >> performAction: anAction on: anEntity [
	^ anEntity perform: anAction asSymbol
]

{ #category : #visit }
MWRequestExecutorVisitor >> visitMWRequestNodeAction: aMWRequestNodeAction [
	(self checkActionsAreAllowed: {(aMWRequestNodeAction selector)} on: currentEntity)
		ifFalse: [ MWInvalidAction signal ].
	^ self performAction: aMWRequestNodeAction selector on: currentEntity
]

{ #category : #visit }
MWRequestExecutorVisitor >> visitMWRequestNodeMultipleExpression: aMWRequestNodeMultipleExpression [
	| entity |
	entity := self currentEntity.
	^ aMWRequestNodeMultipleExpression expressions collect: [ :expr | self currentEntity: entity. expr acceptVisitor: self ]
]

{ #category : #visit }
MWRequestExecutorVisitor >> visitMWRequestNodeOnEachExpression: aMWRequestNodeOnEachExpression [
	| groupEntity |
	groupEntity := aMWRequestNodeOnEachExpression left acceptVisitor: self.
	^ groupEntity
		collect: [ :entity | 
			self currentEntity: entity.
			aMWRequestNodeOnEachExpression right acceptVisitor: self ]
]

{ #category : #visit }
MWRequestExecutorVisitor >> visitMWRequestNodeOnResultExpression: aMWRequestNodeOnResultExpression [
	self currentEntity: (aMWRequestNodeOnResultExpression left acceptVisitor: self).
	^ aMWRequestNodeOnResultExpression right acceptVisitor: self
]

{ #category : #visit }
MWRequestExecutorVisitor >> visitMWRequestNodeUnionExpression: aMWRequestNodeUnionExpression [
	| entity result |
	entity := self currentEntity.
	result := aMWRequestNodeUnionExpression left acceptVisitor: self.
	self currentEntity: entity.
	^ result, aMWRequestNodeUnionExpression right acceptVisitor: self
]
