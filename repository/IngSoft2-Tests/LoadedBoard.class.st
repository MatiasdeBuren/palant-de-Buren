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

{ #category : #initialization }
LoadedBoard >> canReach: aPlayer distance: aDistance [
	| missingFuel |
	(aPlayer ship consumeFuel: aDistance) ifFalse: [
		(aPlayer getAlly isEmpty) ifTrue: [^false].
		missingFuel := aDistance - (aPlayer getAlly at: 1) ship getFuel.
		((aPlayer getAlly at: 1) ship consumeFuel: missingFuel) ifFalse: [
			self resetToStart: (aPlayer getAlly at: 1).
			(aPlayer getAlly at: 1) penalize: 2.
			^ false ] ].
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
	moveTo := aPosition.
	lapsToAdd := moveTo // self boardSize.
	moveTo > 0 ifTrue: [ moveTo := moveTo - (lapsToAdd * self boardSize) ].
	moveTo < 0 ifTrue: [
		moveTo := self boardSize + moveTo
		          + ((lapsToAdd + 1) abs * self boardSize) ].
	aPlayer ship addLaps: lapsToAdd.
	moveTo = 0 ifTrue: [ moveTo := self boardSize ].
	aPlayer ship setShipPosition: moveTo.
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
