Class {
	#name : #MWServerTests,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'client'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'initialize-release' }
MWServerTests >> model [
	" to debug and avoid caching behavior: LANPackageTestResource reset."
	^ LANPackageTestResource current model 
	
]

{ #category : #'initialize-release' }
MWServerTests >> setUp [
	server := ZnServer startOn: 1710 + 10 atRandom.
	server delegate: MWRestServerDelegate new.
	client := ZnClient new
		url: server localUrl;
		addPathSegment: #mooseOnWeb;
		yourself.
	self model install.
	
	server debugMode: true
]

{ #category : #'initialize-release' }
MWServerTests >> tearDown [
	client close.
	server stop.
	MooseModel root remove: 	self model.
]

{ #category : #'initialize-release' }
MWServerTests >> testServer [
	self assert: server isRunning
]
