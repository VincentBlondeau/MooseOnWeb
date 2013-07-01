"
A MooseOnWebRestServerDelegate is the entry point of the mooseOnWeb REST Api.

Instance Variables

"
Class {
	#name : #MooseOnWebRestServerDelegate,
	#superclass : #ZnJSONRestServerDelegate,
	#classVars : [
		'server'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #'as yet unclassified' }
MooseOnWebRestServerDelegate class >> server [
	^server
]

{ #category : #'as yet unclassified' }
MooseOnWebRestServerDelegate class >> serverStartOn: port [
	server := ZnServer startOn: port.
	server delegate: MooseOnWebRestServerDelegate new.
]

{ #category : #'as yet unclassified' }
MooseOnWebRestServerDelegate class >> serverStop [
	server stop
]

{ #category : #'as yet unclassified' }
MooseOnWebRestServerDelegate >> initialize [ 
	self uriSpace: ZnCallHierarchyRestUriSpace new.
	self uriSpace rootClass: MooseOnWebRestCall
]
