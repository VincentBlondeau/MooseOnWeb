"
A MWActionGrammarTest is a test class for the parsing of action expressions in package MooseOnWeb-REST-Api-Grammar-Core
"
Class {
	#name : #MWActionGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : #'MooseOnWeb-REST-Api-Grammar-Tests'
}

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> parserClass [ 
	^MWActionGrammar
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testCombineActions1 [
	self parse: 'allClasses!allFunctions;size' rule: #actionExpression
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testFullActionsSentence [
	self parse: 'allClasses,allClasses!allFunctions;size' rule: #actionsExpression
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testMultipleExpressionActionsSentence [
	self parse: 'allClasses,allPackages' rule: #actionsExpression
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testOnEachAction [
	self parse: 'allClasses!numberOfMethods' rule: #actionExpression
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testOnResultAction [
	self parse: 'allClasses;size' rule: #actionExpression
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testSingleAction [
	self parse: 'allClasses' rule: #action
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testSingleActionWithParameter [
	self parse: 'value:toto' rule: #action
]

{ #category : #'as yet unclassified' }
MWActionGrammarTest >> testUnionActions [
	self parse: 'allClasses*allPackages' rule: #actionExpression
]
