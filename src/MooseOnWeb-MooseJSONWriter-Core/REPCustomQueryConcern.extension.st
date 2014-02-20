Extension { #name : #REPCustomQueryConcern }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
REPCustomQueryConcern >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderQueryConcern: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
REPCustomQueryConcern >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeQueryConcernEntity: self.

]
