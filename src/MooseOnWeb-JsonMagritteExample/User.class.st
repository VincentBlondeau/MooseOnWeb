Class {
	#name : #User,
	#superclass : #Object,
	#instVars : [
		'username',
		'name',
		'password',
		'email'
	],
	#category : #'MooseOnWeb-JsonMagritteExample'
}

{ #category : #converting }
User >> asJsonString [
	^ Json render: self jsonData
]

{ #category : #descriptions }
User >> descriptionEmail [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #email;
		beJsonWriteable;
		label: 'Email';
		yourself
]

{ #category : #accessing }
User >> descriptionJsonRead [
	"By default, magritte descriptions are JSON read-only.
	That means input won't be read unless the description is explicitely writeable.
	See MADescription >> beJsonWriteable"
	
	^self magritteDescription copy
		select: [:each | 
			(each propertyAt: #json ifAbsent: [true]) and: [
				each isJsonReadonly not]]
]

{ #category : #accessing }
User >> descriptionJsonWrite [
	"Magritte descriptions are visible in the JSON output by default.
	Use MADescription >> #jsonHide to exclude a description from
	the generated JSON"
	
	^self magritteDescription copy
		select: [:each | 
			(each propertyAt: #json ifAbsent: [true]) and: [each isJsonVisible]]
]

{ #category : #descriptions }
User >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		beRequired;
		label: 'Name';
		yourself
]

{ #category : #descriptions }
User >> descriptionPassword [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #password;
		beRequired;
		beJsonWriteable;
		jsonHide;
		label: 'Password';
		yourself
]

{ #category : #accessing }
User >> email [
	^ email
]

{ #category : #accessing }
User >> email: anObject [
	email := anObject
]

{ #category : #accessing }
User >> jsonData [
	^ JsonWriter new
		object: self;
		visit: self descriptionJsonWrite;
		json
]

{ #category : #accessing }
User >> jsonReadFrom: json [
	self jsonReadFrom: json using: self descriptionJsonRead
]

{ #category : #accessing }
User >> jsonReadFrom: json using: aDescription [
	JsonReader new
		json: json;
		object: self;
		visit: aDescription
]

{ #category : #accessing }
User >> name [
	^ name

]

{ #category : #accessing }
User >> name: anObject [
	name := anObject
]

{ #category : #accessing }
User >> password [
	^ password
]

{ #category : #accessing }
User >> password: anObject [
	password := anObject
]
