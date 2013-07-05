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

{ #category : #accessing }
MooseOnWebRestServerDelegate class >> server [
	^server
]

{ #category : #managing }
MooseOnWebRestServerDelegate class >> serverStartOn: port [
	server := ZnServer startOn: port.
	server delegate: MooseOnWebRestServerDelegate new.
	server register.
]

{ #category : #managing }
MooseOnWebRestServerDelegate class >> serverStop [
	server stop
]

{ #category : #'initialize-release' }
MooseOnWebRestServerDelegate >> initialize [ 
	self uriSpace: ZnCallHierarchyRestUriSpace new.
	self uriSpace rootClass: MooseOnWebRestCall
]
