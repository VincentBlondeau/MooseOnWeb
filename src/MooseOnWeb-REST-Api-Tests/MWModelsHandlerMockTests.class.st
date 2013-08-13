"
A MWModelsHandlerMockTests is a test unit for MWModelsHandler.

Instance Variables
	model:		<Object>

model
	- xxxxx

"
Class {
	#name : #MWModelsHandlerMockTests,
	#superclass : #MWMockTests,
	#instVars : [
		'model'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #running }
MWModelsHandlerMockTests >> setUp [
	super setUp.
	model := context mock: 'model'.

	handler := MWModelsHandler new
		request: request;
		delegate: delegate;
		yourself.

]

{ #category : #tests }
MWModelsHandlerMockTests >> testDelete [
	| collection |
	collection := Set new add: model;yourself.
	self assert: collection size equals: 1.
	delegate should
		receive: #mooseModelList;
		exactly: #twice;
		answers: collection.
	model should
		receive: #mooseID;
		exactly: #twice;
		answers: 42.
	handler deleteModel: 42.
	self assert: collection isEmpty
]
