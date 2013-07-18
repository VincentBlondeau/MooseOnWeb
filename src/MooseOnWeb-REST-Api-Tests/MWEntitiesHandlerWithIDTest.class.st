Class {
	#name : #MWEntitiesHandlerWithIDTest,
	#superclass : #BabyMockTestCase,
	#instVars : [
		'server',
		'client',
		'url',
		'request',
		'entity',
		'handler',
		'theMooseGroup',
		'theEmptyMooseGroup',
		'delegate'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #running }
MWEntitiesHandlerWithIDTest >> setUp [
	"The #class method aren't well understood by the mock so can't test #respondsTo: by this way"
	request := context mock: 'request'.
	url := context mock: 'url'.
	entity := context mock: 'entity'.
	delegate := context mock: 'delegate'.
	request can
		receive: #uri;
		answers: url.
	theEmptyMooseGroup := MooseGroup new.
	theMooseGroup := theEmptyMooseGroup
		add: entity;
		yourself.
	handler := MWEntitiesHandlerWithID new
		request: request;
		delegate: delegate; yourself.
			
	"For Debug purpose only !"
"	context visualize: handler."
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testExecuteAListOfActions [
	| selectors results |
	selectors := {#anAction -> #anAction . #aSecondAction -> #aSecondAction .#aThirdAction -> #aThirdAction } asDictionary.
	results := {#anAction -> '1' . #aSecondAction -> '2'.#aThirdAction -> 3} asDictionary.
	url can
		receive: #queryAt:;
		with: 'actions';
		answers: 'anAction,aSecondAction,aThirdAction'.
	entity can
		receive: #anAction;
		answers: '1'.
	entity can
		receive: #aSecondAction;
		answers: '2'.
	entity can
		receive: #aThirdAction;
		answers: 3.
	entity should
		receive: #allPropertySelectors;
		exactly: 3;
		answers: selectors.
	self assert: (handler actions: entity) equals: results
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testExecuteANonExistingAction [
	url should
		receive: #queryAt:;
		with: 'action';
		answers: 'anAction'.
	entity can
		receive: #allPropertySelectors;
		answers:
				(IdentityDictionary new
						at: 'aNotPresentAction' put: 'aNotPresentAction';
						yourself).
	entity shouldnt receive: #anAction.
	self should: [ handler action: entity ] raise: MWInvalidAction 
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testExecuteANonValidListOfActions [
	| selectors |
	selectors := {#anAction -> #anAction . #aSecondAction -> #aSecondAction .#aThirdAction -> #aThirdAction } asDictionary.
	url can
		receive: #queryAt:;
		with: 'actions';
		answers: 'anActionaSecondAction,aThirdAction'.
	entity should
		receive: #allPropertySelectors;
		answers: selectors.
	self should: [ handler actions: entity ] raise: MWInvalidAction 
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testExecuteAction [
	url can
		receive: #queryAt:;
		with: 'action';
		answers: 'anAction'.
	entity can
		receive: #anAction;
		answers: '1'.
	entity should
		receive: #allPropertySelectors;
		answers:
				(IdentityDictionary new
						at: #anAction put: #anAction;
						yourself).
	self assert: (handler action: entity) equals: '1'
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testQueryAction [
	| selectors |
	url should
		receive: #queryAt:;
		with: 'q';
		answers: 'actions'.
	selectors := { 'action1' -> 'action1' . 'action2' -> 'action2' } asDictionary.
	entity should
		receive: #allPropertySelectors;
		answers: selectors.
	
	self assert: (handler query: entity) equals: selectors keys.

]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testQuerySearch [
	"teste la recherche sur une entitié moose. "

	url can
		receive: #queryAt:;
		with: 'onAction';
		signals: KeyNotFound.
	url can
		receive: #queryAt:;
		with: 'q';
		answers: 'search'.
	url should
		receive: #queryAt:;
		with: 'key';
		answers: 'key'.
	url should
		receive: #queryAt:;
		with: 'value';
		answers: 'value'.
	url should
		receive: #queryAt:;
		with: 'op';
		answers: 'op'.
	self should: [ handler search: MooseEntity new ] raise: NotYetImplemented
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testQuerySearchWithEmptyResult [
	"test searching on a MooseGroup that does not contain a matching entity"

	url can
		receive: #queryAt:;
		with: 'onAction';
		signals: KeyNotFound.
	url can
		receive: #queryAt:;
		with: 'q';
		answers: 'search'.
	url should
		receive: #queryAt:;
		with: 'key';
		answers: 'anAction'.
	url should
		receive: #queryAt:;
		with: 'value';
		answers: true.
	url should
		receive: #queryAt:;
		with: 'op';
		answers: 'eq'.
	entity can
		receive: #anAction;
		answers: true.
	self assert: (handler search: theMooseGroup) isEmpty
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testSearchANonExistingEntity [
	| model |
	model := context mock: 'model'.
	model should receive: #objectWithID:; with: 42; answers: nil.
	delegate should receive: #mooseModelList; answers: { model }.
	self should: [ handler findEntityWithID: 42 ] raise: MWRessourceNotFound  
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testSearchAnExistingEntity [
	| model |
	model := context mock: 'model'.
	model should
		receive: #objectWithID:;
		with: 42;
		answers: entity.
	delegate should
		receive: #mooseModelList;
		answers: {model}.
	self shouldnt: [ self assert: (handler findEntityWithID: 42) equals: entity ] raise: MWRessourceNotFound
]
