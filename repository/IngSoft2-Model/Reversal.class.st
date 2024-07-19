Class {
	#name : #Reversal,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Reversal >> applyCardEffectWith: aCardManager [
	aCardManager applyReversalOn: target.
]

{ #category : #initialization }
Reversal >> deactivateCard [ 
	target deactivateCard: self class
]
