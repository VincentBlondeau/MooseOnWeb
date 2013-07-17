Class {
	#name : #MWActionGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'parens',
		'action',
		'selector',
		'argument',
		'actionExpression'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-Core'
}

{ #category : #accessing }
MWActionGrammar >> action [
	^ selector, argument optional

]

{ #category : #accessing }
MWActionGrammar >> actionExpression [
	| expression |
	expression := PPExpressionParser new.
	expression term: parens / action.
	expression
		group: [ :g | 
					g left: $! asParser token trim do: self onEachBlock.
					g left: $; asParser token trim do: self onResultBlock ];
		group: [ :g | g left: $+ asParser token trim do: self unionBlock ].
	^ expression
]

{ #category : #accessing }
MWActionGrammar >> actionsExpression [
	actionExpression , ( $, actionExpression ) star
]

{ #category : #accessing }
MWActionGrammar >> argument [
	^ $: asParser, #word asParser plus 


]

{ #category : #blocks }
MWActionGrammar >> onEachBlock [
	^ [ :left :op :right | { left . op . right } ]
]

{ #category : #blocks }
MWActionGrammar >> onResultBlock [
	^ [ :left :op :right | { left . op . right } ]
]

{ #category : #accessing }
MWActionGrammar >> parens [
	^ $( asParser, actionExpression , $) asParser 
]

{ #category : #accessing }
MWActionGrammar >> selector [
	^ #word asParser plus
]

{ #category : #accessing }
MWActionGrammar >> start [
	^ actionExpression
]

{ #category : #blocks }
MWActionGrammar >> unionBlock [
	^ [ :left :op :right | { left . op . right } ]
]
