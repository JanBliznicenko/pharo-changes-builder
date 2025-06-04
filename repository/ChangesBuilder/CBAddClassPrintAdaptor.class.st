Class {
	#name : 'CBAddClassPrintAdaptor',
	#superclass : 'Object',
	#instVars : [
		'addClassChange'
	],
	#category : 'ChangesBuilder-Model',
	#package : 'ChangesBuilder',
	#tag : 'Model'
}

{ #category : 'instance creation' }
CBAddClassPrintAdaptor class >> for: anAddClassChange [

	^ self new
		  addClassChange: anAddClassChange;
		  yourself
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> addClassChange: anAddClassChange [

	addClassChange := anAddClassChange
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> classLayout [

	^ addClassChange builder layoutClass new
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> classVariables [

	^ addClassChange builder sharedVariables
]

{ #category : 'testing' }
CBAddClassPrintAdaptor >> hasTraitComposition [

	^ addClassChange builder traitComposition isNotEmpty
]

{ #category : 'slots' }
CBAddClassPrintAdaptor >> localSlots [

	^ addClassChange builder slots
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> name [

	^ addClassChange builder name
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> package [

	^ Package named: addClassChange builder package
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> packageTag [

	^ PackageTag
		  package: (Package named: addClassChange builder package)
		  name: addClassChange builder tag
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> sharedPools [

	^ addClassChange builder sharedPools
]

{ #category : 'accessing' }
CBAddClassPrintAdaptor >> superclass [

	^ addClassChange builder superclass
]
