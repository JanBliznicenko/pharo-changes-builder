"
I represent a in-memory method that knows how to convert itself to RBChange to generate actual code.

I also provide couple more convenient methods for code definition.
"
Class {
	#name : 'CBMethod',
	#superclass : 'Object',
	#instVars : [
		'source',
		'protocolName'
	],
	#category : 'ChangesBuilder-Model',
	#package : 'ChangesBuilder',
	#tag : 'Model'
}

{ #category : 'utility' }
CBMethod >> asArgumentName: aString [
	^ (aString first isVowel
		ifTrue: [ 'an' ]
		ifFalse: [ 'a' ]) , aString capitalized
]

{ #category : 'utility' }
CBMethod >> asComment: aString [
	"aString asComment duplicates only double quotes that are alone, which is not what I want"
	^ aString copyReplaceAll: '"' with: '""'
]

{ #category : 'definition' }
CBMethod >> getter: aVariableName [

	self protocolName: 'accessing'.
	self source: ('<1s>
	^ <1s>' expandMacrosWith: aVariableName)
]

{ #category : 'definition' }
CBMethod >> getter: aVariableName comment: aComment [

	aComment ifNil: [ ^ self getter: aVariableName ].
	self protocolName: 'accessing'.
	self source: ('<1s>
	"<2s>"
	^ <1s>'
			 expandMacrosWith: aVariableName
			 with: (self asComment: aComment))
]

{ #category : 'definition' }
CBMethod >> getter: aVariableName comment: aComment defaultValue: aDefaultValue [

	aComment ifNil: [
		^ self getter: aVariableName defaultValue: aDefaultValue ].
	self protocolName: 'accessing'.
	self source: ('<1s>
	"<2s>"
	^ <1s> ifNil: [ <1s> := <3s> ]'
			 expandMacrosWith: aVariableName
			 with: (self asComment: aComment)
			 with: aDefaultValue)
]

{ #category : 'definition' }
CBMethod >> getter: aVariableName defaultValue: aDefaultValue [

	self protocolName: 'accessing'.
	self source: ('<1s>
	^ <1s> ifNil: [ <1s> := <2s> ]'
			 expandMacrosWith: aVariableName
			 with: aDefaultValue)
]

{ #category : 'definition' }
CBMethod >> getter: aVariableName delegateFrom: aString [
	self protocolName: 'accessing'.
	self
		source:
			('<1s>
	^ <2s> <1s>' expandMacrosWith: aVariableName with: aString)
]

{ #category : 'initialization' }
CBMethod >> initialize [
	super initialize.
	protocolName := 'as yet unclassified'
]

{ #category : 'accessing' }
CBMethod >> protocol [

	self
		deprecated: 'Use #protocolName instead'
		transformWith: '`@receiver protocol' -> '`@receiver protocolName'.
	^ self protocolName
]

{ #category : 'accessing' }
CBMethod >> protocol: aProtocolName [

	self
		deprecated: 'Use #protocolName: instead'
		transformWith:
		'`@receiver protocol: `@arg' -> '`@receiver protocolName: `@arg'.
	^ self protocolName: aProtocolName
]

{ #category : 'accessing' }
CBMethod >> protocolName [
	^ protocolName
]

{ #category : 'accessing' }
CBMethod >> protocolName: aString [
	protocolName := aString
]

{ #category : 'accessing' }
CBMethod >> selector [
	^ (OCParser parseMethod: source) selector
]

{ #category : 'definition' }
CBMethod >> setter: aVariableName argument: anArgumentName [

	self protocolName: 'accessing'.
	self source: ('<1s>: <2s>
	<1s> := <2s>'
			 expandMacrosWith: aVariableName
			 with: (self asArgumentName: anArgumentName))
]

{ #category : 'definition' }
CBMethod >> setter: aVariableName argument: anArgumentName comment: aComment [
	aComment ifNil: [ ^ self setter: aVariableName argument: anArgumentName ].
	self protocolName: 'accessing'.
	self
		source:
			('<1s>: <2s>
	"<3s>"
	<1s> := <2s>'
				expandMacrosWith: aVariableName
				with: (self asArgumentName: anArgumentName)
				with: (self asComment: aComment))
]

{ #category : 'definition' }
CBMethod >> setter: aVariableName argument: anArgumentName delegateTo: aString [
	self protocolName: 'accessing'.
	self
		source:
			('<1s>: <2s>
	<3s> <1s>: <2s>'
				expandMacrosWith: aVariableName
				with: (self asArgumentName: anArgumentName)
				with: aString)
]

{ #category : 'definition' }
CBMethod >> setter: aVariableName argument: anArgumentName delegateTo: aString comment: aComment [
	self protocol: 'accessing'.
	self
		source:
			('<1s>: <2s>
	"<4s>"
	<3s> <1s>: <2s>'
				expandMacrosWith: aVariableName
				with: (self asArgumentName: anArgumentName)
				with: aString
				with: (self asComment: aComment))
]

{ #category : 'accessing' }
CBMethod >> source [
	^ source
]

{ #category : 'accessing' }
CBMethod >> source: aString [
	self validateSource: aString.
	source := aString
]

{ #category : 'accessing' }
CBMethod >> validateSource: aString [
	[ OCParser parseMethod: aString ]
		on: OCCodeError
		do: [ :ex | (CBSyntaxError fromCodeError: ex) signal ]
]
