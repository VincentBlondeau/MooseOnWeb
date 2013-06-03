Class {
	#name : #FMJsonPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'mooseModel'
	],
	#category : #'Fame-Json-ImportExport'
}

{ #category : #tests }
FMJsonPrinterTest >> setUp [
	mooseModel := MooseModel new
]

{ #category : #tests }
FMJsonPrinterTest >> testWithOnlyOneEntity [
	| entity  printer tower  |
	entity := FAMIXComment new content:  'Zorro"'.
	mooseModel add: entity.

	printer := FMJsonPrinter new onString.
	tower := FMCompleteTower new.
	tower metaMetamodel: MooseModel meta metamodel.
	tower metamodel: MooseModel meta.
	tower model: ((FMRepository with: MooseModel meta) addAll: mooseModel entities).
	tower model accept: printer.
 	self assert: (printer stream contents = '
[
	{
		"name":"FAMIX.Comment" ,"id":1,
		"content":"Zorro\""
	}
]' ).
	
]

{ #category : #'not-real-tests' }
FMJsonPrinterTest >> testWrite [
"	| printer |
	printer := FMJsonPrinter new onString.
	FMMetaRepository fm3 accept: printer.
	Transcript show: printer stream contents"
]

{ #category : #'not-real-tests' }
FMJsonPrinterTest >> testWriteEntities [
	| printer tower moosemodel stream |
	stream := (FileSystem disk workingDirectory / 'oneEntityJson.txt') writeStream.
	printer := FMJsonPrinter new stream: stream.
	moosemodel :=( (MooseModel root at: 4) entities at:1).
	tower := FMCompleteTower new.
	tower metaMetamodel: MooseModel meta metamodel.
	tower metamodel: MooseModel meta.
	tower model: ((FMRepository with: MooseModel meta) add: moosemodel ).
	tower model accept: printer.
	stream close
]

{ #category : #'not-real-tests' }
FMJsonPrinterTest >> testWriteSimple [
	| printer tower moosemodel stream |
	stream := (FileSystem disk workingDirectory / 'AModelJson.txt') writeStream.
	printer := FMJsonPrinter new stream: stream.
	moosemodel := MooseModel root at: 4.
	tower := FMCompleteTower new.
	tower metaMetamodel: MooseModel meta metamodel.
	tower metamodel: MooseModel meta.
	tower model: ((FMRepository with: MooseModel meta) addAll: moosemodel entities).
	tower model accept: printer.
	stream close
]
