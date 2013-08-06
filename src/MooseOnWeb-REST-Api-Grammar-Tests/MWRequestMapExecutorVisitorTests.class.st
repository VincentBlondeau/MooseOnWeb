Class {
	#name : #MWRequestMapExecutorVisitorTests,
	#superclass : #BabyMockTestCase,
	#instVars : [
		'entity',
		'visitor'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-Tests'
}

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> setUp [
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
	visitor := MWRequestMapExecutorVisitor new
		currentEntity: entity;
		yourself
]

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> testFullActionsSentence [
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
	self assert: result equals: { 'size' -> 2 } asDictionary 
	
]

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> testMultipleExpressionActionsSentence [
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
	self assert: result equals:  { 'validActionFirst' -> groupResult1 . 'validActionSecond' -> groupResult2 } asDictionary 
]

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> testOnEachAction [
	| actionNodeLeft onEachNode actionNodeRight result actionLeftResponseEntity1 actionLeftResponseEntity2 groupResult |
	onEachNode := context mock: 'onEachNode'.
	actionLeftResponseEntity1 := context mock: 'actionLeftResponseEntity1'.
	actionLeftResponseEntity2 := context mock: 'actionLeftResponseEntity2'.
	actionNodeLeft := MWRequestNodeAction new selector: #validActionLeft.
	actionNodeRight := MWRequestNodeAction new selector: #validActionOnEntities.
	onEachNode should
		receive: #left;
		exactly: 2;
		answers: actionNodeLeft.
	onEachNode should
		receive: #right;
		exactly: 2;
		answers: actionNodeRight.
	groupResult := {actionLeftResponseEntity1.
	actionLeftResponseEntity2}.
	entity should
		receive: #validActionLeft;
		answers: groupResult.
	groupResult
		do: [ :ent | 
			ent should
				receive: #allPropertySelectors;
				answers: {(#validActionOnEntities -> #validActionOnEntities)} asDictionary.
			ent should
				receive: #validActionOnEntities;
				answers: 'validActionOnEntitiesResponse' ].
	result := visitor visitMWRequestNodeOnEachExpression: onEachNode.
	self
		assert: result
		equals:
			{('validActionLeft'
				->
					{({('validActionOnEntities' -> 'validActionOnEntitiesResponse')} asDictionary).
					({('validActionOnEntities' -> 'validActionOnEntitiesResponse')} asDictionary)} asOrderedCollection)} asDictionary
]

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> testOnResultAction [
	| actionNodeLeft actionNodeRight result groupResult onResultNode |
	onResultNode := context mock: 'onResultNode'.
	actionNodeLeft := MWRequestNodeAction new selector: #validActionLeft.
	actionNodeRight := MWRequestNodeAction new selector: #validActionOnResult.
	onResultNode should
		receive: #left;

		answers: actionNodeLeft.
	onResultNode should
		receive: #right;
		exactly: 1;
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
	self assert: result equals: { 'validActionOnResult' -> 42 } asDictionary 
]

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> testSingleActionNode [
	| actionNode result |
	actionNode := context mock: 'actionNode'.
	actionNode should 
		receive: #selector;
		exactly: 3;
		answers: 'validAction1'.
	entity should 
		receive: #validAction1;
		answers: 'validAction1Response'.
	result := visitor visitMWRequestNodeAction: actionNode.
	self assert: result equals:  { 'validAction1' -> 'validAction1Response' } asDictionary 
]

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> testSingleInvalidActionNode [
	| actionNode |
	actionNode := context mock: 'actionNode'.
	actionNode should 
		receive: #selector;
		answers: 'anInvalidAction'.

	self should:  [visitor visitMWRequestNodeAction: actionNode] raise: MWInvalidAction

]

{ #category : #'as yet unclassified' }
MWRequestMapExecutorVisitorTests >> testUnionActions [
	| node |
	self fail.
	node := self parse: 'allClasses+allPackages' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeUnionExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'allPackages'.
]
