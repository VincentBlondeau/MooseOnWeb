"
A MWActionGrammar is a grammar parser for complex actions.

Instance Variables represents the elements of the grammar
	action:		composition of argument and selector (e.g. : allClasses)
	actionExpression:		a combinaition of actions : allClasses;comments;size
	actionsExpression:		a concatenation of actionExpression: (allClasses;size),allPackages
	argument:		an argument of the message (not used)
	parens:		an parenthesis for actions
	selector:		the message itself

So you can parse:

allClasses!(cyclomaticComplexity,nameLength),allMethods*allPackages;size

- ! apply an action on each element of a group
- ; apply an action on a group
- , allow the call of several actions 
- * is the concatenation of groups
"
Class {
	#name : #MWActionGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'parens',
		'action',
		'selector',
		'argument',
		'actionExpression',
		'actionsExpression'
	],
	#category : #'MooseOnWeb-REST-Api-Grammar-Core'
}

{ #category : #accessing }
MWActionGrammar >> action [
	^ selector, ($: asParser, argument) optional

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
		group: [ :g | g left: $* asParser token trim do: self unionBlock ].
	^ expression
]

{ #category : #accessing }
MWActionGrammar >> actionsExpression [
	^ actionExpression , ( $, asParser, actionExpression ) star
]

{ #category : #accessing }
MWActionGrammar >> argument [
	^ #word asParser plus 


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
	^ $( asParser, actionsExpression , $) asParser 
]

{ #category : #accessing }
MWActionGrammar >> selector [
	^ #word asParser plus
]

{ #category : #accessing }
MWActionGrammar >> start [
	^ actionsExpression end
]

{ #category : #blocks }
MWActionGrammar >> unionBlock [
	^ [ :left :op :right | { left . op . right } ]
]
