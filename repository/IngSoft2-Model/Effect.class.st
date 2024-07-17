Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Effect >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	self subclassResponsibility 
]

{ #category : #application }
Effect >> initializePlayers: somePlayers initializeBoard: aBoard [
players := somePlayers.
board := aBoard.
]
