Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCard',
		'effectManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardManager class >> withEffectManager: anEffectManager [
	^(self new) initializeEffectManager: anEffectManager. 
]

{ #category : #'as yet unclassified' }
CardManager >> applyAccelerationOn: targetPlayer [
	targetPlayer do: [ :player | player activateCard: Acceleration].
	
]

{ #category : #'as yet unclassified' }
CardManager >> applyAllyOn: targetPlayer usedBy: cardUser [
	cardUser setAlly: targetPlayer.
	cardUser activateCard: Ally.
	targetPlayer setAlly: targetPlayer.
	targetPlayer activateCard: Ally.
]

{ #category : #'as yet unclassified' }
CardManager >> applyCancellationOn: targetPlayer with: targetCard [
	targetPlayer deactivateCard: targetCard.
]

{ #category : #'as yet unclassified' }
CardManager >> applyOverloadOn: targetPlayer [
	targetPlayer activateCard: Overload.
	
	
]

{ #category : #'as yet unclassified' }
CardManager >> applyRedoOn: targetPlayer with: targetCard [
	lastCard isNil ifFalse: [
		(lastCard
			 withTargetPlayer: targetPlayer
			 withTargetCard: targetCard) applyCardEffect: targetPlayer with: self]
	
	
]

{ #category : #'as yet unclassified' }
CardManager >> applyRepeatOn: targetPlayer [
	effectManager applyLastEffectTriggeredBy: targetPlayer.
]

{ #category : #initialization }
CardManager >> initializeEffectManager: anEffectManager [
	effectManager := anEffectManager.
	lastCard := nil.
	
]

{ #category : #initialization }
CardManager >> setLastCard: aCard [
	lastCard := aCard.
]
