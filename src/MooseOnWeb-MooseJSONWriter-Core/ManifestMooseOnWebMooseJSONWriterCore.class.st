"
I stores metadata on true and false positive critics. These meta data are used by the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMooseOnWebMooseJSONWriterCore,
	#superclass : #Object,
	#category : #'MooseOnWeb-MooseJSONWriter-Core'
}

{ #category : #'meta data' }
ManifestMooseOnWebMooseJSONWriterCore class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2014-03-30T23:56:45.920883+02:00') #(#(#RGClassDefinition #(#MWRequestVisitor)) #'2014-03-30T23:56:46.028883+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebMooseJSONWriterCore class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebMooseJSONWriterCore class >> ruleSentNotImplementedRuleV1TODO [
^ #(#(#(#RGMethodDefinition #(#MWNeoJSONStreamingWriterExtended #writeHeaderDisplayProperty: #false)) #'2014-03-30T23:56:48.951883+02:00') #(#(#RGMethodDefinition #(#MWNeoJSONStreamingWriterExtended #writeHeaderClonedFragment: #false)) #'2014-03-30T23:56:48.951883+02:00') )
]
