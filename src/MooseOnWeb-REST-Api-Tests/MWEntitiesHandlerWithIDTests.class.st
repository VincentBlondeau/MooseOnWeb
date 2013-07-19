Class {
	#name : #MWEntitiesHandlerWithIDTests,
	#superclass : #MWMockTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #running }
MWEntitiesHandlerWithIDTests >> setUp [
	super setUp.
	handler := MWEntitiesHandlerWithID new
		request: request;
		delegate: delegate;
		yourself	.
]

{ #category : #running }
MWEntitiesHandlerWithIDTests >> testExecuteAListOfActions [
	| selectors results |
	selectors := {(#anAction -> #anAction).
	(#aSecondAction -> #aSecondAction).
	(#aThirdAction -> #aThirdAction)} asDictionary.
	results := {'1'.
	'2'.
	3}.
	url can
		receive: #queryAt:;
		with: 'action';
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
	self assert: (handler action: entity) equals: results
]

{ #category : #running }
MWEntitiesHandlerWithIDTests >> testExecuteANonExistingAction [
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
MWEntitiesHandlerWithIDTests >> testExecuteANonValidListOfActions [
	| selectors |
	selectors := {#anAction -> #anAction . #aSecondAction -> #aSecondAction .#aThirdAction -> #aThirdAction } asDictionary.
	url can
		receive: #queryAt:;
		with: 'action';
		answers: 'anActionaSecondAction,aThirdAction'.
	entity should
		receive: #allPropertySelectors;
		answers: selectors.
	self should: [ handler action: entity ] raise: MWInvalidAction 
]

{ #category : #running }
MWEntitiesHandlerWithIDTests >> testExecuteAction [
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
MWEntitiesHandlerWithIDTests >> testQueryAction [
	| selectors result |
	url should
		receive: #queryAt:;
		with: 'q';
		answers: 'actions'.
	selectors := { #action1 -> #action1 . #action2 -> #action2 } asDictionary.
    result := {   #action1 -> 'commentForAction1' . #action2 -> 'commentForAction2' } asDictionary.
	entity should
		receive: #allPropertySelectors;
		answers: selectors.
	entity should 
		receive: #getCommentInMethod: ;
		with: #action1;
		answers: 'commentForAction1'.
	entity should 
		receive: #getCommentInMethod: ;
		with: #action2;
		answers: 'commentForAction2'.
	self assert: (handler query: entity) equals: result.

]

{ #category : #running }
MWEntitiesHandlerWithIDTests >> testQuerySearch [
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
MWEntitiesHandlerWithIDTests >> testQuerySearchWithEmptyResult [
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
MWEntitiesHandlerWithIDTests >> testSearchANonExistingEntity [
	| model |
	model := context mock: 'model'.
	model should receive: #objectWithID:; with: 42; answers: nil.
	delegate should receive: #mooseModelList; answers: { model }.
	self should: [ handler findEntityWithID: 42 ] raise: MWRessourceNotFound  
]

{ #category : #running }
MWEntitiesHandlerWithIDTests >> testSearchAnExistingEntity [
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
