Class {
	#name : #ManifestMooseOnWebRESTApiGrammarCore,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Grammar-Core'
}

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarCore class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWRequestVisitor)) #'2013-07-26T15:24:53.23+02:00') #(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2013-07-26T15:24:53.354+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarCore class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarCore class >> ruleOnlyReadOrWrittenVariableRuleV1FalsePositive [
^ #(#(#(#RGClassDefinition #(#MWActionGrammar)) #'2014-03-30T23:56:47.302883+02:00') )
]
