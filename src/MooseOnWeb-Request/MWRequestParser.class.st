Class {
	#name : #MWRequestParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'condition',
		'criteria',
		'operator',
		'value',
		'separator',
		'parens',
		'filter'
	],
	#category : #'MooseOnWeb-Request-Parser'
}

{ #category : #'as yet unclassified' }
MWRequestParser >> andBlock [ 
	^ [ :exprA :and :exprB | { exprA . and . exprB } ]
]

{ #category : #'as yet unclassified' }
MWRequestParser >> condition [
	^ criteria, separator, operator, separator, value
]

{ #category : #'as yet unclassified' }
MWRequestParser >> criteria [
	^ #word asParser plus
]

{ #category : #'as yet unclassified' }
MWRequestParser >> filter [
	
	| expression |
	expression := PPExpressionParser new.

	expression term: parens / condition.
	
	expression
		group: [ :g |
			g prefix: 'not' asParser token do: self notBlock ];
		group: [ :g |
			g left: 'and' asParser token do: self andBlock];
		group: [ :g |
			g left: 'or' asParser token trim do: self orBlock].
	^ expression
]

{ #category : #'as yet unclassified' }
MWRequestParser >> notBlock [ 
	^ [ :not :expr | expr ]
]

{ #category : #'as yet unclassified' }
MWRequestParser >> operator [
	^ #( '<=' '>=' '!=' $< $> $=) inject: PPFailingParser new into: [ :p :symbol | p / symbol asParser]
]

{ #category : #'as yet unclassified' }
MWRequestParser >> orBlock [ 
	^ [ :exprA :or :exprB | { exprA . or . exprB } ]
]

{ #category : #'as yet unclassified' }
MWRequestParser >> parens [
	^ $( asParser token , filter , $) asParser token 
]

{ #category : #'as yet unclassified' }
MWRequestParser >> separator [
	^ $, asParser
]

{ #category : #'as yet unclassified' }
MWRequestParser >> start [
	^ filter
]

{ #category : #'as yet unclassified' }
MWRequestParser >> value [
	^ #word asParser plus
]
