Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'distanceList'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperJump class >> withUnits: aUnitList [
	^(self new) initializeDistances: aUnitList
]

{ #category : #application }
HyperJump >> applyEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyHyperJumpOn: aPlayer withCycleDistance: self cycleDistance
]

{ #category : #action }
HyperJump >> applyReverseEffectWithManager: anEffectManager triggeredBy: aPlayer [
	anEffectManager applyReverseHyperJumpOn: aPlayer withCycleDistance: self cycleDistance.
]

{ #category : #utility }
HyperJump >> cycleDistance [
	| temp |
	temp := distanceList last.
	distanceList removeLast.
	distanceList addFirst: temp.
	^ temp
]

{ #category : #utility }
HyperJump >> initializeDistances: aUnitList [
	distanceList := OrderedCollection new.
	aUnitList do: [ :someUnit | distanceList add: someUnit valueAsParsec].
	distanceList sort.
]
