Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'targetPlayer',
		'targetCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> canBeUsedAnytime [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card class >> withTargetPlayer: aTargetPlayer withTargetCard: aTargetCard [
	^(self new) initializeTargetPlayer: aTargetPlayer initializeTargetCard: aTargetCard.
]

{ #category : #initialization }
Card >> applyCardEffect [
	self subclassResponsibility.
]

{ #category : #initialization }
Card >> initializeTargetPlayer: aTargetPlayer initializeTargetCard: aTargetCard [ 
	targetPlayer := aTargetPlayer.
	targetCard := aTargetCard.
	
]
