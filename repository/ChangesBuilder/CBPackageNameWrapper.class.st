Class {
	#name : 'CBPackageNameWrapper',
	#superclass : 'Object',
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

{ #category : 'reflective operations' }
CBPackageNameWrapper >> doesNotUnderstand: aMessage [

	packageName ifNil: [ ^ super doesNotUnderstand: aMessage ].
	^ aMessage sendTo: packageName
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
