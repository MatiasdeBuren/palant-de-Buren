Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
AtomicBomb >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyAtomicBomb.
]

{ #category : #application }
AtomicBomb >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyAtomicBomb.
]
