Class {
	#name : #MWFamixDiffHandlerTest,
	#superclass : #MWServerTests,
	#category : #'MooseOnWeb-REST-Api-Extensions-Tests'
}

{ #category : #tests }
MWFamixDiffHandlerTest >> setUp [
	super setUp.
	client addPathSegment: 'famixDiff'
]

{ #category : #tests }
MWFamixDiffHandlerTest >> testGet [
	| output |
	output := client get.
	self assert: client isSuccess.
	self fail: 'Test To Complete !'.
	self assert: (output includesSubstring: 'TOTO')
]

{ #category : #tests }
MWFamixDiffHandlerTest >> testToRenameAndCode [

	| output |
	output := client get.
	self assert: client isSuccess.
	self fail: 'Test To Complete !'.
	
]

{ #category : #tests }
MWFamixDiffHandlerTest >> testToRenameAndCode1 [

	| output |
	output := client get.
	self assert: client isSuccess.
	self fail: 'Test To Complete !'.
	
]

{ #category : #tests }
MWFamixDiffHandlerTest >> testToRenameAndCode2 [

	| output |
	output := client get.
	self assert: client isSuccess.
	self fail: 'Test To Complete !'.
	
]

{ #category : #tests }
MWFamixDiffHandlerTest >> testToRenameAndCode3 [

	| output |
	output := client get.
	self assert: client isSuccess.
	self fail: 'Test To Complete !'.
	
]
