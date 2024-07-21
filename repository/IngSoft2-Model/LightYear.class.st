Class {
	#name : #LightYear,
	#superclass : #MeasureUnit,
	#category : #'IngSoft2-Model'
}

{ #category : #getsAndSets }
LightYear >> valueAsParsec [
	^(distanceUnits / 3).
]
