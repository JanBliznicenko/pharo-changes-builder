"
I override ChangesBrowser>>accept to provide a progress bar.
"
Class {
	#name : 'CBChangesBrowser',
	#superclass : 'StChangesBrowserPresenter',
	#category : 'ChangesBuilder-Utilities',
	#package : 'ChangesBuilder',
	#tag : 'Utilities'
}

{ #category : 'visiting' }
CBChangesBrowser >> accept [

	self okToChange ifFalse: [ ^ self ].
	super accept.
	self withWindowDo: [ :window | window close ]
]

{ #category : 'initialization' }
CBChangesBrowser >> initializeDialogWindow: aWindow [

	super initializeDialogWindow: aWindow.

	aWindow initialExtent: 800 @ 600
]
