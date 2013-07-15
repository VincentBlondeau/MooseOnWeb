Extension { #name : #MooseEntity }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseEntity >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseEntity: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseEntity >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseEntity: self.

]
