Extension { #name : #FamixChange }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
FamixChange >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderFamixChange: self.
]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
FamixChange >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeFamixChange: self.
]
