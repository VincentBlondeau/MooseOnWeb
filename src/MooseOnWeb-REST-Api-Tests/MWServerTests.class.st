Class {
	#name : #MWServerTests,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'client',
		'modelTest'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'initialize-release' }
MWServerTests >> createTestModel [
	" to debug and avoid caching behavior: LANPackageTestResource reset."
	^ LANPackageTestResource current model 
	
]

{ #category : #accessing }
MWServerTests >> modelTest [
	^ modelTest
]

{ #category : #accessing }
MWServerTests >> modelTest: anObject [
	modelTest := anObject
]

{ #category : #'initialize-release' }
MWServerTests >> rootModelForTestServer [
	^ { self modelTest }
]

{ #category : #'initialize-release' }
MWServerTests >> setUp [
	self modelTest: self createTestModel.
	server := ZnServer startOn: 1710 + 10 atRandom.
	server
		delegate:
			(MWRestServerDelegate new
				mooseModelList:  self rootModelForTestServer ;
				yourself).
	server register.
	client := ZnClient new
		url: server localUrl;
		addPathSegment: #mooseOnWeb;
		yourself.
	
	self flag: 'Only to debug mode'	.
	server debugMode: true
]

{ #category : #'initialize-release' }
MWServerTests >> tearDown [
	client close.
	server stop
]

{ #category : #'initialize-release' }
MWServerTests >> testServer [
	self assert: server isRunning.
	self assert: server delegate mooseModelList size equals: 1
]
