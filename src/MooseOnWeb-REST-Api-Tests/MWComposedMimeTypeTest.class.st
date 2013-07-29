"
A ZnComposedMimeTypeTest is a test class for testing the behavior of ZnComposedMimeType
"
Class {
	#name : #MWComposedMimeTypeTest,
	#superclass : #TestCase,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #tests }
MWComposedMimeTypeTest >> testAsMWComposedMimeTypeConvertionAndOrder [
	| data result |
	data := 'text/*,text/html,text/html;level=1,*/*' asMWComposedMimeType.
	result := {
			(ZnMimeType main: 'text' sub: 'html') parameterAt: 'level' put: '1'.
			ZnMimeType main: 'text' sub: 'html'.
			ZnMimeType text.
			ZnMimeType any
		} asOrderedCollection.
	self assert: data collection equals: result.
]

{ #category : #tests }
MWComposedMimeTypeTest >> testFindMatchesWith [
	| data |
	data := '*/*;q=0.8,text/html;charset=utf-8,application/xhtml+xml;q=0.95,application/xml;q=0.9' asMWComposedMimeType.
	self assert: 
			(data findMatchesWith: {ZnMimeType textHtml}) 
		equals: 
			{ZnMimeType textHtml} asOrderedCollection.
	self assert: 
			(data findMatchesWith: {ZnMimeType textHtml. ZnMimeType applicationJson}) 
		equals: 
			{ZnMimeType textHtml. ZnMimeType applicationJson} asOrderedCollection.		
		
	
]

{ #category : #tests }
MWComposedMimeTypeTest >> testFindMatchesWithNoneMatches [
	| data |
	data := 'text/html;charset=utf-8,application/xhtml+xml;q=0.95,application/xml;q=0.9' asMWComposedMimeType.
	self assert: 
			(data findMatchesWith: {ZnMimeType applicationJson}) 
		equals: 
			OrderedCollection new .		
		
	
]

{ #category : #tests }
MWComposedMimeTypeTest >> testResultCollectionIsOrdered [

	| data result |
	result := {
		'text/html;charset=utf-8' asZnMimeType .
		'application/xhtml+xml;q=0.95' asZnMimeType . 
		'application/xml;q=0.9' asZnMimeType .
		'*/*;q=0.8' asZnMimeType} asOrderedCollection.
	data := '*/*;q=0.8,text/html;charset=utf-8,application/xhtml+xml;q=0.95,application/xml;q=0.9' asMWComposedMimeType.
	self assert: data collection equals: result.
]
