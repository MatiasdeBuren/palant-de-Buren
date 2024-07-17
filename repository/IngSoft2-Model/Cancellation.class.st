Class {
	#name : #Cancellation,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Cancellation >> applyCardEffect: cardUser with: aCardManager [
	aCardManager applyCancellationOn: targetPlayer with: targetCard.
]
