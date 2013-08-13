"
A MWActionRequestBuilder is creating a AST representing the parsing of the string. 
The AST is build with classes in MooseOnWeb-REST-Api-Grammar-AST

"
Class {
	#name : #MWActionRequestBuilder,
	#superclass : #MWActionGrammar,
	#category : #'MooseOnWeb-REST-Api-Grammar-Core'
}

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> action [
	^ super action ==> [ :p | MWRequestNodeAction selector: p first argument: ((p second) ifNotNilDo: [ :arg | arg second ] )]
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> actionsExpression [
	^ super actionsExpression
		==> [ :p | 
			p second
				ifEmpty: [ p first ]
				ifNotEmpty: [ MWRequestNodeMultipleExpression expressions: {(p first)} , (p second collect: [ :e | e second ]) ] ]
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> argument [
	^ super argument flatten
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> onEachBlock [
	^ [ :left :op :right | MWRequestNodeOnEachExpression left: left right: right ]
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> onResultBlock [
	^ [ :left :op :right | MWRequestNodeOnResultExpression left: left right: right ]
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> parens [
	^ super parens ==> [ :p | p second]
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> selector [
	^ super selector flatten
]

{ #category : #'as yet unclassified' }
MWActionRequestBuilder >> unionBlock [
	^ [ :left :op :right | MWRequestNodeUnionExpression left: left right: right ]
]
