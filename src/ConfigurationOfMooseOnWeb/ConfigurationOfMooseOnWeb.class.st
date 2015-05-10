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
ConfigurationOfMooseOnWeb class >> load [
	self loadDevelopment
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
			spec repository: 'http://www.smalltalkhub.com/mc/VincentBlondeau/MooseOnWeb/main'.
			spec
				project: 'ZincHTTPComponents'
					with: [ 
							spec
								className: #ConfigurationOfZincHTTPComponents;
								versionString: #stable;
								loads: #('REST');
								repository: 'http://smalltalkhub.com/mc/SvenVanCaekenberghe/ZincHTTPComponents/main/' ];
				project: 'BabyMock'
					with: [ 
							spec
								className: #ConfigurationOfBabyMock;
								versionString: '1.0';
								repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock/main' ].
			spec
				package: 'MooseOnWeb-REST-Api-Exceptions';
				package: 'MooseOnWeb-MooseJSONWriter-Core' with: [ spec requires: #('ZincHTTPComponents') ];
				package: 'MooseOnWeb-MooseJSONWriter-Tests' with: [ spec requires: #('MooseOnWeb-MooseJSONWriter-Core') ];
				package: 'MooseOnWeb-REST-Api-Grammar-Visitor' with: [ spec requires: #('MooseOnWeb-REST-Api-Exceptions') ];
				package: 'MooseOnWeb-REST-Api-Grammar-AST' with: [ spec requires: #('MooseOnWeb-REST-Api-Grammar-Visitor') ];
				package: 'MooseOnWeb-REST-Api-Grammar-Core' with: [ spec requires: #('MooseOnWeb-REST-Api-Grammar-AST') ];
				package: 'MooseOnWeb-REST-Api-Core'
					with: [ 
							spec
								requires:
									#('ZincHTTPComponents' 'MooseOnWeb-MooseJSONWriter-Core' 'MooseOnWeb-REST-Api-Exceptions' 'MooseOnWeb-REST-Api-Grammar-Core') ];
				package: 'MooseOnWeb-REST-Api-Tests' with: [ spec requires: #('MooseOnWeb-REST-Api-Core' 'BabyMock') ];
				package: 'MooseOnWeb-REST-Api-Grammar-Tests' with: [ spec requires: #('MooseOnWeb-REST-Api-Grammar-Core') ].
			spec
				group: 'default'
				with:
					#('MooseOnWeb-REST-Api-Tests' 'MooseOnWeb-REST-Api-Core' 'MooseOnWeb-MooseJSONWriter-Core' 'MooseOnWeb-MooseJSONWriter-Tests' 'MooseOnWeb-REST-Api-Exceptions' 'MooseOnWeb-REST-Api-Grammar-Tests' 'MooseOnWeb-REST-Api-Grammar-Visitor' 'MooseOnWeb-REST-Api-Grammar-AST' 'MooseOnWeb-REST-Api-Grammar-Core') ]
]

{ #category : #catalog }
ConfigurationOfMooseOnWeb >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ '- 1.0 - 10 May 2015 - First stable version
[[[
	(ConfigurationOfMooseOnWeb project version: ''1.0'' ) load					
]]].'
]

{ #category : #catalog }
ConfigurationOfMooseOnWeb >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'You can get in contact with the developper at vincent.blondeau@polytech-lille.net'
]

{ #category : #catalog }
ConfigurationOfMooseOnWeb >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'Moose On Web is an Api providing access a the models included in a Moose image.

To easily get the Api :

[[[ 
Gofer new
    smalltalkhubUser: '''' project: ''VincentBlondeau/MooseOnWeb'';
    package: ''ConfigurationOfMooseOnWeb'';
    load.
 ]]]
and then:
[[[
 ConfigurationOfMooseOnWeb loadDefault
]]]
You can also use the image built by Jenkins : https://ci.inria.fr/moose/job/Moose-On-The-Web/

To try the Api, the server have to be launched :
[[[
MWRestServerDelegate serverStartOn: 8080
]]]
This command run the Api server. You can go on you favorite web broswer on : http://localhost:8080/mooseOnWeb/help to have the list of the commands.

You can use the Rest Client of firefox to forge your requests to the Api.

If you want to download the image with Moose on Web from Jenkins : https://ci.inria.fr/moose/job/Moose-On-The-Web/

If you just want to try it, you can go to http://37.139.2.203(not available for now) where a amber client interract with the pharo image through the API. You can download the client on https://github.com/VincentBlondeau/amber-MooseOnWeb'
]

{ #category : #catalog }
ConfigurationOfMooseOnWeb >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ ''
]

{ #category : #catalog }
ConfigurationOfMooseOnWeb >> catalogKeywords [
	"Returns an array of symbols"
	^ #(moose rest web models explore json metamodel) 
]

{ #category : #baselines }
ConfigurationOfMooseOnWeb >> default: spec [ 	
	 ^ self development: spec
]

{ #category : #'symbolic versions' }
ConfigurationOfMooseOnWeb >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.3-baseline'.

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
ConfigurationOfMooseOnWeb >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0'.

]

{ #category : #versions }
ConfigurationOfMooseOnWeb >> version10: spec [
	<version: '1.0' imports: #('1.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '5/10/2015 15:25'.
		spec 
			project: 'ZincHTTPComponents' with: '2.6.3';
			project: 'BabyMock' with: '1.0'.
		spec 
			package: 'MooseOnWeb-REST-Api-Exceptions' with: 'MooseOnWeb-REST-Api-Exceptions';
			package: 'MooseOnWeb-MooseJSONWriter-Core' with: 'MooseOnWeb-MooseJSONWriter-Core';
			package: 'MooseOnWeb-MooseJSONWriter-Tests' with: 'MooseOnWeb-MooseJSONWriter-Tests';
			package: 'MooseOnWeb-REST-Api-Grammar-Visitor' with: 'MooseOnWeb-REST-Api-Grammar-Visitor';
			package: 'MooseOnWeb-REST-Api-Grammar-AST' with: 'MooseOnWeb-REST-Api-Grammar-AST';
			package: 'MooseOnWeb-REST-Api-Grammar-Core' with: 'MooseOnWeb-REST-Api-Grammar-Core';
			package: 'MooseOnWeb-REST-Api-Core' with: 'MooseOnWeb-REST-Api-Core';
			package: 'MooseOnWeb-REST-Api-Tests' with: 'MooseOnWeb-REST-Api-Tests';
			package: 'MooseOnWeb-REST-Api-Grammar-Tests' with: 'MooseOnWeb-REST-Api-Grammar-Tests'. ].

]
