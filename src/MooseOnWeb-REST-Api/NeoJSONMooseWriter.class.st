Class {
	#name : #NeoJSONMooseWriter,
	#superclass : #NeoJSONWriter,
	#instVars : [
		'root'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #'as yet unclassified' }
NeoJSONMooseWriter >> initialize [ 
	super initialize .
	root := true.
]

{ #category : #'as yet unclassified' }
NeoJSONMooseWriter >> writeMooseEntity: mooseEntity [
	self
		writeMapStreamingDo: [ :jsonMapWriter | 
			jsonMapWriter writeKey: 'id' value: mooseEntity mooseID.
			jsonMapWriter writeKey: 'name' value: mooseEntity mooseName.
			jsonMapWriter writeKey: 'type' value: mooseEntity class name.
			(root and: level < 2)
				ifTrue: [ 
					| list |
					list := mooseEntity allDeclaredProperties.
					(list sort: [ :a :b | a name < b name ])
						do: [ :a | jsonMapWriter writeKey: a name value: (mooseEntity perform: a implementingSelector) ] ] ]	"ifFalse: [ 
			books add: aBook id.
			super writeObject: aBook ].
	self writeObject: mooseGroup.
	level < 1 ifTrue:[self writeList: mooseGroup entities.]."
]

{ #category : #'as yet unclassified' }
NeoJSONMooseWriter >> writeMooseGroup: mooseGroup [
	self
		writeMapStreamingDo: [ :jsonMapWriter | 
			((mooseGroup isKindOf: MooseModel) and: mooseGroup ~= MooseModel root)
				ifTrue: [ jsonMapWriter writeKey: 'id' value: mooseGroup mooseID ].
			jsonMapWriter writeKey: 'name' value: mooseGroup mooseName.
			jsonMapWriter writeKey: 'type' value: mooseGroup class name.
			(root and: level < 2)
				ifTrue: [ 
					jsonMapWriter writeKey: 'entities' value: mooseGroup entities.
					root := false ] ]	"ifFalse: [ 
			books add: aBook id.
			super writeObject: aBook ].
	self writeObject: mooseGroup.
	level < 1 ifTrue:[self writeList: mooseGroup entities.]."
]
