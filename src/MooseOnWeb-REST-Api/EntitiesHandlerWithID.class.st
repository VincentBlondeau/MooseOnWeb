"
An EntitiesHandlerWithID is a catcher for the GET entities/ID request. 

Instance Variables
	entity:		<MooseEntity>

entity
	- MooseEntity associated to the Id in the request

"
Class {
	#name : #EntitiesHandlerWithID,
	#superclass : #MooseOnWebRestCall,
	#instVars : [
		'entity'
	],
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #accessing }
EntitiesHandlerWithID class >> pattern [
	^#( 'mooseOnWeb' 'entities' '*' )
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> action [
<mooseonweb:'GET' name:'/entities/<mooseID>?action=<nom action>[&<nom param>=<valeur>]*' description:'Permet d''effectuer une action avec plusieurs parametres (seul les actions sans parametres sont implementees)' >

	| action |
	action:= request uri queryAt: 'action'.
	[answer:=entity perform: action asSymbol ] on: MessageNotUnderstood do: [ RessourceNotFound  signal ] .

]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> entity [
	^entity
	
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> entity: anEntity [
	anEntity ifNil: [ RessourceNotFound signal ] ifNotNil: [ entity := anEntity ]
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> get [
	<mooseonweb:'GET' name:'/entities/<mooseID>' description:'Affiche les informations sur l''entitie ayant pour ID <mooseID>' >
	| predicateKeys |
[	[ 
	self entity: (MooseEntity objectWithID: variables first asInteger).
	predicateKeys := request uri queryKeys.
	predicateKeys isEmpty
		ifTrue: [ answer := entity ]
		ifFalse: [ 
			(predicateKeys includes: 'q')
				ifTrue: [ self query ]
				ifFalse: [ 
					(predicateKeys includes: 'action')
						ifTrue: [ self action ]
						ifFalse: [ InvalidSymbol signal ] ] ].
	self sendJson ]
		on: RessourceNotFound
			do: [ :ex | self notFound ]]
		on: InvalidSymbol
			do: [ :ex | self badRequest: 'Erreur dans la requete' ]
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> listActions: anEntity [
	^ anEntity allPropertySelectors values
		select: [ :aSelector | 
			| r |
			r := anEntity perform: aSelector.
			r isMooseGroup
				ifTrue: [ r isEmpty not ]
				ifFalse: [ r isNil not ] ]
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> query [
<mooseonweb:'GET' name:'/entities/<mooseID>?q=actions' description:'Liste des operations permettant d''obtenir des proprietes sur l''entite d''Id <mooseID>' >
	"/entities/<mooseID>?q=actions : liste des opérations de lecture applicable sur l'entité : allPropertySelectors"

	| q |
	q := request uri queryAt: 'q'.
	(q equalsTo: 'actions')
		ifTrue: [ 
			answer := (self listActions: entity) sort ]
		ifFalse: [ 
			(q equalsTo: 'search')
				ifTrue: [ self search ]
				ifFalse: [ InvalidSymbol signal ] ]
]

{ #category : #'as yet unclassified' }
EntitiesHandlerWithID >> search [
	<mooseonweb:'GET' name:'/entities/<mooseID>?q=search&<message>=<valeur>' description:'Permet de chercher les entites du groupe <mooseID> verifiant la condition :  <message> = <valeur>' >


	| keys message value |
	keys := request uri query keys asArray.
	keys size = 2
		ifFalse: [ InvalidSymbol signal ].
	message := keys at: 2.
	value := request uri queryAt: message.
	entity isMooseGroup
		ifTrue: [ answer := entity select: [ :e | (e perform: message asSymbol) = value ] ]
		ifFalse: [ NotYetImplemented signalFor: 'Requests on moose entities' ]
]
