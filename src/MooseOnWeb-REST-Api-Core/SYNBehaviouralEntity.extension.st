Extension { #name : #SYNBehaviouralEntity }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
SYNBehaviouralEntity >> displayTextIntervalProperties [
	<navigation: 'Get text interval properties to apply colors on code'>
	^ ((self displayProperties
		reject: [ :aProperty | aProperty textIntervalSelector isNil ])
		collect: [ :aProperty | 
			aProperty label asLegalSelector ->
			(aProperty getIntervalsForEntity: self)]) asDictionary 
]
