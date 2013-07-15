"
An EntitiesHandler is a catcher for the GET entities request
"
Class {
	#name : #MWEntitiesHandler,
	#superclass : #MWRestCallHandler,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWEntitiesHandler class >> pattern [ 
	^#( 'mooseOnWeb' 'entities' )
]

{ #category : #public }
MWEntitiesHandler >> get [
	self notImplemented
	
]
