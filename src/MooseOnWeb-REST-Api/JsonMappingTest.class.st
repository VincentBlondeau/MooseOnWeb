Class {
	#name : #JsonMappingTest,
	#superclass : #Object,
	#instVars : [
		'name',
		'id'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #mapping }
JsonMappingTest class >> neoJsonMapping: mapper [
mapper for: self do: [ :mapping |
		mapping mapInstVars: #(id name)].
]

{ #category : #'as yet unclassified' }
JsonMappingTest >> id [
	^id
]

{ #category : #'as yet unclassified' }
JsonMappingTest >> id: aID [
	id := aID
]

{ #category : #'as yet unclassified' }
JsonMappingTest >> name [
	^name.
]

{ #category : #'as yet unclassified' }
JsonMappingTest >> name: aName [
	name := aName .
]
