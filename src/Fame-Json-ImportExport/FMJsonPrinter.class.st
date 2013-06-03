Class {
	#name : #FMJsonPrinter,
	#superclass : #FMPrintClient,
	#instVars : [
		'isFirstElement',
		'isReferenceAttribute',
		'isFirstReferenceAttribute'
	],
	#category : #'Fame-Json-ImportExport'
}

{ #category : #'instance creation' }
FMJsonPrinter class >> new [
	"Answer a newly created and initialized instance."

	^super new initialize
]

{ #category : #parsing }
FMJsonPrinter >> beginAttribute: name [
	isFirstReferenceAttribute := true.
	stream nextPut: $,.
	self crTabs.
	stream 
		nextPutAll: '"';
		nextPutAll: name;
		nextPutAll: '":'
]

{ #category : #parsing }
FMJsonPrinter >> beginDocument [
	stream nextPut: $[.
]

{ #category : #parsing }
FMJsonPrinter >> beginElement: name [
	indent := indent + 1.
	isFirstElement
		ifFalse: [ stream nextPut: $, ].
	self crTabs.
	isFirstElement := false.
	stream nextPut: ${.
	indent := indent + 1.
	self crTabs.
	stream
		nextPutAll: '"name":"';
		nextPutAll: name;
		nextPutAll: '"'
]

{ #category : #parsing }
FMJsonPrinter >> endAttribute: name [

	isReferenceAttribute ifTrue: [ stream nextPut: $] ].
	isReferenceAttribute := false. 

]

{ #category : #parsing }
FMJsonPrinter >> endDocument [
	self crTabs.
	stream nextPut: $].
]

{ #category : #parsing }
FMJsonPrinter >> endElement: name [
	indent := indent - 1.
	self crTabs.
	stream nextPutAll: '}'.

	indent := indent - 1
]

{ #category : #'initialize-release' }
FMJsonPrinter >> initialize [
	stream := nil.
	indent := nil.
	isFirstElement  := true.
	isReferenceAttribute :=false.
	isFirstReferenceAttribute :=false.
	^self
]

{ #category : #parsing }
FMJsonPrinter >> primitive: value [
	indent := indent + 1.
	(value isKindOf: Boolean)
		ifTrue: [ stream print: value ]
		ifFalse: [ 
			(value isKindOf: String)
				ifTrue: [ 
					stream nextPutAll: '"'.
					value
						do: [ :char | 
							Character cr == char
								ifTrue: [ stream nextPutAll: '\n' ]
								ifFalse: [ 
									Character tab == char
										ifTrue: [ stream nextPutAll: '\t' ]
										ifFalse: [ 
											$" == char
												ifTrue: [ stream nextPut: $\ ].
											stream nextPut: char ] ] ].
					stream nextPut: $" ]
				ifFalse: [ 
					(value isKindOf: Number)
						ifTrue: [ stream print: value ]
						ifFalse: [ Error signal ] ] ].
	indent := indent - 1
]

{ #category : #parsing }
FMJsonPrinter >> referenceName: name [
	isReferenceAttribute := true.
	isFirstReferenceAttribute ifTrue:[ stream nextPut: $[ ] ifFalse: [ stream nextPut: $, ]. 
	isFirstReferenceAttribute := false.
	stream nextPut: $".
	stream print: name.
	stream nextPut: $".
]

{ #category : #parsing }
FMJsonPrinter >> referenceNumber: index [

	isReferenceAttribute := true.
	isFirstReferenceAttribute ifTrue:[ stream nextPut: $[ ] ifFalse: [ stream nextPut: $, ]. 
	isFirstReferenceAttribute := false.
	stream print: index.

]

{ #category : #parsing }
FMJsonPrinter >> serial: index [
	
	stream 
		space;
		nextPutAll: ',"id":';
		print: index
]
