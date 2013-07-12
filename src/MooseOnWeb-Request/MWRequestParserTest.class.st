Class {
	#name : #MWRequestParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'MooseOnWeb-Request-Parser-Tests'
}

{ #category : #'as yet unclassified' }
MWRequestParserTest >> parserClass [
	^ MWRequestParser 
]

{ #category : #'as yet unclassified' }
MWRequestParserTest >> testCondition1 [
	self parse: 'fanIn,>,5' rule: #condition
]

{ #category : #'as yet unclassified' }
MWRequestParserTest >> testFilter1 [
	self parse: '((fanIn,>,5)or(fanOut,!=,toto))' rule: #filter
]
