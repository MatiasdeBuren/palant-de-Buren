Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'squares',
		'parsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedBoard class >> clone: aBoard [
	^(self new) copyBoard: aBoard.
]

{ #category : #initialization }
LoadedBoard >> boardSize [
	^(squares size).
]

{ #category : #'as yet unclassified' }
LoadedBoard >> calculateMissingFuelFor: aPlayer traveling: aDistance [

	| necessaryFuel |
	necessaryFuel := aPlayer ship getFuel
	                 +
	                 (aPlayer getAlly sumNumbers: [ :ally |
		                  ally ship getFuel ]).
	necessaryFuel >= aDistance ifTrue: [ ^ true ].
	^ false
]

{ #category : #testing }
LoadedBoard >> canReach: aPlayer distance: aDistance [

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
		ally ship getFuel > fuelUsed
			ifTrue: [ ally ship consumeFuel: fuelUsed ]
			ifFalse: [
				fuelUsed := fuelUsed - ally ship getFuel.
				ally ship consumeFuel: aDistance ] ].

	^ true
]

{ #category : #'as yet unclassified' }
LoadedBoard >> changeEffectOf: targetSquare [
	squares do: [ :square | (square = targetSquare) ifTrue: square revertEffect].
]

{ #category : #initialization }
LoadedBoard >> copyBoard: aBoard [
	squares := aBoard getSquares.
	parsecs := aBoard getParsecs.
]

{ #category : #'as yet unclassified' }
LoadedBoard >> correctPosition: aPosition [
	| positionToReturn |
	positionToReturn := aPosition \\ self boardSize.
	positionToReturn = 0 ifTrue: [^ self boardSize].
	positionToReturn < 0 ifTrue: [^ positionToReturn + self boardSize].
	^ positionToReturn.
]

{ #category : #accessing }
LoadedBoard >> findSquareWithEffect: anEffect [
	1 to: self boardSize do: [ :x | (((squares at: x) getEffect) class = anEffect) ifTrue:[ ^x] ].
	^-1.
]

{ #category : #accessing }
LoadedBoard >> findWormSquares [

	| positions |
	positions := OrderedCollection new.
	1 to: (self boardSize) do: [ :x | (((squares at: x) getEffect) class = WormEffect)ifTrue:[ positions add: x ] ].
	^positions.
]

{ #category : #initialization }
LoadedBoard >> getParsecs [
	^parsecs.
]

{ #category : #'as yet unclassified' }
LoadedBoard >> getSquares [ 
	^squares.
]

{ #category : #initialization }
LoadedBoard >> initializeEffect: anEffect initializeAt: aSquare [
	(squares at: aSquare) initializeWithEffect: anEffect.
	
]

{ #category : #initialization }
LoadedBoard >> initializeWormSquares [

	| worm1Position worm1 worm2Position worm2 |
	worm1Position := (self boardSize) atRandom.
	worm2Position := (self boardSize) atRandom.
	[ worm1Position = worm2Position ] whileTrue: [
		worm2Position := (self boardSize) atRandom ].
	worm1 := WormEffect with:worm1Position withLink: worm2Position.
	worm2 := WormEffect with:worm2Position withLink: worm1Position.
	(squares at: worm1Position) initializeWithEffect: worm1. 
	(squares at: worm2Position) initializeWithEffect: worm2.
]

{ #category : #initialization }
LoadedBoard >> move: aPlayer distance: aDistance [

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

{ #category : #'as yet unclassified' }
LoadedBoard >> move: aPlayer jumping: someParsecs [
	self move: aPlayer distance: (someParsecs * (self boardSize / parsecs)) truncated.
]

{ #category : #initialization }
LoadedBoard >> place: aPlayer at: aPosition [

	| moveTo lapsToAdd |
	lapsToAdd := aPosition // self boardSize.
	moveTo := self correctPosition: aPosition.
	aPlayer ship setShipPosition: moveTo.
	aPlayer ship addLaps: lapsToAdd.
	^ (squares at: moveTo) dockShip: aPlayer ship
]

{ #category : #initialization }
LoadedBoard >> removeEffects [
	squares do: [ :square | square initializeWithEffect: NullEffect new ]
]

{ #category : #initialization }
LoadedBoard >> resetToStart: aPlayer [
	self takeOut: aPlayer.
	self place: aPlayer at: 1.
]

{ #category : #initialization }
LoadedBoard >> takeOut: aPlayer [

	| shipPosition |
	shipPosition := aPlayer ship getShipPosition.
	aPlayer ship setShipPosition: -1.
	^ (squares at: shipPosition) undockShip: aPlayer ship
]
