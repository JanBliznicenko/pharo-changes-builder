Class {
	#name : 'CBChangeSetTest',
	#superclass : 'TestCase',
	#instVars : [
		'changeSet'
	],
	#category : 'ChangesBuilder-Tests',
	#package : 'ChangesBuilder',
	#tag : 'Tests'
}

{ #category : 'running' }
CBChangeSetTest >> setUp [
	super setUp.
	changeSet := CBChangeSet new
]

{ #category : 'tests' }
CBChangeSetTest >> testAddClass [
	| class |
	class := CBClass new name: 'GeneratedClass'.
	changeSet addClass: class.
	self assert: changeSet classes equals: {class}
]

{ #category : 'tests' }
CBChangeSetTest >> testAddClassChanges [

	| class builder |
	class := CBClass new name: 'GeneratedClass'.
	class addInstVarNamed: 'var1'.
	class addClassVarNamed: 'classVar1'.
	changeSet addClass: class.
	self assert: changeSet classes equals: { class }.
	builder := changeSet allRefactoringChanges first builder.
	self assert: builder superclassName equals: 'Object'.
	self assert: builder name equals: #GeneratedClass.
	self
		assertCollection: (builder slots collect: #name)
		equals: #( var1 ).
	self
		assertCollection: (builder sharedVariables collect: #name)
		equals: #( classVar1 ).
	self assert: builder package equals: 'Unclassified'.
	self assert: builder tag equals: ''
]

{ #category : 'tests' }
CBChangeSetTest >> testAddMetaClassChanges [
	| class |
	class := CBClass new name: 'GeneratedClass'.
	class addMetaInstVarNamed: 'metaVar1'.
	changeSet addClass: class.
	self assert: changeSet classes equals: {class}.
	self
		assert: changeSet allRefactoringChanges second textToDisplay withUnixLineEndings
		equals: 'Add instance variable metaVar1 to GeneratedClass class'
]

{ #category : 'tests' }
CBChangeSetTest >> testClassNamed [
	| class |
	class := changeSet classNamed: 'Unit'.
	self assert: class name equals: 'Unit'.
	self assert: changeSet classes asArray equals: {class}
]

{ #category : 'tests' }
CBChangeSetTest >> testClassNamedSame [
	| classA classB |
	classA := changeSet classNamed: 'Unit'.
	classB := changeSet classNamed: 'Unit'.
	self assert: classA == classB
]

{ #category : 'tests' }
CBChangeSetTest >> testClassWithMetaMethodChanges [

	| class methodRefactoring |
	class := CBClass new name: 'GeneratedClass'.
	class addMetaMethod: (CBMethod new
			 source: 'meth ^ 1';
			 protocolName: 'my protocol').
	changeSet addClass: class.
	self assert: changeSet classes equals: { class }.
	methodRefactoring := changeSet allRefactoringChanges second.
	self assert: methodRefactoring isMeta.
	self assert: methodRefactoring textToDisplay equals: '"my protocol"
meth ^ 1'
]

{ #category : 'tests' }
CBChangeSetTest >> testClassWithMethodChanges [

	| class |
	class := CBClass new name: 'GeneratedClass'.
	class addMethod: (CBMethod new
			 source: 'meth ^ 1';
			 protocolName: 'my protocol').
	changeSet addClass: class.
	self assert: changeSet classes equals: { class }.
	self
		assert: changeSet allRefactoringChanges second textToDisplay
		equals: '"my protocol"
meth ^ 1'
]

{ #category : 'tests' }
CBChangeSetTest >> testFromRealClass [

	| realClass class |
	realClass := self class.
	class := changeSet fromRealClass: realClass.
	self assert: class instVarNames equals: realClass instVarNames.
	self assert: class parent equals: realClass superclass name.
	self assert: changeSet classes asArray equals: { class }
]
