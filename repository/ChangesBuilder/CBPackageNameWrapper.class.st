Class {
	#name : 'CBPackageNameWrapper',
	#superclass : 'Object',
	#traits : 'TComparable',
	#classTraits : 'TComparable classTrait',
	#instVars : [
		'packageName'
	],
	#category : 'ChangesBuilder-Model',
	#package : 'ChangesBuilder',
	#tag : 'Model'
}

{ #category : 'instance creation' }
CBPackageNameWrapper class >> withPackageName: aString [

	^ self new
		  packageName: aString;
		  yourself
]

{ #category : 'comparing' }
CBPackageNameWrapper >> < aComparable [
	"Answer whether the receiver is less than the argument."

	^ self packageName < aComparable
]

{ #category : 'comparing' }
CBPackageNameWrapper >> = aComparable [
	"Compare the receiver with the argument and answer with true if the
	receiver is equal to the argument. Otherwise answer false."

	^ self packageName = aComparable
]

{ #category : 'accessing' }
CBPackageNameWrapper >> basicAt: anIndex [

	^ self packageName basicAt: anIndex
]

{ #category : 'reflective operations' }
CBPackageNameWrapper >> doesNotUnderstand: aMessage [

	packageName ifNil: [ ^ super doesNotUnderstand: aMessage ].
	^ aMessage sendTo: packageName
]

{ #category : 'comparing' }
CBPackageNameWrapper >> hash [
	"Hash must be redefined whenever = is redefined."

	^ packageName hash
]

{ #category : 'testing' }
CBPackageNameWrapper >> isString [

	^ self packageName isString
]

{ #category : 'testing' }
CBPackageNameWrapper >> isSymbol [

	^ self packageName isSymbol
]

{ #category : 'accessing' }
CBPackageNameWrapper >> name [

	^ self packageName
]

{ #category : 'accessing' }
CBPackageNameWrapper >> packageName [

	^ packageName
]

{ #category : 'accessing' }
CBPackageNameWrapper >> packageName: aString [

	packageName := aString
]

{ #category : 'accessing' }
CBPackageNameWrapper >> size [

	^ self packageName size
]
