Class {
	#name : #TimeMachine,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
TimeMachine >> applyCardEffectWith: aCardManager [
	aCardManager applyTimeMachineOn: target usedBy: cardUser.
]
