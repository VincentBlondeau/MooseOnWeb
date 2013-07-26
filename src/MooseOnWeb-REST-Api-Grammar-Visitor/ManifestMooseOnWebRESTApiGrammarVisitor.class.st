Class {
	#name : #ManifestMooseOnWebRESTApiGrammarVisitor,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Grammar-Visitor'
}

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarVisitor class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWRequestVisitor)) #'2013-07-26T15:24:54.502+02:00') #(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2013-07-26T15:24:54.684+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarVisitor class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarVisitor class >> ruleImplementedNotSentRuleV1FalsePositive^ [ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarVisitor class >> ruleNoClassCommentRuleV1FalsePositive^ [ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarVisitor class >> ruleSubclassResponsibilityNotDefinedRuleV1FalsePositive^ [ #()
]
