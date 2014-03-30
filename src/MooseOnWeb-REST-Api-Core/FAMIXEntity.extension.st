Extension { #name : #FAMIXEntity }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
FAMIXEntity >> violatedRules [
	<navigation: 'Get all the rules violated by this entity'>
	^ self mooseModel violatedRulesFor: self.
]
