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
		'theEmptyMooseGroup'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #running }
MWEntitiesHandlerWithIDTest >> setUp [
	"The #class method aren't well understood by the mock so can't test #respondsTo: by this way"
	request := context mock: 'request'.
	url := context mock: 'url'.
	entity := context mock: 'entity'.
	request can
		receive: #uri;
		answers: url.
	theEmptyMooseGroup := MooseGroup new.
	theMooseGroup := theEmptyMooseGroup
		add: entity;
		yourself.
	handler := MWEntitiesHandlerWithID new
		request: request;
		uri: url;
		entity: entity	.
			
	"For Debug purpose only !"
	"context visualize: handler."
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testAction [
	url can
		receive: #queryAt:;
		with: [ :a | a = 'action' ];
		answers: 'anAction'.
	entity can
		receive: #anAction;
		answers: '1'.
	entity should
		receive: #allPropertySelectors;
		answers: (IdentityDictionary new at: #anAction put: #anAction; yourself).
	handler action.
	self assert: (handler answer includesSubstring: '1').
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testAction2 [
	url should
		receive: #queryAt:;
		with: [ :a | a = 'action' ];
		answers: 'anAction'.
	entity shouldnt
		receive: #anAction.
	entity should
		receive: #anNotPresentAction;
		answers: MessageNotUnderstood .
	entity can
		receive: #allPropertySelectors;
		answers: (IdentityDictionary new at: 'anNotPresentAction' put: 'anNotPresentAction'; yourself ).	
	self should: [ handler action ] raise: MWRessourceNotFound  
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testEntity [
	entity := nil.
	self should: [ handler entity: entity ] raise: MWRessourceNotFound
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testEntity2 [
	self shouldnt: [ handler entity: entity ] raise: MWRessourceNotFound.
	self assert: handler entity equals: entity
]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testQueryAction [
	"teste l'absence de resultats"

	url should
		receive: #queryAt:;
		with: [ :a | a = 'q' ];
		answers: 'actions'.
	entity should
		receive: #allPropertySelectors;
		answers: Dictionary new.
	handler query.
	self assert: (handler answer isEmpty).

]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testQueryAction2 [
	url should
		receive: #queryAt:;
		with: [ :a | a = 'q' ];
		answers: 'actions'.
	entity should
		receive: #allPropertySelectors;
		answers:
				(Dictionary new
						at: #anAction put: #anAction;
						at: #anOtherAction put: #anOtherAction;
						at: #anThirdAction put: #anThirdAction;
						yourself).
	entity can
		receive: #anAction;
		answers: nil.
	entity can
		receive: #anOtherAction;
		answers: theMooseGroup.
	entity can
		receive: #anThirdAction;
		answers: theEmptyMooseGroup.
		
	handler query.
	self assert: (handler answer asString includesSubstring: 'anOtherAction').
	self deny: (handler answer asString includesSubstring: 'anAction').

]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testQuerySearch [
	"teste la recherche sur une entitié moose. "
	url can
		receive: #queryAt:;
		with: [ :a | a = 'action' ];
		signals: KeyNotFound.
	url can
		receive: #queryAt:;
		with: [ :a | a = 'q' ];
		answers: 'search'.
	url should
		receive: #queryAt:;
		with: [ :a | a = 'key' ];
		answers: 'key'.
	url should
		receive: #queryAt:;
		with: [ :a | a = 'value' ];
		answers: 'value'.
	url should
		receive: #queryAt:;
		with: [ :a | a = 'op' ];
		answers: 'op'.
	handler entity: MooseEntity new.

	self should: [handler search] raise:  NotYetImplemented  .

]

{ #category : #running }
MWEntitiesHandlerWithIDTest >> testQuerySearch2 [
	"teste la recherche sur un AbstractGroup moose qui ne contient pas la valeur recherchée. "

	url can
		receive: #queryAt:;
		with: [ :a | a = 'action' ];
		signals: KeyNotFound.
	url can
		receive: #queryAt:;
		with: [ :a | a = 'q' ];
		answers: 'search'.
	url should
		receive: #queryAt:;
		with: [ :a | a = 'key' ];
		answers: 'anAction'.
	url should
		receive: #queryAt:;
		with: [ :a | a = 'value' ];
		answers: true.
	url should
		receive: #queryAt:;
		with: [ :a | a = 'op' ];
		answers: 'eq'.

			
	handler entity: theMooseGroup.

	entity can
		receive: #anAction;
		answers: true.
	handler search.
	
	self assert: (handler answer isEmpty ).

]
