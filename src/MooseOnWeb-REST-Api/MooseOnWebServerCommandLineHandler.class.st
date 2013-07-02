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
 	MooseModel root add: ( self createModelFrom: #('Moose-Core')).
]

{ #category : #activation }
MooseOnWebServerCommandLineHandler >> createModelFrom: packages [
	| importer |
	importer := MoosePharoImporterTask new.
	importer importingContext mergeClassAndMetaclass.
	importer candidateClass: CandidateListOperator;
		importerClass: SmalltalkImporter.
	importer model: MooseModel new; 
		addFromPackagesNamed: packages;
		run. 
	 ^importer model.


]
