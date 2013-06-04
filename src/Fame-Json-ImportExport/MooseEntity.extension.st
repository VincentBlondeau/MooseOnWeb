Extension { #name : #MooseEntity }

{ #category : #'*Fame-Json-ImportExport' }
MooseEntity >> asJson [
	^self name
]

{ #category : #'*Fame-Json-ImportExport' }
MooseEntity >> isMooseEntity [
	^ true
]
