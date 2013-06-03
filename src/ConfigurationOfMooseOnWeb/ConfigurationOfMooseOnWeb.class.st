Class {
	#name : #ConfigurationOfMooseOnWeb,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfMooseOnWeb
}

{ #category : #private }
ConfigurationOfMooseOnWeb class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfMooseOnWeb class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfMooseOnWeb class >> loadDefault [
	self loadDevelopment
]

{ #category : #loading }
ConfigurationOfMooseOnWeb class >> loadDevelopment [
	(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfMooseOnWeb class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> baseline01: spec [
	<version: '0.1-baseline'>
	"For install with seaside packages but missing WAAdmin"
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'First shoot for MooseOnWeb !'.
			spec repository: 'http://www.smalltalkhub.com/mc/VincentBlondeau/MooseOnWeb/main'.	
			spec
				project: 'ZincHTTPComponents'
				with: [ 
					spec
						className: 'ConfigurationOfZincHTTPComponents';
						versionString: #stable;
						loads: #('REST');
						repository: 'http://www.squeaksource.com/ZincHTTPComponents' ].
	      	spec
				project: 'SeasideRest'
				with: [ 
					spec
						className: 'ConfigurationOfSeasideRest';
						versionString: #bleedingEdge;
						repository: 'http://www.squeaksource.com/Seaside30Addons' ].
			spec
				package: 'Fame-Json-ImportExport';
				"package: 'MooseOnWeb-JsonMagritteExample';"
				package: 'MooseOnWeb-REST-Api-Tests' with: [ spec requires: #('MooseOnWeb-REST-Api') ];
				package: 'MooseOnWeb-REST-Api' with: [ spec requires: #('ZincHTTPComponents' 'SeasideRest') ].

			spec group: 'default' with: #("'MooseOnWeb-JsonMagritteExample'" 'Fame-Json-ImportExport' 'MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api').

			]
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> baseline02: spec [
	<version: '0.2-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'First shoot for MooseOnWeb on the Zinc REST API !'.
			spec repository: 'http://www.smalltalkhub.com/mc/VincentBlondeau/MooseOnWeb/main'.	
			spec
				project: 'ZincHTTPComponents'
				with: [ 
					spec
						className: 'ConfigurationOfZincHTTPComponents';
						versionString: #stable;
						loads: #('REST');
						repository: 'http://www.squeaksource.com/ZincHTTPComponents' ].
			spec
				package: 'Fame-Json-ImportExport';
				package: 'MooseOnWeb-REST-Api-Tests' with: [ spec requires: #('MooseOnWeb-REST-Api') ];
				package: 'MooseOnWeb-REST-Api' with: [ spec requires: #('ZincHTTPComponents' 'SeasideRest') ].

			spec group: 'default' with: #('Fame-Json-ImportExport' 'MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api').

			]
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> default: spec [ 	
	 ^ self development: spec
]

{ #category : #'symbolic versions' }
ConfigurationOfMooseOnWeb >> development: spec [
	<symbolicVersion: #'development'>

	"spec for: #'pharo1.4.x' version: '1.2'."
	spec for: #'pharo2.x' version: '0.2-baseline'.

]

{ #category : #accessing }
ConfigurationOfMooseOnWeb >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
