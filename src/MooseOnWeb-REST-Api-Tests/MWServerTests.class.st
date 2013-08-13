"
A MWServerTests is the superclass of all the REST API where a server is used.

Instance Variables
	client:		a ZnClient
	modelTest:		a MooseModel
	server:		a ZnServer

client
	- a web client

modelTest
	- a model

server
	- a web server

"
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

{ #category : #accessing }
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

{ #category : #accessing }
MWServerTests >> rootModelForTestServer [
	^ { self modelTest } asSet
]

{ #category : #running }
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
	server debugMode: true
]

{ #category : #running }
MWServerTests >> tearDown [
	client close.
	server stop
]

{ #category : #tests }
MWServerTests >> testServer [
	self assert: server isRunning.
	self assert: server delegate mooseModelList size equals: 1
]
