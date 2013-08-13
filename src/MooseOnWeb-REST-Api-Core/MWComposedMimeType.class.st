"
A MWComposedMimeType is a converter of string representing MimeTypes in a collection of MimeTypes. 
For example, 'application/html;q=0.8,text/plain' is a string resulting of the concatenation of 2 mimes types. 
A MWComposedMimeType will be able to sort by priority the MimeTypes of this string.

To convert a such string into a MWComposedMimeType, apply asMWComposedMimeType. 

After you can access the collection to have your MimeTypes sorted or you can compare them to an collection of Mime Types (OrderedCollection) with 'findMatchesWith:'. It will answer the best maching between the IV collection (received from the request) and the parameter (what your server can provide).

You can find the documentation on the mimes types here:
http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html


Instance Variables
	collection:		aOrderedCollection (sorted)

collection
	- Sorted array containing all the subMimetypes of the string converted. This array is sorted by priority using the rules of the standard.

"
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

{ #category : #converting }
MWComposedMimeType >> asMWComposedMimeType [
	^self
]

{ #category : #accessing }
MWComposedMimeType >> collection [
	 ^collection ifNil: [ OrderedCollection new ]
]

{ #category : #accessing }
MWComposedMimeType >> collection: aCollection [
	 collection := aCollection sorted: [  :a :b | a > b ].
]

{ #category : #comparing }
MWComposedMimeType >> findMatchesWith: aMimeTypeCollection [
	| result theFirstMatchingMimeType |
	result := OrderedCollection ofSize: collection size.
	collection withIndexDo: [ :aMimeType :index |
			theFirstMatchingMimeType := aMimeTypeCollection select: [ :e | e  matches: aMimeType ].
			theFirstMatchingMimeType do: [ :e | (result includes: e) ifFalse: [ result at: index put: e ]]
	].
	^result select: [ :e | e notNil ]
]

{ #category : #printing }
MWComposedMimeType >> printOn: stream [
	self collection printOn: stream.
]
