Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Effect >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	self subclassResponsibility 
]
