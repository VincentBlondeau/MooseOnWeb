Extension { #name : #SYNDisplayProperty }

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
SYNDisplayProperty >> neoJsonHeaderOn:jsonMapWriter [
	jsonMapWriter writeHeaderDisplayProperty: self.
]

{ #category : #'*MooseOnWeb-MooseJSONWriter-Core' }
SYNDisplayProperty >> neoJsonOn:neoJSONWriter [
	neoJSONWriter writeDisplayProperty: self.
]
