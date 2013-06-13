"
An EntitiesHandler is a catcher for the GET entities request
"
Class {
	#name : #EntitiesHandler,
	#superclass : #MooseOnWebRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
EntitiesHandler class >> pattern [ 
	^#( 'mooseOnWeb' 'entities' )
]

{ #category : #public }
EntitiesHandler >> get [
	self notImplemented
	
]
