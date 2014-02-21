Extension { #name : #MooseModel }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
MooseModel >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseModel: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
MooseModel >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseModel: self.

]
