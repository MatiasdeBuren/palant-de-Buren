Class {
	#name : #Repeat,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Repeat >> applyCardEffectWith: aCardManager [
	aCardManager applyRepeatOn: target.
]

{ #category : #initialization }
Repeat >> deactivateCard [ 
	target deactivateCard: self class
]
