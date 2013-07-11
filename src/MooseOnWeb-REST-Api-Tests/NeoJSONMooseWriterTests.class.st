Class {
	#name : #NeoJSONMooseWriterTests,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'MooseOnWeb-REST-Api-Tests'
}

{ #category : #'as yet unclassified' }
NeoJSONMooseWriterTests >> setUp [
	model := MooseModel new
]

{ #category : #'as yet unclassified' }
NeoJSONMooseWriterTests >> testWriteMooseEntity [
	| entity stream |
	entity := FAMIXComment new
		content:
			'This is a test"
	'.
	stream := WriteStream with: ''.
		(NeoJSONMooseWriter on: stream)
				prettyPrint: true;
				newLine: String crlf;
				nextPut: entity.
	self assert: stream contents  equals: 
'{',String crlf,
'	"id" : ',entity mooseID asString,',',String crlf,
'	"name" : "\"This is a ...\" in ",',String crlf,
'	"type" : "FAMIXComment",',String crlf,
'	"content" : "This is a test\"\r\t"',String crlf,
'}'
]

{ #category : #'as yet unclassified' }
NeoJSONMooseWriterTests >> testWriteMooseModel [
	| entity stream |
	entity := FAMIXComment new
		content:
			'This is a test"
	'.
	model add: entity.
	stream := WriteStream with: ''.
		(NeoJSONMooseWriter on: stream)
				prettyPrint: true;
				newLine: String crlf;
				nextPut: model.
	self assert: stream contents  equals: '{',String crlf,
'	"id" : ',model mooseID asString,',',String crlf,
'	"name" : "noname",',String crlf,
'	"type" : "MooseModel",',String crlf,
'	"entities" : [',String crlf,
'		{',String crlf,
'			"id" : ',entity mooseID asString,',',String crlf,
'			"name" : "\"This is a ...\" in ",',String crlf,
'			"type" : "FAMIXComment"',String crlf,
'		}',String crlf,
'	]',String crlf,
'}'	
]
