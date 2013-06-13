"
A MooseOnWebRestServerDelegate is the entry point of the mooseOnWeb REST Api.

Instance Variables

"
Class {
	#name : #MooseOnWebRestServerDelegate,
	#superclass : #ZnJSONRestServerDelegate,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #'as yet unclassified' }
MooseOnWebRestServerDelegate >> initialize [ 
	self uriSpace: ZnCallHierarchyRestUriSpace new.
	self uriSpace rootClass: MooseOnWebRestCall
]
