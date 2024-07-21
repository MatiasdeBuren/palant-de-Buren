Class {
	#name : #ReverseEffectWrapper,
	#superclass : #Object,
	#instVars : [
		'effectToRevert'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ReverseEffectWrapper class >> withEffectToReverse: anEffect [
	^(self new) initializeEffectToRevert: anEffect.
]

{ #category : #application }
ReverseEffectWrapper >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	effectToRevert applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer
]

{ #category : #application }
ReverseEffectWrapper >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	effectToRevert applyEffectWithManager: anEffectManager triggeredBy: aPlayer.
]

{ #category : #initialization }
ReverseEffectWrapper >> initializeEffectToRevert: anEffect [
	effectToRevert := anEffect.
]

{ #category : #getsAndSets }
ReverseEffectWrapper >> reverseBack [
	^effectToRevert.
]
