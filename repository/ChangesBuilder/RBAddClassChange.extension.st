Extension { #name : 'RBAddClassChange' }

{ #category : '*ChangesBuilder' }
RBAddClassChange >> classLayout [

	^ builder layoutClass new
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> classVariables [

	^ builder sharedVariables
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> hasTraitComposition [

	^ builder traitComposition isNotEmpty
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> localSlots [

	^ builder slots
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> oldVersionTextToDisplay [

	^ Smalltalk
		  at: className
		  ifPresent: [ :existingClass | existingClass definitionString ]
		  ifAbsent: [ '' ]
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> package [

	^ CBPackageNameWrapper withPackageName: builder package
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> packageTag [

	^ PackageTag
		  package: (Package named: builder package)
		  name: builder tag
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> sharedPools [

	^ builder sharedPools
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> superclass [

	^ builder superclass
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> textToDisplay [

	^ (ClassDefinitionPrinter for: self) classDefinitionString
]
