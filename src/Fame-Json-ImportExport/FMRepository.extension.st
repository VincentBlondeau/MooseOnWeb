Extension { #name : #FMRepository }

{ #category : #'*Fame-Json-ImportExport' }
FMRepository >> acceptWithoutGUI: aParseClient [

	| visitor |
	visitor := FMRepositoryVisitorJson new.
	visitor model: self.
	visitor printer: aParseClient.
	visitor run.
]

{ #category : #'*Fame-Json-ImportExport' }
FMRepository >> exportAsJsonOn: aStream [

	self exportOn: aStream with: FMJsonPrinter.
]

{ #category : #'*Fame-Json-ImportExport' }
FMRepository >> exportOn: aStream with: aPrinter [ 

	| printer |
	printer := aPrinter new stream: aStream.
	self acceptWithoutGUI: printer.
]
