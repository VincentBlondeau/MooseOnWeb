Extension { #name : #MooseAbstractGroup }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseAbstractGroup >> neoJsonHeaderOn: jsonMapWriter [
	jsonMapWriter writeHeaderMooseGroup: self.

]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core-Core' }
MooseAbstractGroup >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMooseGroup: self.

]
