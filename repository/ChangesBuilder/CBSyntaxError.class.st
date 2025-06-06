"
I am fired when CBMethod was provided with invalid source code.
I repackage SyntaxErrorNotification, because the error processing in SyntaxErrorNotification is broken and can induce image corruption.
"
Class {
	#name : 'CBSyntaxError',
	#superclass : 'Error',
	#instVars : [
		'code',
		'location'
	],
	#category : 'ChangesBuilder-Model',
	#package : 'ChangesBuilder',
	#tag : 'Model'
}

{ #category : 'instance creation' }
CBSyntaxError class >> fromCodeError: anError [
	^ self new
		setCode: anError sourceCode
		location: anError location
		errorMessage: anError messageText
]

{ #category : 'initialization' }
CBSyntaxError >> defaultAction [
	UIManager default longMessage: self styledErrorMessage title: self messageText.
	super defaultAction
]

{ #category : 'initialization' }
CBSyntaxError >> errorCode [
	^ code
]

{ #category : 'initialization' }
CBSyntaxError >> location [
	^ location
]

{ #category : 'initialization' }
CBSyntaxError >> setCode: aSourceCode location: aLocation errorMessage: anErrorMessage [
	code := aSourceCode.
	location := aLocation.
	messageText := anErrorMessage
]

{ #category : 'initialization' }
CBSyntaxError >> styledErrorMessage [
	^ self errorCode asText
		copyReplaceFrom: self location
		to: self location - 1
		with: ((self messageText , ' -> ') asText allBold makeAllColor: Color red)
]
