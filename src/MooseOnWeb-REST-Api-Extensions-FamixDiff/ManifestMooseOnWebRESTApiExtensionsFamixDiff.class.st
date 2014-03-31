"
I stores metadata on true and false positive critics. These meta data are used by the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMooseOnWebRESTApiExtensionsFamixDiff,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Extensions-FamixDiff'
}

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiExtensionsFamixDiff class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2014-03-30T23:56:46.178883+02:00') #(#(#RGClassDefinition #(#MWRequestVisitor)) #'2014-03-30T23:56:46.283883+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiExtensionsFamixDiff class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiExtensionsFamixDiff class >> ruleSentNotImplementedRuleV1TODO [
^ #(#(#(#RGMethodDefinition #(#MWFamixDiffHandler #DoItIn: #false)) #'2014-03-30T23:56:48.737883+02:00') )
]
