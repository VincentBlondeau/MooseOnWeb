Class {
	#name : #JsonVisitor,
	#superclass : #MAVisitor,
	#instVars : [
		'json',
		'object'
	],
	#category : #'MooseOnWeb-JsonMagritteExample'
}

{ #category : #accessing }
JsonVisitor >> json [
	^json ifNil: [json := JsonObject new]
]

{ #category : #accessing }
JsonVisitor >> json: aJson [
	json := aJson
]

{ #category : #accessing }
JsonVisitor >> object [
	^object
]

{ #category : #accessing }
JsonVisitor >> object: anObject [
	object := anObject
]

{ #category : #private }
JsonVisitor >> object: anObject during: aBlock [
	| previous |
	previous := self object. self object: anObject.
	aBlock ensure: [ self object: previous ]
]

{ #category : #visiting }
JsonVisitor >> visitContainer: aDescription [
	aDescription do: [:each | self visit: each]
]
