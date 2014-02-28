Extension { #name : #MooseProjectVersion }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
MooseProjectVersion >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderProjectVersion: self.
]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
MooseProjectVersion >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeProjectVersion: self
]
