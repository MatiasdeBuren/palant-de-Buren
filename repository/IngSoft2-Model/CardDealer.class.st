Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#instVars : [
		'cardTypes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #application }
CardDealer >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyCardDealerOn: aPlayer.
]

{ #category : #action }
CardDealer >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyReverseCardDealerOn: aPlayer.
]
