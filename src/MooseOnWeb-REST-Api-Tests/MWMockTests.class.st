"
A MWMockTests is the superclass of all the REST API where mocks are used.
Tests the MooseOnWeb-REST-Api-Core

Instance Variables
	delegate:		a MWRestServerDelegate 
	entity:		a Mock (a MooseEntity)
	handler:		a MWRestCallHandler 
	request:		a Mock (ZnRequest)
	theEmptyMooseGroup:		a MooseGroup
	theMooseGroup:		a MooseGroup
	url:		a Mock (an ZnUrl)

delegate
	- the delegate

entity
	- a Moose entity

handler
	- th request handler

request
	- xxxxx

theEmptyMooseGroup
	- an Empty moose group

theMooseGroup
	- a MooseGroup with one element

url
	- an url

"
Class {
	#name : #MWMockTests,
	#superclass : #BabyMockTestCase,
	#instVars : [
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
