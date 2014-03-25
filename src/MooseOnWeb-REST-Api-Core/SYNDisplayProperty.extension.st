Extension { #name : #SYNDisplayProperty }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
SYNDisplayProperty >> getIntervalsForEntity: anEntity [
	^ (anEntity perform: self textIntervalSelector) collect: [ :anInterval | Array with: anInterval first with: anInterval last ]
]
