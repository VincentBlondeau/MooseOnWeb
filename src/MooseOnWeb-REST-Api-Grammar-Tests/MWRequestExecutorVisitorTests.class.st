"
A MWRequestExecutorVisitorTests is a test class for the execution of a request based on an AST.
It's using mocks for being independant of the AST and of the Parser

The result is only composed of arrays

Instance Variables
	entity:		a Mock Of Moose Entity
	visitor:		a MWRequestExecutorVisitor

entity
	- the entity that receive the action request

visitor
	- the AST visitor

"
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
		answers:
				{(#validActionLeft -> #validActionLeft).
					(#validActionRight -> #validActionRight).
					(#validActionFirst -> #validActionFirst).
					(#validActionSecond -> #validActionSecond).
					(#validAction1 -> #validAction1).
					(#validAction2 -> #validAction2).
					(#validAction3 -> #validAction3).
					(#actionNodeRoot -> #actionNodeRoot).
					(#actionNodeOnRootResult -> #actionNodeOnRootResult).
					(#actionNodeLast -> #actionNodeLast)} asDictionary.
	visitor := MWRequestExecutorVisitor new
		currentEntity: entity;
		yourself
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testFullActionsSentence [
	| result actionNodeRoot actionNodeOnRootResult actionNodeLast groupResult entityResult1 entityResult2 onEachExpressionsNode onResultExpressionsNode entityFinal |
	
	actionNodeRoot := MWRequestNodeAction new selector: #actionNodeRoot.
	actionNodeOnRootResult := MWRequestNodeAction new selector: #actionNodeOnRootResult.
	actionNodeLast := MWRequestNodeAction new selector: #size.
	onEachExpressionsNode :=MWRequestNodeOnEachExpression new left: actionNodeRoot ; right: actionNodeOnRootResult.
	onResultExpressionsNode :=MWRequestNodeOnEachExpression new left: onEachExpressionsNode ; right: actionNodeLast.
	entityResult1 := context mock: 'entityResult1'.
	entityResult2 := context mock: 'entityResult2'.
	entityFinal      := context mock: 'entityFinal'.
	groupResult := { entityResult1 . entityResult2 }. 
	entity should 
		receive: #actionNodeRoot;
		answers: groupResult.
	groupResult do: [ :ent | ent should  
			receive: #allPropertySelectors;
			answers: { #actionNodeOnRootResult -> #actionNodeOnRootResult } asDictionary. 	
		ent should 
			receive: #actionNodeOnRootResult;
			answers: entityFinal
	].
	result := visitor visitMWRequestNodeOnResultExpression: onResultExpressionsNode.
	self assert: result equals: 2
	
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testMultipleExpressionActionsSentence [
	| result multipleExpressionsNode actionNodeFirst actionNodeSecond groupResult1 groupResult2 |
	multipleExpressionsNode := context mock: 'multipleExpressionNode'.
	actionNodeFirst := MWRequestNodeAction new selector: #validActionFirst.
	actionNodeSecond := MWRequestNodeAction new selector: #validActionSecond.
	multipleExpressionsNode should
		receive: #expressions;
		answers: { actionNodeFirst . actionNodeSecond }.
	groupResult1 := #( 'resultItem1'  'resultItem2'). 
	groupResult2 := #( 'resultItem3'  'resultItem4'). 
	entity should
		receive: #validActionFirst;
		answers: groupResult1.
	entity should
		receive: #validActionSecond;
		answers: groupResult2.
	
	result := visitor visitMWRequestNodeMultipleExpression: multipleExpressionsNode.
	self assert: result equals: { groupResult1 . groupResult2 }
]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testOnEachAction [
	| actionNodeLeft onEachNode actionNodeRight result actionLeftResponseEntity1 actionLeftResponseEntity2 groupResult |
	onEachNode := context mock: 'onEachNode'.
	actionLeftResponseEntity1 := context mock: 'actionLeftResponseEntity1'.
	actionLeftResponseEntity2 := context mock: 'actionLeftResponseEntity2'.
	actionNodeLeft := MWRequestNodeAction new selector: #validActionLeft.
	actionNodeRight := MWRequestNodeAction new selector: #validActionOnEntities.
	onEachNode should 
		receive: #left;
		answers: actionNodeLeft.
	onEachNode should 
		receive: #right;
		exactly: #twice;
		answers: actionNodeRight.
	groupResult := { actionLeftResponseEntity1 . actionLeftResponseEntity2 }.
	entity should 
		receive: #validActionLeft;
		answers: groupResult.
	groupResult do: [ :ent | ent should  
			receive: #allPropertySelectors;
			answers: { #validActionOnEntities -> #validActionOnEntities } asDictionary. 	
		ent should 
			receive: #validActionOnEntities;
			answers: 'validActionOnEntitiesResponse'
	].
	result := visitor visitMWRequestNodeOnEachExpression: onEachNode.
	self assert: result equals: #('validActionOnEntitiesResponse' 'validActionOnEntitiesResponse') asOrderedCollection 

]

{ #category : #'as yet unclassified' }
MWRequestExecutorVisitorTests >> testOnResultAction [
	| actionNodeLeft actionNodeRight result groupResult onResultNode |
	onResultNode := context mock: 'onResultNode'.
	actionNodeLeft := MWRequestNodeAction new selector: #validActionLeft.
	actionNodeRight := MWRequestNodeAction new selector: #validActionOnResult.
	onResultNode should
		receive: #left;
		answers: actionNodeLeft.
	onResultNode should
		receive: #right;
		answers: actionNodeRight.
	groupResult := context mock: 'groupResult'.
	entity should
		receive: #validActionLeft;
		answers: groupResult.
	groupResult should  
		receive: #allPropertySelectors;
		answers: { #validActionOnResult -> #validActionOnResult } asDictionary. 	
	groupResult should
		receive: #validActionOnResult;
		answers: 42.
	result := visitor visitMWRequestNodeOnResultExpression: onResultNode.
	self assert: result equals: 42	
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
	<expectedFailure>
	| node |
	self fail.
	node := self parse: 'allClasses+allPackages' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeUnionExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'allPackages'.
]
