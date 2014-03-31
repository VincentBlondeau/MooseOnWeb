"
I stores metadata on true and false positive critics. These meta data are used by the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMooseOnWebRESTApiExtensionsTests,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Extensions-Tests'
}

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiExtensionsTests class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2014-03-30T23:56:46.414883+02:00') #(#(#RGClassDefinition #(#MWRequestVisitor)) #'2014-03-30T23:56:46.536883+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiExtensionsTests class >> rejectRules [
^ #()
]
