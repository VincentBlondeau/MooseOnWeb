Extension { #name : #MooseModel }

{ #category : #'*MooseOnWeb-MooseJSONWriter' }
MooseModel >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseModel: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter' }
MooseModel >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseModel: self.

]
