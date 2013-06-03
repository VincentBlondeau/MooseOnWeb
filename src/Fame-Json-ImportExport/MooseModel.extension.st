Extension { #name : #MooseModel }

{ #category : #'*Fame-Json-ImportExport' }
MooseModel >> asJson [
	| stream |
	stream :=WriteStream on:''.
	self exportToJsonStream: stream.
	^stream contents.
]

{ #category : #'*Fame-Json-ImportExport' }
MooseModel classSide >> exportAsJson: aModel to: aStream [
	self exportAsJson: aModel withMetamodel: self meta to: aStream
]

{ #category : #'*Fame-Json-ImportExport' }
MooseModel classSide >> exportAsJson: aModel withMetamodel: aMetamodel to: aStream [ 
	| tower  |
	tower := FMCompleteTower new.
	tower metaMetamodel: aMetamodel metamodel.
	tower metamodel: aMetamodel.
	tower model: ((FMRepository with: aMetamodel) addAll: aModel entities).
	tower model exportAsJsonOn: aStream
]

{ #category : #'*Fame-Json-ImportExport' }
MooseModel >> exportToJsonStream: aStream [ 

	self class 
		exportAsJson: self
		to: aStream
]
