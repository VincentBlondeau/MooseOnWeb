Class {
	#name : #JsonWriter,
	#superclass : #JsonVisitor,
	#category : #'MooseOnWeb-JsonMagritteExample'
}

{ #category : #visiting }
JsonWriter >> visitDateAndTimeDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: (aDescription accessor read: self object) asSeconds
]

{ #category : #visiting }
JsonWriter >> visitDateDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: (aDescription accessor read: self object) asSeconds
]

{ #category : #'visiting-description' }
JsonWriter >> visitElementDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: (aDescription accessor read: self object)
]

{ #category : #visiting }
JsonWriter >> visitRelationDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: (self class new 
			document: (aDescription accessor read: self object);
			visit: (aDescription accessor read: self object) magritteDescription;
			json)
]

{ #category : #visiting }
JsonWriter >> visitTimeDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: (aDescription accessor read: self object) asSeconds
]

{ #category : #visiting }
JsonWriter >> visitToManyMongoRelationDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: ((aDescription accessor read: self object) 
			collect: [:each | each sid]) asArray
]

{ #category : #visiting }
JsonWriter >> visitToManyRelationDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: ((aDescription accessor read: self object) collect: [:each |
			self class new 
				object: each;
				visit: each magritteDescription;
				json]) asArray
]

{ #category : #visiting }
JsonWriter >> visitToOneMongoRelationDescription: aDescription [
	| o |
	o := aDescription accessor read: self object. 
	self json 
		at: aDescription accessor readSelector asString 
		put: o sid
]

{ #category : #visiting }
JsonWriter >> visitToOneRelationDescription: aDescription [
	self json 
		at: aDescription accessor readSelector asString 
		put: (self class new 
			object: (aDescription accessor read: self object);
			visit: (aDescription accessor read: self object) magritteDescription;
			json)
]
