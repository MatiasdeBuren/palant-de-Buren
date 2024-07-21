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
	lastCard := Acceleration
	
]

{ #category : #action }
CardManager >> applyAllyOn: targetPlayer usedBy: cardUser [
	cardUser setAlly: targetPlayer.
	cardUser activateCard: Ally.
	targetPlayer setAlly: cardUser.
	targetPlayer activateCard: Ally.
	lastCard := Ally.
]

{ #category : #action }
CardManager >> applyCancellationOn: targetCard [
	targetCard deactivateCard.
	lastCard := Cancellation 
]

{ #category : #action }
CardManager >> applyOverloadOn: targetPlayer [
	targetPlayer activateCard: Overload.
	lastCard := Overload.
	
	
]

{ #category : #action }
CardManager >> applyRedoOn: aTargetPlayer usedBy: aCardUser [

	lastCard ifNotNil: [
		(lastCard withTarget: aTargetPlayer withCardUser: aCardUser)
			applyCardEffectWith: self ].
]

{ #category : #action }
CardManager >> applyRepeatOn: targetPlayer [
	effectManager applyLastEffectTriggeredBy: targetPlayer.
	lastCard := Repeat.
]

{ #category : #action }
CardManager >> applyReversalOn: targetSquare [
	effectManager revertEffectOf: targetSquare.
	lastCard := Reversal.
]

{ #category : #action }
CardManager >> applyTimeMachineOn: targetPlayer [
	
	lastCard := TimeMachine.
	
	
]

{ #category : #action }
CardManager >> applyTimeMachineOn: targetPlayer usedBy: aCardUser [

	| fuelToApply penultimateIndex |
	(self timeMachineCanBeUsedOn: targetPlayer by: aCardUser) ifTrue: [
		penultimateIndex := aCardUser ship fuelUsage size - 2.
		fuelToApply := aCardUser ship fuelUsage at: penultimateIndex.
		targetPlayer ship setFuel: fuelToApply.
		targetPlayer getAlly do: [ :ally | ally ship setFuel: fuelToApply ].
		lastCard := TimeMachine ].
	
]

{ #category : #initialization }
CardManager >> initializeEffectManager: anEffectManager [
	effectManager := anEffectManager.
	lastCard := nil.
	
]

{ #category : #'as yet unclassified' }
CardManager >> timeMachineCanBeUsedOn: targetPlayer by: aCardUser [

	(targetPlayer ship fuelUsage size > 2 and:
		 aCardUser ship fuelUsage size > 2) ifTrue: [ ^ true ].
	^ false
]
