Class {
	#name : #MWNeoJSONWriterExtended,
	#superclass : #MWNeoJSONWriter,
	#category : #'MooseOnWeb-MooseJSONWriter-Core'
}

{ #category : #'as yet unclassified' }
MWNeoJSONWriterExtended >> mapWriterClass [
	^ MWNeoJSONStreamingWriterExtended
]

{ #category : #writing }
MWNeoJSONWriterExtended >> writeDisplayProperty: aProperty [
	self writeMapStreamingDo: [ :jsonMapWriter | aProperty neoJsonHeaderOn: jsonMapWriter ]
]

{ #category : #writing }
MWNeoJSONWriterExtended >> writeFamixChange: aFamixChange [
	self writeMapStreamingDo: [ :jsonMapWriter | 
			aFamixChange neoJsonHeaderOn: jsonMapWriter ]
]

{ #category : #writing }
MWNeoJSONWriterExtended >> writeQueryConcern: aQueryConcern [
	self writeMapStreamingDo: [ :jsonMapWriter | 
			aQueryConcern neoJsonHeaderOn: jsonMapWriter.
]
]
