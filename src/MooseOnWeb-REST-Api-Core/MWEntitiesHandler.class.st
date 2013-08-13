"
An EntitiesHandler is a handler for entities request.
The uri to come here is mooseOnWeb/entities (see class side).

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
	self notFound 
	
]
