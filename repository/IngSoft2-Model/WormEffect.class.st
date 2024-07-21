Class {
	#name : #WormEffect,
	#superclass : #Effect,
	#instVars : [
		'myPosition',
		'linkPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormEffect class >> with: myPos withLink: linkPos [
	^(self new) initializePosition: myPos initializeLink: linkPos.
]

{ #category : #action }
WormEffect >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyWormOn: aPlayer withLink: linkPosition
]

{ #category : #action }
WormEffect >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyReverseWormOn: aPlayer withLink: linkPosition with: myPosition
]

{ #category : #initialization }
WormEffect >> initializePosition: myPos initializeLink: linkPos [
	myPosition := myPos.
	linkPosition := linkPos.
]
