Class {
	#name : #MWComposedMimeType,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #'as yet unclassified' }
MWComposedMimeType class >> fromString: aString [
	^ self new collection: ((aString splitOn: $,) collect: [ :e | e asZnMimeType ])  
]

{ #category : #'as yet unclassified' }
MWComposedMimeType >> asMWComposedMimeType [
	^self
]

{ #category : #'as yet unclassified' }
MWComposedMimeType >> collection [
	 ^collection ifNil: [ OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
MWComposedMimeType >> collection: aCollection [
	 collection := aCollection sorted: [  :a :b | a > b ].
]

{ #category : #'as yet unclassified' }
MWComposedMimeType >> findMatchesWith: aMimeTypeCollection [
	| result theFirstMatchingMimeType |
	result := OrderedCollection ofSize: collection size.
	collection withIndexDo: [ :aMimeType :index |
			theFirstMatchingMimeType := aMimeTypeCollection select: [ :e | e  matches: aMimeType ].
			theFirstMatchingMimeType do: [ :e | (result includes: e) ifFalse: [ result at: index put: e ]]
	].
	^result select: [ :e | e notNil ]
]

{ #category : #converting }
MWComposedMimeType >> printOn: stream [
	self collection printOn: stream.
]
