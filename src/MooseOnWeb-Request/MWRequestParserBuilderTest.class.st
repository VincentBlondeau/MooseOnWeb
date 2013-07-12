Class {
	#name : #MWRequestParserBuilderTest,
	#superclass : #PPCompositeParserTest,
	#category : #'MooseOnWeb-Request-Parser-Tests'
}

{ #category : #'as yet unclassified' }
MWRequestParserBuilderTest >> parserClass [ 
	^ MWRequestParserBuilder 
]

{ #category : #'as yet unclassified' }
MWRequestParserBuilderTest >> testCondition1 [
	| node |
	node := self parse: 'fanIn,>,5' rule: #condition.
	self assert: node class equals: MWRequestNodeCondition.
	self assert: node criteria equals: 'fanIn'.
	self assert: node operator equals: $>.
	self assert: node value equals: '5'.
	
]
