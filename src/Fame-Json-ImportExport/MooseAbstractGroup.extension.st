Extension { #name : #MooseAbstractGroup }

{ #category : #'*Fame-Json-ImportExport' }
MooseAbstractGroup >> asJson [
	^MooseModel new addAll: self; asJson
]

{ #category : #'*Fame-Json-ImportExport' }
MooseAbstractGroup >> isMooseGroup [
	^ true
]
