Extension { #name : #MooseAbstractGroup }

{ #category : #'*MooseOnWeb-MooseJSONWriter' }
MooseAbstractGroup >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseGroup: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter' }
MooseAbstractGroup >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseGroup: self.

]
