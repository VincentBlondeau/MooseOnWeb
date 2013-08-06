Class {
	#name : #ManifestMooseOnWebRESTApiGrammarTests,
	#superclass : #Object,
	#category : #'MooseOnWeb-REST-Api-Grammar-Tests'
}

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarTests class >> rejectClasses [
^ #(#(#(#RGClassDefinition #(#MWRequestVisitor)) #'2013-07-26T15:24:53.742+02:00') #(#(#RGClassDefinition #(#MWEntitiesHandlerWithID)) #'2013-07-26T15:24:53.864+02:00') )
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarTests class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestMooseOnWebRESTApiGrammarTests class >> ruleSentNotImplementedRuleV1TODO [
^ #(#(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testSingleAction #false)) #'2013-07-26T15:24:57.324000005+02:00') #(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testUnionActions #false)) #'2013-07-26T15:24:57.324000004+02:00') #(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testFullActionsSentence #false)) #'2013-07-26T15:24:57.324000006+02:00') #(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testMultipleExpressionActionsSentence #false)) #'2013-07-26T15:24:57.324000007+02:00') #(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testOnEachAction #false)) #'2013-07-26T15:24:57.324000001+02:00') #(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testCombineActions1 #false)) #'2013-07-26T15:24:57.324000002+02:00') #(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testSingleActionWithParameter #false)) #'2013-07-26T15:24:57.324000003+02:00') #(#(#RGMethodDefinition #(#MWRequestMapExecutorVisitorTests #testOnResultAction #false)) #'2013-07-26T15:24:57.324+02:00') )
]
