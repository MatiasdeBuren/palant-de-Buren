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
Card class >> canBeUsedConsidering: lastCard [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card class >> withTarget: aTarget withCardUser: aCardUser [
	^(self new) initializeTarget: aTarget initializeCardUser: aCardUser.
]

{ #category : #initialization }
Card >> applyCardEffectWith: aCardManager [
	self subclassResponsibility.
]

{ #category : #initialization }
Card >> initializeTarget: aTarget initializeCardUser: aCardUser [
	target := aTarget.
	cardUser := aCardUser.
	
]
