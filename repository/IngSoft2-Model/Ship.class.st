"
Ship needs to have a name, has the responsability to roll the dice each turn and has the satuts winner.
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'gravityLevel',
		'position',
		'fuel',
		'maxFuel',
		'laps',
		'fuelUsageHistory'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> withFuel: someFuel [
	^(self new) initializeFuel: someFuel.
]

{ #category : #getsAndSets }
Ship >> addFuelCapacity: someExtraCapacity [
	maxFuel := maxFuel + someExtraCapacity.
]

{ #category : #adding }
Ship >> addFuelUsage: someFuel [

	self fuelUsageSize > 2 ifTrue:[fuelUsageHistory removeFirst.
	fuelUsageHistory add: someFuel].
	self fuelUsageSize < 3 ifTrue: [ fuelUsageHistory add: someFuel ].
]

{ #category : #getsAndSets }
Ship >> addLaps: lapAmount [

	laps := laps + lapAmount.
	laps < 0 ifFalse: [ ^ self ].
	laps := 0.
	position := 1
]

{ #category : #accessing }
Ship >> canMove: aDistance [

	aDistance = gravityLevel ifTrue: [ gravityLevel := 0 ].
	^ gravityLevel = 0
]

{ #category : #accessing }
Ship >> consumeFuel: someFuel [

	| fuelAmountModule |
	fuelAmountModule := someFuel abs.
	fuel := fuel - fuelAmountModule.
	fuel < 0 ifTrue: [
		fuel := 0.
		self addFuelUsage: fuel.
		^ false ].
	self addFuelUsage: fuel.
	^ true
]

{ #category : #getsAndSets }
Ship >> fuelUsage [
	^fuelUsageHistory.
]

{ #category : #getsAndSets }
Ship >> fuelUsageSize [
	^(fuelUsageHistory size).
]

{ #category : #getsAndSets }
Ship >> getFuel [
	^fuel 
]

{ #category : #getsAndSets }
Ship >> getGravity [
	^gravityLevel.
]

{ #category : #getsAndSets }
Ship >> getLaps [
	^laps.
]

{ #category : #getsAndSets }
Ship >> getShipPosition [
	^position 
]

{ #category : #getsAndSets }
Ship >> initializeFuel: someFuel [
	maxFuel := someFuel.
	laps := 0.
	gravityLevel := 0.
	fuel := someFuel.
	fuelUsageHistory := OrderedCollection with: maxFuel.
	
]

{ #category : #accessing }
Ship >> resetFuelTank [
	fuel := maxFuel.
]

{ #category : #'as yet unclassified' }
Ship >> restoreFuelWithTimeMachine [
	fuel := fuelUsageHistory at: 1.
]

{ #category : #testing }
Ship >> setFuel: someFuel [
	fuel := someFuel.
]

{ #category : #getsAndSets }
Ship >> setGravity: someLevel [

	gravityLevel := someLevel
]

{ #category : #getsAndSets }
Ship >> setShipPosition:  someSquare [

	position := someSquare
]
