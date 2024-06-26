"
I hold references to refactored classes, and I convert everything to refactoring changes and filter them.
"
Class {
	#name : 'CBChangeSet',
	#superclass : 'Object',
	#instVars : [
		'classes'
	],
	#category : 'ChangesBuilder-Model',
	#package : 'ChangesBuilder',
	#tag : 'Model'
}

{ #category : 'example' }
CBChangeSet class >> example [

	| cls getter setter init changeSet |
	cls := CBClass new.
	cls name: 'Square'.
	"package name, default 'Unclassified'"
	cls package: 'Geometric-Shapes'.
	"the superclass of Square, default is Object"
	cls parent: 'Object'.

	"add an instance variable"
	cls addInstVarNamed: 'size'.

	"getter: is a convenience method that will generate a basic accessor in 'accessing' protocl"
	getter := CBMethod new getter: 'size'.
	"dtto for setter"
	setter := CBMethod new
		          setter: 'size'
		          argument: 'Number'
		          comment: 'specify a new size'.
	"'hand'-written source is also possible"
	init := CBMethod new
		        source: 'initialize
	size := 0';
		        protocolName: 'initialization'.

	cls addMethod: getter.
	cls addMethod: setter.
	cls addMethod: init.

	changeSet := CBChangeSet new.
	changeSet addClass: cls.

	"ChangesBrowser can also be used, but it throws error on empty changeset"
	^ (CBChangesBrowser changes: changeSet refactoringChanges) open
]

{ #category : 'adding' }
CBChangeSet >> addClass: aClass [
	classes at: aClass name put: aClass
]

{ #category : 'converting' }
CBChangeSet >> allRefactoringChanges [

	| model |
	model := RBNamespace new.
	classes do: [ :each |
		| cls meta |
		model defineClass: each classDefinition.
		cls := model classNamed: each name asSymbol.
		each comment ifNotNil: [ model comment: each comment in: cls ].
		each methods do: [ :method |
			cls compile: method source classified: method protocolName ].
		meta := cls classSide.
		each metaInstanceVariables do: [ :var |
			meta addInstanceVariable: var ].
		each metaMethods do: [ :method |
			meta compile: method source classified: method protocolName ] ].
	^ model changes changes
]

{ #category : 'actions' }
CBChangeSet >> browseChanges [
	^ (CBChangesBrowser changes: self refactoringChanges) open
]

{ #category : 'actions' }
CBChangeSet >> browseChangesIfAny [
	self refactoringChanges ifEmpty: [ ^ self inform: 'No changes' ].
	^ self browseChanges
]

{ #category : 'adding' }
CBChangeSet >> classNamed: aName [
	| class |
	classes at: aName ifPresent: [ :cls | ^ cls ].
	class := CBClass new name: aName.
	self addClass: class.
	^ class
]

{ #category : 'accessing' }
CBChangeSet >> classes [
	^ classes values
]

{ #category : 'adding' }
CBChangeSet >> fromRealClass: aRealClass [
	| class |
	classes at: aRealClass name ifPresent: [ :cls | ^ cls ].
	class := CBClass fromClass: aRealClass.
	self addClass: class.
	^ class
]

{ #category : 'initialization' }
CBChangeSet >> initialize [
	super initialize.
	classes := OrderedDictionary new
]

{ #category : 'converting' }
CBChangeSet >> refactoringChanges [
	^ self allRefactoringChanges
		reject: [ :each | each textToDisplay = each oldVersionTextToDisplay ]
]
