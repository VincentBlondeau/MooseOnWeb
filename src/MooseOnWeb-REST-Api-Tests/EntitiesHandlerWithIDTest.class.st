Class {
	#name : #EntitiesHandlerWithIDTest,
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
EntitiesHandlerWithIDTest >> setUp [
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
	handler := EntitiesHandlerWithID new
		request: request;
		entity: entity	
			
	"For Debug purpose only !"
	"context visualize: handler."
]

{ #category : #running }
EntitiesHandlerWithIDTest >> testAction [
	url should
		receive: #queryAt:;
		with: [ :a | a = 'action' ];
		answers: 'anAction'.
	entity should
		receive: #anAction;
		answers: '1'.
	handler action.
	self assert: (handler answer includesSubstring: '1').
]

{ #category : #running }
EntitiesHandlerWithIDTest >> testAction2 [
	url should
		receive: #queryAt:;
		with: [ :a | a = 'action' ];
		answers: 'anAction'.
	entity should
		receive: #anAction;
		signals: MessageNotUnderstood.
	self should: [ handler action ] raise: RessourceNotFound  
]

{ #category : #running }
EntitiesHandlerWithIDTest >> testEntity [
	entity := nil.
	self should: [ handler entity: entity ] raise: RessourceNotFound
]

{ #category : #running }
EntitiesHandlerWithIDTest >> testEntity2 [
	self shouldnt: [ handler entity: entity ] raise: RessourceNotFound.
	self assert: handler entity equals: entity
]

{ #category : #running }
EntitiesHandlerWithIDTest >> testQueryAction [
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
EntitiesHandlerWithIDTest >> testQueryAction2 [
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
EntitiesHandlerWithIDTest >> testQuerySearch [
	"teste la recherche sur une entitié moose. "

	url can
		receive: #queryAt:;
		with: [ :a | a = 'q' ];
		answers: 'search'.
	url can
		receive: #queryAt:;
		with: [ :a | a = 'anAction' ];
		answers: 'value'.
	url can 
		receive: #query;
		answers: 	(Dictionary new at: #q put: 'search'; at: #anAction put: 'value'; yourself ).
	handler entity: MooseEntity new.

	self should: [handler search] raise:  NotYetImplemented  .

]

{ #category : #running }
EntitiesHandlerWithIDTest >> testQuerySearch2 [
	"teste la recherche sur un AbstréactGroup moose qui ne contient pas la valeur recherchée. "

	url can
		receive: #queryAt:;
		with: [ :a | a = 'q' ];
		answers: 'search'.
	url can
		receive: #queryAt:;
		with: [ :a | a = 'anAction' ];
		answers: 'value'.
	url can 
		receive: #query;
		answers: 	(Dictionary new at: #q put: 'search'; at: #anAction put: 'value'; yourself ).
	handler entity: theMooseGroup .	
		

	entity should
		receive: #anAction;
		answers: true.
	handler search.
	
	self assert: (handler answer isEmpty ).

]

{ #category : #running }
EntitiesHandlerWithIDTest >> testQuerySearch3 [
	"teste la recherche sur un AbstractGroup moose. "

	url can
		receive: #queryAt:;
		with: [ :a | a = 'q' ];
		answers: 'search'.
	url can
		receive: #queryAt:;
		with: [ :a | a = 'anAction' ];
		answers: 'value'.
	url can 
		receive: #query;
		answers: 	(Dictionary new at: #q put: 'search'; at: #anAction put: 'value'; yourself ).
	handler entity: theMooseGroup .	
		

	entity should
		receive: #anAction;
		answers: 'value'.

	
	handler search.
	
	self assert: handler answer size equals: 1.
	self assert: (handler answer at:1) equals: entity.

]
