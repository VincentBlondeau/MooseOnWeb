Class {
	#name : #FMJsonPrinterTest,
	#superclass : #TestCase,
	#category : #'Fame-Json-ImportExport'
}

{ #category : #tests }
FMJsonPrinterTest >> testWrite [
"	| printer |
	printer := FMJsonPrinter new onString.
	FMMetaRepository fm3 accept: printer.
	Transcript show: printer stream contents"
]

{ #category : #tests }
FMJsonPrinterTest >> testWriteSimple [
	| printer model tower repository moosemodel stream |
	stream := (FileSystem disk workingDirectory / 'numbersJson.txt') writeStream.
	printer := FMJsonPrinter new stream: stream.
	moosemodel := MooseModel root at: 4.
	model := tower := FMCompleteTower new.
	tower metaMetamodel: MooseModel meta metamodel.
	tower metamodel: MooseModel meta.
	tower model: (repository := (FMRepository with: MooseModel meta) addAll: moosemodel entities).
	tower model accept: printer.
	stream close
]
