Extension { #name : #MooseEntity }

{ #category : #'*MooseOnWeb-REST-Api-Json-Extensions' }
MooseEntity >> descriptionMooseID [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #mooseID;
		label: 'mooseID';
		yourself
]

{ #category : #'*MooseOnWeb-REST-Api-Json-Extensions' }
MooseEntity >> descriptionMooseName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #mooseName;
		label: 'mooseName';
		yourself
]
