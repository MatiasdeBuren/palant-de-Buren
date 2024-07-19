Class {
	#name : #NullEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
NullEffect >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	^true
]

{ #category : #'as yet unclassified' }
NullEffect >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	^true.
]
