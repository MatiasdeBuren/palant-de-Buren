Class {
	#name : #HyperGravity,
	#superclass : #Effect,
	#instVars : [
		'necessaryRolledResult'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperGravity class >> withNecessaryRolledResult: someResult [
	^(self new) initializeNecesaryRolledResult: someResult.
]

{ #category : #application }
HyperGravity >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyHyperGravityOn: aPlayer withNecessaryRolledResult: necessaryRolledResult.
]

{ #category : #action }
HyperGravity >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyHyperGravityOn: aPlayer withNecessaryRolledResult: necessaryRolledResult.
]

{ #category : #initialization }
HyperGravity >> initializeNecesaryRolledResult: aResult [
necessaryRolledResult := aResult.
]
