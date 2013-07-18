Class {
	#name : #MWMockTests,
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
MWMockTests >> setUp [
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

]
