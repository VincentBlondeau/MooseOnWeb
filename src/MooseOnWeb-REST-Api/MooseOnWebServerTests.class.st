Class {
	#name : #MooseOnWebServerTests,
	#superclass : #TestCase,
	#instVars : [
		'server',
		'client'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'initialize-release' }
MooseOnWebServerTests >> model [
	" to debug and avoid caching behavior: LANPackageTestResource reset."
	^ LANPackageTestResource current model 
	
]

{ #category : #'initialize-release' }
MooseOnWebServerTests >> setUp [
	server := ZnServer startOn: 1710 + 10 atRandom.
	server delegate: MooseOnWebRestServerDelegate new.
	client := ZnClient new
		url: server localUrl;
		addPathSegment: #mooseOnWeb;
		yourself.
	MooseModel root add: self model
]

{ #category : #'initialize-release' }
MooseOnWebServerTests >> tearDown [
	client close.
	server stop.
	MooseModel root remove: 	self model.
]

{ #category : #'initialize-release' }
MooseOnWebServerTests >> testServer [
	self assert: server isRunning
]
