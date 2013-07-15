Extension { #name : #MooseModel }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseModel >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseModel: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseModel >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseModel: self.

]
