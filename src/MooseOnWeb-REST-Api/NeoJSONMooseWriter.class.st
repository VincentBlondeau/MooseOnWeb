Class {
	#name : #NeoJSONMooseWriter,
	#superclass : #NeoJSONWriter,
	#instVars : [
		'root'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #'initialize-release' }
NeoJSONMooseWriter >> initialize [ 
	super initialize .
	root := true.
]

{ #category : #writing }
NeoJSONMooseWriter >> mooseName: mooseObject [
	| stream |
	stream := WriteStream with: ''.
	mooseObject mooseDisplayStringOn: stream.
	^stream contents
]

{ #category : #writing }
NeoJSONMooseWriter >> writeMooseEntity: mooseEntity [

	self
		writeMapStreamingDo: [ :jsonMapWriter | | stream |
			jsonMapWriter writeKey: 'id' value: mooseEntity mooseID.
			jsonMapWriter writeKey: 'name' value: (self mooseName: mooseEntity).
			jsonMapWriter writeKey: 'type' value: mooseEntity class name.
			(root and: level < 2)
				ifTrue: [ 
					| list |
					list := mooseEntity allDeclaredProperties.
					(list sort: [ :a :b | a name < b name ])
						do: [ :a | 
							| value |
							value := mooseEntity perform: a implementingSelector.
							value isNil not
								ifTrue: [ 
									((value isKindOf: Collection) and: [value isEmpty])
										ifFalse: [ jsonMapWriter writeKey: a name value: value ] ] ] ] ]
]

{ #category : #writing }
NeoJSONMooseWriter >> writeMooseGroup: mooseGroup [
	self
		writeMapStreamingDo: [ :jsonMapWriter | 
			((mooseGroup isKindOf: MooseModel) and: [mooseGroup ~= MooseModel root])
				ifTrue: [ jsonMapWriter writeKey: 'id' value: mooseGroup mooseID ].
			jsonMapWriter writeKey: 'name' value: (self mooseName: mooseGroup).
			jsonMapWriter writeKey: 'type' value: mooseGroup class name.
			(root and: level < 2)
				ifTrue: [ 
					jsonMapWriter writeKey: 'entities' value: mooseGroup entities.
					root := false ] ]
]
