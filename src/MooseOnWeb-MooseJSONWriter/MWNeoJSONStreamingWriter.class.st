Class {
	#name : #MWNeoJSONStreamingWriter,
	#superclass : #NeoJSONStreamingWriter,
	#category : #'MooseOnWeb-MooseJSONWriter'
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
