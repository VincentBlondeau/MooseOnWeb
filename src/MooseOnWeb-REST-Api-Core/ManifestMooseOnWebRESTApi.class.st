Class {
	#name : #ManifestMooseOnWebRESTApi,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWRequestVisitor)) #'2013-07-26T15:24:53.994+02:00') #(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2013-07-26T15:24:54.114+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleBadMessageRuleV1FalsePositive^ [ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleCodeCruftLeftInMethodsRuleV1TODO [
^ #(#(#(#RGMethodDefinition #(#MWModelsHandler #post #false)) #'2013-07-26T15:24:57.622+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleLawOfDemeterRuleV1TODO [
^ #(#(#(#RGMethodDefinition #(#MWEntitiesHandlerWithID #listActions #false)) #'2013-07-12T16:33:34.188000001+02:00') #(#(#RGMethodDefinition #(#MWHelpHandler #get #false)) #'2013-07-12T16:33:34.188+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleLongMethodsRuleV1FalsePositive^ [ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleLongMethodsRuleV1TODO [
^ #(#(#(#RGMethodDefinition #(#MWEntitiesHandlerWithID #get #false)) #'2013-07-12T16:33:35.098000002+02:00') #(#(#RGMethodDefinition #(#MWModelsHandler #delete #false)) #'2013-07-12T16:33:35.098000001+02:00') #(#(#RGMethodDefinition #(#String #asMessage #false)) #'2013-07-12T16:33:35.098000003+02:00') #(#(#RGMethodDefinition #(#MWModelsHandler #post #false)) #'2013-07-12T16:33:35.098000005+02:00') #(#(#RGMethodDefinition #(#MWNeoJSONWriter #writeMooseEntity: #false)) #'2013-07-12T16:33:35.098000004+02:00') #(#(#RGMethodDefinition #(#MWEntitiesHandlerWithID #search #false)) #'2013-07-12T16:33:35.098+02:00') #(#(#RGMethodDefinition #(#MWEntitiesHandlerWithID #get #false)) #'2013-07-26T15:24:56.568000001+02:00') #(#(#RGMethodDefinition #(#MWModelsHandler #post #false)) #'2013-07-26T15:24:56.568+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleMissingSubclassResponsibilityRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#MWEntitiesHandlerWithID #get #false)) #'2013-07-12T16:33:33.284+02:00') #(#(#RGMethodDefinition #(#MWModelsHandler #get #false)) #'2013-07-12T16:33:33.284000001+02:00') #(#(#RGMethodDefinition #(#MWEntitiesHandler #get #false)) #'2013-07-12T16:33:33.284000002+02:00') #(#(#RGMethodDefinition #(#MWHelpHandler #get #false)) #'2013-07-12T16:33:33.282+02:00') #(#(#RGMethodDefinition #(#MWHelpHandler #get #false)) #'2013-07-26T15:24:55.602+02:00') #(#(#RGMethodDefinition #(#MWModelsHandler #get #false)) #'2013-07-26T15:24:55.602000001+02:00') #(#(#RGMethodDefinition #(#MWEntitiesHandler #get #false)) #'2013-07-26T15:24:55.602000002+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleNoClassCommentRuleV1TODO [
^ #(#(#(#RGClassDefinition #(#MWServerCommandLineHandler)) #'2013-07-12T16:33:33.738000001+02:00') #(#(#RGClassDefinition #(#MWNeoJSONWriter)) #'2013-07-12T16:33:33.738+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApi class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#MWEntitiesHandlerWithID #search #false)) #'2013-07-12T16:33:32.604+02:00') #(#(#RGMethodDefinition #(#MWModelsHandler #post #false)) #'2013-07-12T16:33:32.604000001+02:00') )
]
