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
	^ MooseModel root
]

{ #category : #'initialize-release' }
MWServerTests >> setUp [
	server := ZnServer startOn: 1710 + 10 atRandom.
	server delegate: MWRestServerDelegate new.
	client := ZnClient new
		url: server localUrl;
		addPathSegment: #mooseOnWeb;
		yourself.
	modelTest := self createTestModel.
	modelTest install.
	
	server debugMode: true
]

{ #category : #'initialize-release' }
MWServerTests >> tearDown [
	client close.
	server stop.
	self rootModelForTestServer remove: self modelTest.
]

{ #category : #'initialize-release' }
MWServerTests >> testServer [
	self assert: server isRunning
]
