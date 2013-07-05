Class {
	#name : #MooseOnWebServerCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
MooseOnWebServerCommandLineHandler class >> commandName [
	^ 'LaunchServer'
]

{ #category : #accessing }
MooseOnWebServerCommandLineHandler class >> description [
	^ 'A launcher for the MooseOnWebServer. Port can be specified by --port=8080'
]

{ #category : #activation }
MooseOnWebServerCommandLineHandler >> activate [
	| port |
	port := self optionAt: 'port' ifAbsent: '8080'.
	self createModel.
	self stderr nextPutAll: 'Models Loaded', String crlf.
	MooseOnWebRestServerDelegate serverStartOn: port  asInteger.
	self stderr nextPutAll: 'Server running on ' , port.
]

{ #category : #activation }
MooseOnWebServerCommandLineHandler >> createModel [
	(self createModelFrom:  [ :p | p name includesSubstring: 'Collections-']  withName: 'Collections') install.
]

{ #category : #activation }
MooseOnWebServerCommandLineHandler >> createModelFrom: aBlockMatching withName: name [
	| importer |
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer candidateClass: CandidateListOperator;
		importerClass: SmalltalkImporter.
	importer model: (MooseModel new name: name); 
		addFromPackagesMatching: aBlockMatching;
		run. 
	 ^importer model.


]
