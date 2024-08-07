Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
BlackHole >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyBlackHoleOn: aPlayer.
]

{ #category : #action }
BlackHole >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyReverseBlackHoleOn: aPlayer.
]
