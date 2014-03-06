Extension { #name : #SYNQueryConcern }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
SYNQueryConcern >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderQueryConcern: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
SYNQueryConcern >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeQueryConcern: self.

]
