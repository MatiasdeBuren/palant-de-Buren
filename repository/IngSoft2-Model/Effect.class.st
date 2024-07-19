Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Effect >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
Effect >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	self subclassResponsibility 
]
