Class {
	#name : #MWAcceptTests,
	#superclass : #MWMockTests,
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
MWAcceptTests >> setUp [
	super setUp.
	handler := MWRestCallHandler new
		request: request;
		delegate: delegate;
		yourself.
]

{ #category : #tests }
MWAcceptTests >> testAcceptMimeTypesFrom [
	request should
		receive: 'headers';
		answers:
				(Dictionary new
						at: 'Accept' put: 'text/html;charset=utf-8,application/xhtml+xml;q=0.95,application/xml;q=0.9,*/*;q=0.8';
						yourself).
	self
		assert:
			(handler
				acceptMimeTypesFrom: request
				containing:
					{(ZnMimeType applicationJson).
					(ZnMimeType applicationXml)})
		equals:
			{(ZnMimeType applicationXml).
			(ZnMimeType applicationJson)} asOrderedCollection
]
