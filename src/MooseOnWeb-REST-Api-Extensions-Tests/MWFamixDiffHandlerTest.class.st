Class {
	#name : #MWFamixDiffHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Extensions-Tests'
}

{ #category : #tests }
MWFamixDiffHandlerTest >> testGet [
	| output |
	client addPathSegment: 'famixDiff'.
	output := client get.
	self assert: client isSuccess.
	self fail: 'Test To Complete !'.
	self assert: (output includesSubstring: 'TOTO')
]
