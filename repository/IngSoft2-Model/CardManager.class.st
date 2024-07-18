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

{ #category : #action }
CardManager >> applyAccelerationOn: targetPlayer [
	targetPlayer do: [ :player | player activateCard: Acceleration].
	
]

{ #category : #action }
CardManager >> applyAllyOn: targetPlayer usedBy: cardUser [
	cardUser setAlly: targetPlayer.
	cardUser activateCard: Ally.
	targetPlayer setAlly: cardUser.
	targetPlayer activateCard: Ally.
]

{ #category : #action }
CardManager >> applyCancellationOn: targetPlayer with: targetCard [
	targetPlayer deactivateCard: targetCard.
]

{ #category : #action }
CardManager >> applyOverloadOn: targetPlayer [
	targetPlayer activateCard: Overload.
	
	
]

{ #category : #action }
CardManager >> applyRedoOn: targetPlayer with: targetCard usedBy: cardUser [

	lastCard ifNotNil: [
		(lastCard withTargetPlayer: targetPlayer withTargetCard: targetCard)
			applyCardEffect: cardUser
			with: self ]
]

{ #category : #action }
CardManager >> applyRepeatOn: targetPlayer [
	effectManager applyLastEffectTriggeredBy: targetPlayer.
]

{ #category : #initialization }
CardManager >> initializeEffectManager: anEffectManager [
	effectManager := anEffectManager.
	lastCard := nil.
	
]

{ #category : #getsAndSets }
CardManager >> setLastCard: aCard [
	lastCard := aCard.
]
