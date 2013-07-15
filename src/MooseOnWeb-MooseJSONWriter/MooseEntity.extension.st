Extension { #name : #MooseEntity }

{ #category : #'*MooseOnWeb-MooseJSONWriter' }
MooseEntity >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseEntity: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter' }
MooseEntity >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseEntity: self.

]
