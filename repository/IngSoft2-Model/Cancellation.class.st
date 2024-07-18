Class {
	#name : #Cancellation,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Cancellation >> applyCardEffectWith: aCardManager [
	aCardManager applyCancellationOn: target.
]
