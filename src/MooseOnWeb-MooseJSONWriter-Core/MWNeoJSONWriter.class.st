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

{ #category : #writing }
MWNeoJSONWriter >> mooseName: mooseObject [
	| stream |
	stream := WriteStream with: ''.
	mooseObject mooseDisplayStringOn: stream.
	^stream contents
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
			self detailled
				ifTrue: [ 
					jsonMapWriter writeKey: 'entities' value: mooseGroup entities.
					root := false ] ]
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
	mapWriter := MWNeoJSONStreamingWriter on: self.
	self indentedDo: [
		block value: mapWriter ].
	mapWriter wasUsed
		ifTrue: [ self newlineIndent ]
		ifFalse: [ self prettyPrintSpace ]
]
