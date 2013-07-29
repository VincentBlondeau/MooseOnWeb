Class {
	#name : #MWServerCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'MooseOnWeb-REST-Api-Core'
}

{ #category : #accessing }
MWServerCommandLineHandler class >> commandName [
	^ 'LaunchServer'
]

{ #category : #accessing }
MWServerCommandLineHandler class >> description [
	^ 'A launcher for the MooseOnWebServer. Port can be specified by --port=8080'
]

{ #category : #activation }
MWServerCommandLineHandler >> activate [
	| port |
	port := self optionAt: 'port' ifAbsent: '8080'.
	self createModel.
	self stderr
		nextPutAll: 'Models Loaded';
		nextPutAll: String crlf.
	MWRestServerDelegate serverStartOn: port asInteger.
	self stderr
		nextPutAll: 'Server running on ';
		nextPutAll: port

]

{ #category : #accessing }
MWServerCommandLineHandler >> createModel [
	(self createModelFrom:  [ :p | p name includesSubstring: 'Collections-']  withName: 'Collections') install.
]

{ #category : #accessing }
MWServerCommandLineHandler >> createModelFrom: aBlockMatching withName: name [
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
