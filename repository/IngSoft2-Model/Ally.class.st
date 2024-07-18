Class {
	#name : #Ally,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Ally class >> affectRollResult [
	^0.
]

{ #category : #'as yet unclassified' }
Ally class >> removeCardEffect: aCard fromCards: someCardList fromPlayer: aPlayer [
   someCardList remove: aCard.
	aPlayer setAlly: nil
]

{ #category : #initialization }
Ally >> applyCardEffectWith: aCardManager [
	aCardManager applyAllyOn: target usedBy: cardUser.
]

{ #category : #initialization }
Ally >> deactivateCard [ 
	target deactivateCard: self class.
	cardUser deactivateCard: self class.
	target removeAlly.
	cardUser removeAlly.
]
