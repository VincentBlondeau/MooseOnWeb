Class {
	#name : #FMJsonPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'mooseModel'
	],
	#category : #'Fame-Json-ImportExport-Tests'
}

{ #category : #tests }
FMJsonPrinterTest >> setUp [
	mooseModel := MooseModel new
]

{ #category : #tests }
FMJsonPrinterTest >> testExportAsJsonOn [
 	|stream|
	stream:=  WriteStream with: '' .
	FMMetaRepository fm3 exportAsJsonOn: stream .
	stream contents isString should beTrue.
	stream contents first should = $[
]

{ #category : #tests }
FMJsonPrinterTest >> testExportToJsonStream [
 	|stream|
	stream:=  WriteStream with: '' .
	mooseModel exportToJsonStream: stream.
	stream contents isString should beTrue.
	self assert: (stream contents =  '[
]' ) 
]

{ #category : #tests }
FMJsonPrinterTest >> testExportToJsonStream2 [
	| stream |
	mooseModel add:  (FAMIXComment new content:  'This is a test"
	').
	stream := WriteStream with: ''.
	mooseModel exportToJsonStream: stream.
	stream contents isString should beTrue.
	self
		assert:
			stream contents
				=
					 '[
	{
		"name":"FAMIX.Comment" ,"id":1,
		"content":"This is a test\"\n\t"
	}
]'
]

{ #category : #tests }
FMJsonPrinterTest >> testWithOnlyOneEntity [
	| entity  printer tower  |
	entity := FAMIXComment new content:  'This is a test"
	'.
	mooseModel add: entity.

	printer := FMJsonPrinter new onString.
	tower := FMCompleteTower new.
	tower metaMetamodel: MooseModel meta metamodel.
	tower metamodel: MooseModel meta.
	tower model: ((FMRepository with: MooseModel meta) addAll: mooseModel entities).
	tower model accept: printer.
 	self assert: (printer stream contents = '[
	{
		"name":"FAMIX.Comment" ,"id":1,
		"content":"This is a test\"\n\t"
	}
]')
]

{ #category : #tests }
FMJsonPrinterTest >> testWrite [
	| stream |
	stream := WriteStream on:''.
	FMMetaRepository fm3 exportAsJsonOn: stream.
	stream contents isString should beTrue.
	stream contents first should = $[
]
