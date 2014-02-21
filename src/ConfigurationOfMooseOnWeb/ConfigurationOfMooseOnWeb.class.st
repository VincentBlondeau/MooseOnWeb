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
				package: 'MooseOnWeb-REST-Api' with: [ spec requires: #('ZincHTTPComponents') ].

			spec group: 'default' with: #('Fame-Json-ImportExport' 'MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api').

			]
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> baseline03: spec [
	<version: '0.3-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'MooseOnWeb on the Zinc REST API !'.
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
				project: 'BabyMock'
				with: [ 
					spec
						className: 'ConfigurationOfBabyMock';
						versionString: '1.0';
						repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock/main' ].
			spec
				package: 'MooseOnWeb-REST-Api-Tests' with: [ spec requires: #('MooseOnWeb-REST-Api' 'BabyMock') ];
				package: 'MooseOnWeb-REST-Api' with: [ spec requires: #('ZincHTTPComponents') ].

			spec group: 'default' with: #( 'MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api').

			]
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> baseline11: spec [
	<version: '1.1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'MooseOnWeb on the Zinc REST API !'.
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
				project: 'BabyMock'
				with: [ 
					spec
						className: 'ConfigurationOfBabyMock';
						versionString: '1.0';
						repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock/main' ].
			spec
				package: 'MooseOnWeb-MooseJSONWriter-Tests'
					with: [ spec requires: #('ZincHTTPComponents' 'MooseOnWeb-MooseJSONWriter') ];
				package: 'MooseOnWeb-MooseJSONWriter' with: [ spec requires: #('ZincHTTPComponents') ];
				package: 'MooseOnWeb-REST-Api-Tests'
					with: [ spec requires: #('MooseOnWeb-REST-Api' 'BabyMock' 'MooseOnWeb-MooseJSONWriter') ];
				package: 'MooseOnWeb-REST-Api' 
					with: [ spec requires: #('ZincHTTPComponents' 'MooseOnWeb-MooseJSONWriter') ].
			spec group: 'default' 
				with: #('MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api'  'MooseOnWeb-MooseJSONWriter' 'MooseOnWeb-MooseJSONWriter-Tests') ]
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> baseline12: spec [
	<version: '1.2-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'MooseOnWeb on the Zinc REST API !'.
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
				project: 'BabyMock'
				with: [ 
					spec
						className: 'ConfigurationOfBabyMock';
						versionString: '1.0';
						repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock/main' ].
			spec
				package: 'MooseOnWeb-MooseJSONWriter-Tests'
					with: [ spec requires: #('ZincHTTPComponents' 'MooseOnWeb-MooseJSONWriter-Core') ];
				package: 'MooseOnWeb-MooseJSONWriter-Core' with: [ spec requires: #('ZincHTTPComponents') ];
				package: 'MooseOnWeb-REST-Api-Tests'
					with: [ spec requires: #('MooseOnWeb-REST-Api-Core' 'BabyMock' 'MooseOnWeb-MooseJSONWriter-Core') ];
				package: 'MooseOnWeb-REST-Api-Core' 
					with: [ spec requires: #('ZincHTTPComponents' 'MooseOnWeb-MooseJSONWriter-Core') ].
			spec group: 'default' 
				with: #('MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api-Core'  'MooseOnWeb-MooseJSONWriter-Core' 'MooseOnWeb-MooseJSONWriter-Tests') ]
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> baseline13: spec [
	<version: '1.3-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec description: 'MooseOnWeb on the Zinc REST API !'.
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
				project: 'BabyMock'
				with: [ 
					spec
						className: 'ConfigurationOfBabyMock';
						versionString: '1.0';
						repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock/main' ].
			spec
				package: 'MooseOnWeb-REST-Api-Exceptions';
				package: 'MooseOnWeb-MooseJSONWriter-Tests'
					with: [ 
						spec requires: #( 'MooseOnWeb-MooseJSONWriter-Core' ) 
					];
				package: 'MooseOnWeb-MooseJSONWriter-Core' 
					with: [ 
						spec requires: #('ZincHTTPComponents') 
					];
				package: 'MooseOnWeb-REST-Api-Tests'
					with: [ 
						spec requires: #('MooseOnWeb-REST-Api-Core' 'BabyMock') 
					];
				package: 'MooseOnWeb-REST-Api-Core' 
					with: [ 
						spec requires: #('ZincHTTPComponents' 'MooseOnWeb-MooseJSONWriter-Core' 'MooseOnWeb-REST-Api-Exceptions' 'MooseOnWeb-REST-Api-Grammar-Core') 
					];
				package: 'MooseOnWeb-REST-Api-Grammar-Core' with: [ 
						spec requires: #('MooseOnWeb-REST-Api-Grammar-AST') 
					];
				package: 'MooseOnWeb-REST-Api-Grammar-AST' with: [ 
						spec requires: #('MooseOnWeb-REST-Api-Grammar-Visitor') 
					];
				package: 'MooseOnWeb-REST-Api-Grammar-Visitor' with: [ 
						spec requires: #( 'MooseOnWeb-REST-Api-Exceptions') 
					];
				package: 'MooseOnWeb-REST-Api-Grammar-Tests' with: [ 
						spec requires: #('MooseOnWeb-REST-Api-Grammar-Core') 
					].
				
			spec group: 'default' 
				with: #('MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api-Core'  'MooseOnWeb-MooseJSONWriter-Core' 
					'MooseOnWeb-MooseJSONWriter-Tests' 'MooseOnWeb-REST-Api-Exceptions' 'MooseOnWeb-REST-Api-Grammar-Tests') ]
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> default: spec [ 	
	 ^ self development: spec
]

{ #category : #'symbolic versions' }
ConfigurationOfMooseOnWeb >> development: spec [
	<symbolicVersion: #'development'>

	"spec for: #'pharo1.4.x' version: '1.2'."
	spec for: #'pharo2.x' version: '1.3-baseline'.
	spec for: #'pharo3.x' version: '1.3-baseline'.

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

{ #category : #'symbolic versions' }
ConfigurationOfMooseOnWeb >> version10: spec [
	<version: '1.0' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: ''.
		spec author: 'Vincent Blondeau'.
		spec timestamp: '7/10/2013 15:00'.
		spec 
			project: 'ZincHTTPComponents' with: '2.4.3';
			project: 'BabyMock' with: '1.0'.
		spec 
			package: 'MooseOnWeb-REST-Api' with: 'MooseOnWeb-REST-Api-VincentBlondeau.28';
			package: 'MooseOnWeb-REST-Api-Tests' with: 'MooseOnWeb-REST-Api-Tests-VincentBlondeau.14'.
	]
]
