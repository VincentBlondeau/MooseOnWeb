"
A MWNeoJSONWriter is a json serializer for Moose Entities. The JSON is composed of 2 parts: 
- the header : contains id (if accessible by the MWApi), type and name of the entity
- the content : contains the result of each property described in the meta model. If the result is a group of entities, only the entities headers are displayed.

You can extend the writer by subclass it and change the class returned by mapWriteClass if you want to use your JSON Streaming Writer

Instance Variables
	root:		boolean

root
	- true if is the first level of recursivity in the moose entity

"
Class {
	#name : #MWNeoJSONWriter,
	#superclass : #NeoJSONWriter,
	#instVars : [
		'root'
	],
	#category : #'MooseOnWeb-MooseJSONWriter-Core'
}

{ #category : #writing }
MWNeoJSONWriter >> detailled [
	^(root and: [ level < 2 ])
]

{ #category : #'initialize-release' }
MWNeoJSONWriter >> initialize [ 
	super initialize .
	root := true.
]

{ #category : #accessing }
MWNeoJSONWriter >> mapWriterClass [
	^ MWNeoJSONStreamingWriter
]

{ #category : #writing }
MWNeoJSONWriter >> mooseName: mooseObject [
	| stream |
	stream := WriteStream with: ''.
	mooseObject mooseDisplayStringOn: stream.
	^ stream contents
]

{ #category : #writing }
MWNeoJSONWriter >> writeMooseEntity: mooseEntity [
	self writeMapStreamingDo: [ :jsonMapWriter |
			mooseEntity neoJsonHeaderOn: jsonMapWriter.
			self detailled
				ifTrue: [ 
					| list |
					list := mooseEntity allDeclaredProperties.
					(list sort: [ :a :b | a name < b name ])
						do: [ :a | 
							| value |
							value := mooseEntity perform: a implementingSelector.
							value isNil
								ifFalse: [ 
									((value isKindOf: Collection) and: [value isEmpty])
										ifFalse: [ jsonMapWriter writeKey: a name value: value ] ] ] ] ]
]

{ #category : #writing }
MWNeoJSONWriter >> writeMooseGroup: mooseGroup [
	self writeMapStreamingDo: [ :jsonMapWriter | 
			mooseGroup neoJsonHeaderOn: jsonMapWriter.
			jsonMapWriter writeKey: 'entities' value: mooseGroup entities.
			root := false 
	] 
]

{ #category : #writing }
MWNeoJSONWriter >> writeMooseModel: mooseModel [
	self writeMapStreamingDo: [ :jsonMapWriter | 
			mooseModel neoJsonHeaderOn: jsonMapWriter.
			self detailled
				ifTrue: [ 
					jsonMapWriter writeKey: 'entities' value: mooseModel entities.
					root := false ] ]
]

{ #category : #writing }
MWNeoJSONWriter >> writeStreamingDo: block [
	| mapWriter |
	mapWriter := self mapWriterClass on: self.
	self indentedDo: [ block value: mapWriter ].
	mapWriter wasUsed
		ifTrue: [ self newlineIndent ]
		ifFalse: [ self prettyPrintSpace ]
]
