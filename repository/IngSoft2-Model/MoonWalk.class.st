Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'myDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk class >> withDistance: aDistance [
 ^(self new) initializeDistance: aDistance.
]

{ #category : #application }
MoonWalk >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyMoonWalkWithDistance: myDistance triggeredBy: aPlayer.
]

{ #category : #'as yet unclassified' }
MoonWalk >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyReverseMoonWalkWithDistance: myDistance triggeredBy: aPlayer.
]

{ #category : #initialization }
MoonWalk >> initializeDistance: aDistance [
 myDistance := aDistance.
]
