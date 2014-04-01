Extension { #name : #MooseEntity }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseEntity >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderFragmentLocation: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseEntity >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseEntity: self.

]
