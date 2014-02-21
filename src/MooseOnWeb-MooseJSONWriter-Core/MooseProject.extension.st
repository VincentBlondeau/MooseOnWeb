Extension { #name : #MooseProject }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
MooseProject >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseProject: self
]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
MooseProject >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseProject: self
]
