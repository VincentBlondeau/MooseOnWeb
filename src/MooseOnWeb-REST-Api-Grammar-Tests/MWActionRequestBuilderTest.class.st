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
	self parse: 'allClasses,allClasses!allFunctions;size' rule: #actionsExpression.
	self fail
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testOnEachAction [
	self parse: 'allClasses!numberOfMethods' rule: #actionExpression.
	self fail
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testOnResultAction [
	self parse: 'allClasses;size' rule: #actionExpression.
	self fail
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testSimpleActionsSentence [
	self parse: 'allClasses,allPackages' rule: #actionsExpression.
	self fail
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testSingleAction [
	self parse: 'allClasses' rule: #action.
	self fail
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testSingleActionWithParameter [
	self parse: 'value:toto' rule: #action.
	self fail
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilderTest >> testUnionActions [
	self parse: 'allClasses+allPackages' rule: #actionExpression.
	self fail
]
