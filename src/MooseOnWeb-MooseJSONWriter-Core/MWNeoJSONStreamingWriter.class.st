"
A MWNeoJSONStreamingWriter is a serializer for moose headers. Extend the NeoJSONStreamingWriter used for write Json Dictionaries.

Using the double dispatch, MWNeoJSONStreamingWriter choose which elements of moose to serialize for the header of the JSON depending of the class.

"
Class {
	#name : #MWNeoJSONStreamingWriter,
	#superclass : #NeoJSONStreamingWriter,
	#category : #'MooseOnWeb-MooseJSONWriter-Core'
}

{ #category : #writing }
MWNeoJSONStreamingWriter >> mooseName: mooseObject [
	| stream |
	stream := WriteStream with: ''.
	mooseObject mooseDisplayStringOn: stream.
	^stream contents
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderClonedFragment: mooseEntity [
	self writeKey: 'id' value: mooseEntity mooseID.
	self writeKey: 'name' value: mooseEntity formattedName.
	self writeKey: 'type' value: mooseEntity class name.
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderFamixChange: aFamixChange [
	self writeKey: 'name' value: (aFamixChange name).
	self writeKey: 'color' value: (aFamixChange color asHTMLColor).
	self writeKey: 'entityID' value: (aFamixChange entity mooseID)
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderMooseEntity: mooseEntity [
	self writeKey: 'id' value: mooseEntity mooseID.
	self writeKey: 'name' value: (self mooseName: mooseEntity).
	self writeKey: 'type' value: mooseEntity class name.
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderMooseGroup: mooseGroup [
	self writeKey: 'name' value: (self mooseName: mooseGroup).
	self writeKey: 'type' value: mooseGroup class name.
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderMooseModel: mooseModel [
	self writeKey: 'id' value: mooseModel mooseID.
	self writeKey: 'name' value: (self mooseName: mooseModel).
	self writeKey: 'type' value: mooseModel class name.
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderProjectVersion: projectVersion [
	self writeKey: 'id' value: projectVersion mooseID.
	self writeKey: 'name' value: (self mooseName: projectVersion).
	self writeKey: 'type' value: projectVersion class name.
	self writeKey: 'date' value: projectVersion date asUnixTime.
	self writeKey: 'modelID' value: projectVersion mooseModel mooseID.
]
