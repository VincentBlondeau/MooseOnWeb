Class {
	#name : #MWMooseProjectsHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #tests }
MWMooseProjectsHandlerTest >> testGet [
	| output |
	client addPathSegment: 'mooseProjects'.
	server delegate mooseProjectList: #(1).
	output := client get.
	self assert: client isSuccess.
	self fail: 'Test To Complete ! and import the moose project packages and update the config !'.
	self assert: (output includesSubstring: 'TOTO')
]

{ #category : #tests }
MWMooseProjectsHandlerTest >> testGetWithNoProjet [
	
	| output |
	client addPathSegment: 'mooseProjects'.
	output := client get.
	
	self assert: client isSuccess.
	self assert: (output includesSubstring: '[ ]')
]
