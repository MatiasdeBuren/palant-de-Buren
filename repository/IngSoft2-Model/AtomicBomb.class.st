Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
AtomicBomb >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyAtomicBomb.
]
