Class {
	#name : #MWActionRequestBuilderTest,
	#superclass : #PPCompositeParserTest,
	#category : #'MooseOnWeb-REST-Api-Grammar-Tests'
}

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> parserClass [ 
	^MWActionRequestBuilder 
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testCombineActions1 [
	| node |
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
MWActionRequestBuilderTest >> testFullActionsSentence [
	| node rightSide |
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
MWActionRequestBuilderTest >> testOnEachAction [
	| node |
	node := self parse: 'allClasses!numberOfMethods' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeOnEachExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'numberOfMethods'.
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testOnResultAction [
	| node |
	node := self parse: 'allClasses;size' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeOnResultExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'size'.
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testSimpleActionsSentence [
	| node |
	node := self parse: 'allClasses,allPackages' rule: #actionsExpression.
	self assert: node class equals: MWRequestNodeMultipleExpression.
	self assert: node expressions first class equals: MWRequestNodeAction.
	self assert: node expressions first selector equals: 'allClasses'.
	self assert: node expressions second class equals: MWRequestNodeAction.
	self assert: node expressions second selector equals: 'allPackages'.
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testSingleAction [
	| node |
	node := self parse: 'allClasses' rule: #action.
	self assert: node class equals: MWRequestNodeAction.
	self assert: node selector equals: 'allClasses'
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testSingleActionWithParameter [
	| node |
	node := self parse: 'value:toto' rule: #action.
	self assert: node class equals: MWRequestNodeAction.
	self assert: node selector equals: 'value'.
	self assert: node argument equals: 'toto'
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testUnionActions [
	| node |
	node := self parse: 'allClasses*allPackages' rule: #actionExpression.
	self assert: node class equals: MWRequestNodeUnionExpression.
	self assert: node left class equals: MWRequestNodeAction.
	self assert: node left selector equals: 'allClasses'.
	self assert: node right class equals: MWRequestNodeAction.
	self assert: node right selector equals: 'allPackages'.
]
