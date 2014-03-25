Extension { #name : #FDModel }

{ #category : #'*MooseOnWeb-REST-Api-Core' }
FDModel >> executiveBrowser [
	<navigation: 'Get the Executive Visualisation as SVG'>
	| builder stream |
	builder := RTMondrianViewBuilder new.
	FDExecutive new
		model: self;
		renderSystemComplexityOn: builder.
	builder applyLayout.
	stream := ReadWriteStream on: ''.
	RTSVGExporter new
		view: builder view;
		exportOnStream: stream.
	^ stream contents
]
