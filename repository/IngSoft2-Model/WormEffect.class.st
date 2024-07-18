Class {
	#name : #WormEffect,
	#superclass : #Effect,
	#instVars : [
		'linkPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormEffect class >> withLink: linkPos [
	^(self new) initializeLink: linkPos.
]

{ #category : #action }
WormEffect >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyWormOn: aPlayer withLink: linkPosition
]

{ #category : #initialization }
WormEffect >> initializeLink: linkPos [
	linkPosition := linkPos.
]
