Class {
	#name : #MWRequestParserBuilder,
	#superclass : #MWRequestParser,
	#category : #'MooseOnWeb-Request-Parser'
}

{ #category : #'as yet unclassified' }
MWRequestParserBuilder >> andBlock [ 
	^ [ :exprA :and :exprB | MWRequestNodeAnd new left: exprA; right: exprB; yourself ]
]

{ #category : #'as yet unclassified' }
MWRequestParserBuilder >> condition [
	^ super condition ==> [ :p | MWRequestNodeCondition new criteria: p first; operator: p third; value: p fifth; yourself ]
]

{ #category : #'as yet unclassified' }
MWRequestParserBuilder >> criteria [
	^ super criteria flatten
]

{ #category : #'as yet unclassified' }
MWRequestParserBuilder >> notBlock [ 
	^ [ :not :expr | MWRequestNodeNot new expression: expr; yourself ]
]

{ #category : #'as yet unclassified' }
MWRequestParserBuilder >> orBlock [ 
	^ [ :exprA :and :exprB | MWRequestNodeOr new left: exprA; right: exprB; yourself ]
]

{ #category : #'as yet unclassified' }
MWRequestParserBuilder >> parens [
	^ super parens ==> [ :p | p second ]
]

{ #category : #'as yet unclassified' }
MWRequestParserBuilder >> value [
	^ super value flatten
]
