Extension { #name : #MooseProjectVersion }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
MooseProjectVersion >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderProjectVersion: self.
]
