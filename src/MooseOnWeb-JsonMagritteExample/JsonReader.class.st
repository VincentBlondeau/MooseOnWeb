Class {
	#name : #JsonReader,
	#superclass : #JsonVisitor,
	#category : #'MooseOnWeb-JsonMagritteExample'
}

{ #category : #'visiting-description' }
JsonReader >> visitDateAndTimeDescription: aDescription [
	| key |
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
		aDescription accessor 
			write: (DateAndTime fromSeconds: val) 
			to: self object]
]

{ #category : #'visiting-description' }
JsonReader >> visitDateDescription: aDescription [
	| key |
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
		aDescription accessor 
			write: (Date fromSeconds: val) 
			to: self object]
]

{ #category : #'visiting-description' }
JsonReader >> visitElementDescription: aDescription [
	| key |
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
		aDescription accessor write: val to: self object]
]

{ #category : #'visiting-description' }
JsonReader >> visitTimeDescription: aDescription [
	| key |
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
		aDescription accessor 
			write: (Time fromSeconds: val) 
			to: self object]
]

{ #category : #'visiting-description' }
JsonReader >> visitToManyMongoRelationDescription: aDescription [
	"| key collection objects |
	self halt.
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
			collection := aDescription kind withAll: val.
			objects := false
				ifTrue: [
					collection collect: [:each |
						ShProxy sid: each objectClass: aDescription classes first]]
				ifFalse: [
					collection collect: [:each |
						aDescription classes first sid: each]].
			aDescription accessor 
				write: (objects select: [:each | each notNil])
				to: self object]"
]

{ #category : #'visiting-description' }
JsonReader >> visitToManyRelationDescription: aDescription [
	"| key |
	self halt.
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
		aDescription accessor 
			write: (val collect: [:each |
				aDescription classes first fromJson: each]) 
			to: self object]"
]

{ #category : #'visiting-description' }
JsonReader >> visitToOneMongoRelationDescription: aDescription [
	"| key o |
	self halt.
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
		o := false
			ifTrue: [ShProxy sid: val objectClass: aDescription classes first]
			ifFalse: [aDescription classes first sid: val].
		aDescription accessor 
			write: o
			to: self object]"
]

{ #category : #'visiting-description' }
JsonReader >> visitToOneRelationDescription: aDescription [
	"| key |
	self halt.
	key := aDescription accessor readSelector asString. 
	self json at: key ifPresent: [:val |
		aDescription accessor 
			write: (aDescription classes first fromJson: val) 
			to: self object]"
]
