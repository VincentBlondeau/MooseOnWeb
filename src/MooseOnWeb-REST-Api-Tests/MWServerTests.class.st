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
	#superclass : #BabyMockTestCase,
	#instVars : [
		'server',
		'client',
		'modelTest',
		'isProxyUsed'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #accessing }
MWServerTests >> createDelegate [
	^ MWRestServerDelegate new
		mooseModelList: self rootModelForTestServer;
		yourself
]

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
	server delegate: self createDelegate.
	server register.
	client := ZnClient new
		url: server localUrl;
		addPathSegment: #mooseOnWeb;
		yourself.
	isProxyUsed := NetworkSystemSettings useHTTPProxy.
	NetworkSystemSettings useHTTPProxy: false.
	"server debugMode: true"
]

{ #category : #running }
MWServerTests >> tearDown [
	client close.
	server stop.
	server unregister.
	NetworkSystemSettings useHTTPProxy: isProxyUsed
]

{ #category : #tests }
MWServerTests >> testServer [
	self assert: server isRunning.
	self assert: server delegate mooseModelList size equals: 1.
	self shouldnt: (client get: client request url asString,'?action=&firstParameter=["Value"]&secondParameter=["Value"]&lastParameter={ "Key":["firstValue","secondValue"]}') raise: [ ZnUnknownHttpVersion ]
]
