"
Board is made of squares, has the responsability of moving a ship and the initializers of particular squares.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> withSize: aSize withWorms: hasWorms withUnits: someParsecs withDice: someDice [
	|boardToReturn|
	boardToReturn := ((self new) initializeSize: aSize initializeParsecs: someParsecs valueAsParsec).
	boardToReturn initializeRandomEffects: someDice.
	(hasWorms) ifTrue: [boardToReturn initializeWormSquares].
	^boardToReturn.
]

{ #category : #getsAndSets }
Board >> boardSize [
	^(squares size).
]

{ #category : #'as yet unclassified' }
Board >> calculateMissingFuelFor: aPlayer traveling: aDistance [

	| necessaryFuel |
	necessaryFuel := (aPlayer ship getFuel) + (aPlayer getAlly sumNumbers: [
		                 :ally | ally getFuel ]).
	
	necessaryFuel >= aDistance ifTrue: [ ^ true ].
	^ false
]

{ #category : #action }
Board >> canReach: aPlayer distance: aDistance [

	| fuelUsed |
	aPlayer ship getFuel >= aDistance ifTrue: [
		aPlayer ship consumeFuel: aDistance.
		^ true ].
	(self calculateMissingFuelFor: aPlayer traveling: aDistance)
		ifFalse: [
			aPlayer ship consumeFuel: aDistance.
			aPlayer getAlly do: [ :ally |
				ally ship consumeFuel: aDistance.
				self resetToStart: ally.
				ally penalize: 2 ].
			^ false ].

	fuelUsed := aDistance - aPlayer ship getFuel.
	aPlayer ship consumeFuel: aDistance.
	aPlayer getAlly do: [ :ally |
		ally getFuel > fuelUsed
			ifTrue: [ ally ship consumeFuel: fuelUsed ]
			ifFalse: [
				fuelUsed := fuelUsed - ally ship getFuel.
				ally ship consumeFuel: aDistance ] ].

	^ true
]

{ #category : #action }
Board >> changeEffectOf: targetSquare [
	squares do: [ :square | (square = targetSquare) ifTrue: [square revertEffect]].
]

{ #category : #action }
Board >> correctPosition: aPosition [
	| positionToReturn |
	positionToReturn := aPosition \\ self boardSize.
	positionToReturn = 0 ifTrue: [^ self boardSize].
	positionToReturn < 0 ifTrue: [^ positionToReturn + self boardSize].
	^ positionToReturn.
]

{ #category : #testing }
Board >> getParsecs [
	^parsecs.
]

{ #category : #testing }
Board >> getSquares [
	^squares.
]

{ #category : #initialization }
Board >> initializeRandomEffects: someDice [

	| probabilityScore |
	squares do: [ :square |
		probabilityScore := 100 atRandom.

		probabilityScore <= 30 ifTrue: [
			square initializeWithEffect: NullEffect new ].

		probabilityScore > 30 ifTrue: [
			square initializeWithEffect: (CardDealer new)
			 ].

		probabilityScore > 40 ifTrue: [
			square initializeWithEffect: BlackHole new ].

		probabilityScore > 60 ifTrue: [
			| maxRoll |
			maxRoll := 0.
			someDice do: [ :dice | maxRoll := maxRoll + dice getMax ].
			square initializeWithEffect:
				(HyperGravity withNecessaryRolledResult:
					 (someDice size to: maxRoll atRandom)) ].

		probabilityScore > 80 ifTrue: [
			square initializeWithEffect:
				(MoonWalk withDistance: self boardSize atRandom) ].

		probabilityScore > 90 ifTrue: [
			|unitList|
			unitList := OrderedCollection with: (LightYear withUnits: 2) with:(Parsec withUnits: 1) with: (LightYear withUnits: 1).
			square initializeWithEffect:
				(HyperJump withUnits: unitList)
				].

		probabilityScore > 98 ifTrue: [
			square initializeWithEffect: AtomicBomb new ] ]
]

{ #category : #initialization }
Board >> initializeSize: aSize initializeParsecs: someParsecs [

	squares := OrderedCollection new.
	1 to: aSize do: [ :x | squares add: Square createEmptySquare ].
	parsecs := someParsecs
]

{ #category : #initialization }
Board >> initializeWormSquares [

	| worm1Position worm1 worm2Position worm2 |
	worm1Position := (self boardSize) atRandom.
	worm2Position := (self boardSize) atRandom.
	[ worm1Position = worm2Position ] whileTrue: [
		worm2Position := (self boardSize) atRandom ].
	worm1 := WormEffect with:worm1Position withLink: worm2Position.
	worm2 := WormEffect with:worm1Position withLink: worm1Position.
	(squares at: worm1Position) initializeWithEffect: worm1. 
	(squares at: worm2Position) initializeWithEffect: worm2.
]

{ #category : #action }
Board >> move: aPlayer distance: aDistance [

	| shipPosition |
	shipPosition := aPlayer ship getShipPosition.
	(self canReach: aPlayer distance: aDistance )
		ifTrue: [
			(self takeOut: aPlayer).
			aPlayer ship setShipPosition: shipPosition + aDistance.
			^(self place: aPlayer at: shipPosition + aDistance)
			 ]
		ifFalse: [
			
			
			 self resetToStart: aPlayer.
					  aPlayer penalize: 2.
					  ^NullEffect new.
					 ].
	
]

{ #category : #action }
Board >> move: aPlayer jumping: someParsecs [
	self move: aPlayer distance: (someParsecs * (self boardSize / parsecs)) truncated.
]

{ #category : #action }
Board >> place: aPlayer at: aPosition [

	| moveTo lapsToAdd |
	lapsToAdd := aPosition // self boardSize.
	moveTo := self correctPosition: aPosition.
	aPlayer ship setShipPosition: moveTo.
	aPlayer ship addLaps: lapsToAdd.
	^ (squares at: moveTo) dockShip: aPlayer ship
]

{ #category : #'modifier state' }
Board >> resetToStart: aPlayer [
	self takeOut: aPlayer.
	self place: aPlayer at: 1.
]

{ #category : #'modifier state' }
Board >> takeOut: aPlayer [

	| shipPosition |
	shipPosition := aPlayer ship getShipPosition.
	aPlayer ship setShipPosition: -1.
	^ (squares at: shipPosition) undockShip: aPlayer ship
]
