Extension { #name : #FMRepository }

{ #category : #'*Fame-Json-ImportExport' }
FMRepository >> exportAsJsonOn: aStream [

	self exportOn: aStream with: FMJsonPrinter.
]

{ #category : #'*Fame-Json-ImportExport' }
FMRepository >> exportOn: aStream with: aPrinter [ 

	| printer |
	printer := aPrinter new stream: aStream.
	self accept: printer.
]
