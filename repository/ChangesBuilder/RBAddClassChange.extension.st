Extension { #name : 'RBAddClassChange' }

{ #category : '*ChangesBuilder' }
RBAddClassChange >> oldVersionTextToDisplay [

	^ Smalltalk
		  at: className
		  ifPresent: [ :existingClass | existingClass definitionString ]
		  ifAbsent: [ '' ]
]

{ #category : '*ChangesBuilder' }
RBAddClassChange >> textToDisplay [

	^ (ClassDefinitionPrinter for: (CBAddClassPrintAdaptor for: self))
		  classDefinitionString
]
