Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'target',
		'cardUser'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> canBeUsedAnytime [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card class >> withTarget: aTarget withCardUser: aCardUser [
	^(self new) initializeTarget: aTarget initializeCardUser: aCardUser.
]

{ #category : #initialization }
Card >> applyCardEffect [
	self subclassResponsibility.
]

{ #category : #initialization }
Card >> deactivateCard [
	self subclassResponsibility.
]

{ #category : #initialization }
Card >> initializeTarget: aTarget initializeCardUser: aCardUser [
	target := aTarget.
	cardUser := aCardUser.
	
]
