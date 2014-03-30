Class {
	#name : #MWNeoJSONStreamingWriterExtended,
	#superclass : #MWNeoJSONStreamingWriter,
	#category : #'MooseOnWeb-MooseJSONWriter-Core'
}

{ #category : #writing }
MWNeoJSONStreamingWriterExtended >> writeHeaderClonedFragment: mooseEntity [
	self writeKey: 'id' value: mooseEntity mooseID.
	self writeKey: 'name' value: mooseEntity formattedName.
	self writeKey: 'type' value: mooseEntity class name.
]

{ #category : #writing }
MWNeoJSONStreamingWriterExtended >> writeHeaderDisplayProperty: aProperty [
	self writeKey: 'label' value: aProperty label.
	self writeKey: 'textIntervalSelector' value: aProperty textIntervalSelector.
	self writeKey: 'color' value: aProperty color printHtmlString.
]

{ #category : #writing }
MWNeoJSONStreamingWriterExtended >> writeHeaderFamixChange: aFamixChange [
	self writeKey: 'name' value: (aFamixChange name).
	self writeKey: 'color' value: (aFamixChange color asHTMLColor).
	self writeKey: 'entityID' value: (aFamixChange entity mooseID)
]

{ #category : #writing }
MWNeoJSONStreamingWriterExtended >> writeHeaderMooseEntity: mooseEntity [
	super writeHeaderMooseEntity: mooseEntity.
	self writeKey: 'numberOfViolatedRules' value: (mooseEntity mooseModel violatedRulesFor: mooseEntity) size
]

{ #category : #writing }
MWNeoJSONStreamingWriterExtended >> writeHeaderQueryConcern: queryConcern [
	self writeKey: 'label' value: queryConcern label.
	self writeKey: 'description' value: queryConcern explanation.
]
