Class {
	#name : #LightYear,
	#superclass : #MeasureUnit,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LightYear >> valueAsParsec [
	^(distanceUnits / 3).
]
