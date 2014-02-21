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
	mooseModel ~= MooseModel root
		ifTrue: [ self writeKey: 'id' value: mooseModel mooseID ].
	self writeKey: 'name' value: (self mooseName: mooseModel).
	self writeKey: 'type' value: mooseModel class name.
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderMooseProject: mooseProject [
	self writeKey: 'id' value: (mooseProject mooseID).
	self writeKey: 'name' value: (self mooseName: mooseProject).
	self writeKey: 'type' value: mooseProject class name.
]

{ #category : #writing }
MWNeoJSONStreamingWriter >> writeHeaderQueryConcern: aQueryConcern [
	self writeKey: 'id' value: aQueryConcern mooseID.
	self writeKey: 'label' value: aQueryConcern label.
	self writeKey: 'explanation' value: aQueryConcern explanation.
	self writeKey: 'result' value: aQueryConcern result.
	
]
