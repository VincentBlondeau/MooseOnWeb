"
A ModelsHandler is a catcher for the GET models request.
"
Class {
	#name : #ModelsHandler,
	#superclass : #MooseOnWebRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
ModelsHandler class >> pattern [
	^ #('mooseOnWeb' 'models')
]

{ #category : #public }
ModelsHandler >> get [
	"the method asZnMimeType doesn't work properly !"
	
	"request accept asZnMimeType = ZnMimeType applicationJson ifTrue: [ "
 	self listMooseModels." ] ifFalse:  [ self unsupportedMediaType ]"
	self sendJson 
]

{ #category : #operations }
ModelsHandler >> listMooseModels [
	answer:= MooseModel root
]
