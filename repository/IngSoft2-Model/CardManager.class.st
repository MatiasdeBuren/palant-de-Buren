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
CardManager >> applyCancellationOn: targetCard [
	targetCard deactivateCard.
]

{ #category : #action }
CardManager >> applyOverloadOn: targetPlayer [
	targetPlayer activateCard: Overload.
	
	
]

{ #category : #action }
CardManager >> applyRedoOn: aTargetPlayer usedBy: aCardUser [

	lastCard ifNotNil: [
		(lastCard withTarget: aTargetPlayer withCardUser: aCardUser)
			applyCardEffectWith: self ]
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
