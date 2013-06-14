"
A HelpHandler is a catcher for the GET help request.

Instance Variables

"
Class {
	#name : #HelpHandler,
	#superclass : #MooseOnWebRestCall,
	#category : #'MooseOnWeb-REST-Api'
}

{ #category : #'as yet unclassified' }
HelpHandler class >> pattern [
	^ #('mooseOnWeb' 'help')
]

{ #category : #'as yet unclassified' }
HelpHandler >> get [ 
	<mooseonweb:'GET' name:'/help' description:'Aide du service' >
	answer  := Dictionary new
		at: #'/models' put:   'retourne la liste des models disponibles dans l''image';
		at: #'/entities/<mooseID>?q=actions' put: 'Liste des operations permettant d''obtenir des proprietes sur l''entite d''Id <mooseID>';
		at: #'/entities/<mooseID>' put:'Affiche les informations sur l''entitie ayant pour ID <mooseID>';
		at:#'/entities/<mooseID>?action=<nom action>[&<nom param>=<valeur>]*' put: 'Permet d''effectuer une action avec plusieurs parametres (seul les actions sans parametres sont implementees)';
		at: #'/entities/<mooseID>?q=search&<message>=<valeur>' put: 'Permet de chercher les entites du groupe <mooseID> verifiant la condition :  <message> = <valeur>';
		at: #'/help' put: 'Liste des services disponibles';yourself.
	self sendJson.


]
