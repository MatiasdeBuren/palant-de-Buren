Class {
	#name : #Acceleration,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Acceleration class >> affectRollResult [
	^1.
]

{ #category : #action }
Acceleration >> applyCardEffectWith: aCardManager [
	aCardManager applyAccelerationOn: target.
]

{ #category : #action }
Acceleration >> deactivateCard [ 
	target do: [ :aTarget | aTarget deactivateCard: self class].
]
