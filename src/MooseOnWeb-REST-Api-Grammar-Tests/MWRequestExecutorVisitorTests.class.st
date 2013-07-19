Class {
	#name : #MWRequestExecutorVisitorTests,
	#superclass : #BabyMockTestCase,
	#instVars : [
		'entity',
		'visitor'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-Tests'
}

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> setUp [
	super setUp.
	entity := context mock: 'entity'.
	entity can 
		receive: #allPropertySelectors;
		answers: { #validAction1 -> #validAction1 .  #validAction2 -> #validAction2 .  #validAction3 -> #validAction3 } asDictionary.

	visitor := (MWRequestExecutorVisitor new currentEntity: entity;yourself)
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testCombineActions1 [
	| node |
	self fail.
	node:= self parse: 'allClasses!allFunctions;size' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeOnResultExpression.
	self assert: node left class equals: MWRequestNodeOnEachExpression.
	self assert: node right class equals: MWRequestNodeAction.	
	self assert: node right selector equals: 'size'.	
	self assert: node right argument equals: nil.	
	self assert: node left left class equals: MWRequestNodeAction.
	self assert: node left left selector equals: 'allClasses'.	
	self assert: node left left argument equals: nil.	
	self assert: node left right class equals: MWRequestNodeAction.
	self assert: node left right selector equals: 'allFunctions'.	
	self assert: node left right argument equals: nil.	
	
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testFullActionsSentence [
	| node rightSide |
	self fail.
	node := self parse: 'allClasses,allMethods!allFunctions;size' rule: #actionsExpression.
	self assert: node class equals: MWRequestNodeMultipleExpression.
	self assert: node expressions first class equals: MWRequestNodeAction.
	self assert: node expressions first selector equals: 'allClasses'.
	rightSide := node expressions second.
	self assert: rightSide class equals: MWRequestNodeOnResultExpression.
	self assert: rightSide right class equals: MWRequestNodeAction.
	self assert: rightSide right selector equals: 'size'.	
	self assert: rightSide left class equals: MWRequestNodeOnEachExpression.
	self assert: rightSide left left class equals: MWRequestNodeAction.
	self assert: rightSide left left selector equals: 'allMethods'.
	self assert: rightSide left right class equals: MWRequestNodeAction.
	self assert: rightSide left right selector equals: 'allFunctions'.
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testOnEachAction [
	| node |
	self fail.
	node := self parse: 'allClasses!numberOfMethods' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeOnEachExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'numberOfMethods'.
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testOnResultAction [
	| node |
	self fail.
	node := self parse: 'allClasses;size' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeOnResultExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'size'.
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testSimpleActionsSentence [
	| node |
	self fail.
	node := self parse: 'allClasses,allPackages' rule: #actionsExpression.
	self assert: node class equals: MWRequestNodeMultipleExpression.
	self assert: node expressions first class equals: MWRequestNodeAction.
	self assert: node expressions first selector equals: 'allClasses'.
	self assert: node expressions second class equals: MWRequestNodeAction.
	self assert: node expressions second selector equals: 'allPackages'.
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testSingleAction [
	| node |
	self fail.
	node := self parse: 'allClasses' rule: #action.
	self assert: node class equals: MWRequestNodeAction.
	self assert: node selector equals: 'allClasses'
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testSingleActionNode [
	| actionNode result |
	actionNode := context mock: 'actionNode'.
	actionNode should 
		receive: #selector;
		exactly: #twice;
		answers: 'validAction1'.
	entity should 
		receive: #validAction1;
		answers: 'validAction1Response'.
	result := visitor visitMWRequestNodeAction: actionNode.
	self assert: result equals: 'validAction1Response'
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testSingleActionWithParameter [
	| node |
	self fail.
	node := self parse: 'value:toto' rule: #action.
	self assert: node class equals: MWRequestNodeAction.
	self assert: node selector equals: 'value'.
	self assert: node argument equals: 'toto'.
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testSingleInvalidActionNode [
	| actionNode |
	actionNode := context mock: 'actionNode'.
	actionNode should 
		receive: #selector;
		answers: 'anInvalidAction'.

	self should:  [visitor visitMWRequestNodeAction: actionNode] raise: MWInvalidAction

]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testUnionActions [
	| node |
	self fail.
	node := self parse: 'allClasses+allPackages' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeUnionExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'allPackages'.
]
