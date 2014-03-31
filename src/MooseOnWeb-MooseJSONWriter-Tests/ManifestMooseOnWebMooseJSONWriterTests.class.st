"
I stores metadata on true and false positive critics. These meta data are used by the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMooseOnWebMooseJSONWriterTests,
	#superclass : #Object,
	#category : #'MooseOnWeb-MooseJSONWriter-Tests'
}

{ #category : #'meta data' }
ManifestMooseOnWebMooseJSONWriterTests class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2014-03-30T23:56:45.625883+02:00') #(#(#RGClassDefinition #(#MWRequestVisitor)) #'2014-03-30T23:56:45.729883+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebMooseJSONWriterTests class >> rejectRules [
^ #()
]
