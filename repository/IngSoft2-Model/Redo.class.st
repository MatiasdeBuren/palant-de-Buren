Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Redo class >> canBeUsedConsidering: lastCard [
	(lastCard isNil) ifFalse:[
	^ lastCard canBeUsedConsidering: self.
	].
	^true.
]

{ #category : #initialization }
Redo >> applyCardEffectWith: aCardManager [
	aCardManager applyRedoOn: target usedBy: cardUser.
]
