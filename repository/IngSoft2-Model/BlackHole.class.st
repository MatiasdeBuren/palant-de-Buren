Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
BlackHole >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyBlackWholeOn: aPlayer.
]
