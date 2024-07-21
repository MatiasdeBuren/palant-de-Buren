Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Effect >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	self subclassResponsibility 
]

{ #category : #action }
Effect >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	self subclassResponsibility 
]
