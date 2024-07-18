Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
BoardTest >> test01BoardIsCreatedWithNSquares [
	|aBoard aBoardSize|
	aBoardSize := 4.
	aBoard := Board withSize: aBoardSize withWorms: false withUnits: (Parsec withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	self assert: aBoard boardSize equals: aBoardSize.
]

{ #category : #tests }
BoardTest >> test02BoardCanPlaceShip [
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 4.
	aShip := Ship withFuel: 1000.
	Transcript show: 2 // 5.
	aBoard := Board withSize: aBoardSize withWorms: false withUnits: (Parsec withUnits: 1) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 3.
	self assert: (aShip getShipPosition = 3).
]

{ #category : #tests }
BoardTest >> test03BoardCanMoveShip [
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withUnits: (Parsec withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 1000.
	aPlayer := Player named: 'Pepe' withShip: aShip. 
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: 4.
	self assert: (aShip getShipPosition = 5).
]

{ #category : #tests }
BoardTest >> test04TakeOutReturnsTrueWhenShipGetsRemoved [
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 4.

	aShip := Ship withFuel: 1000.
	aBoard := Board withSize: aBoardSize withWorms: false withUnits: (Parsec withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 3.
	aBoard takeOut: aPlayer.
	self assert: (aShip getShipPosition = -1).
]

{ #category : #tests }
BoardTest >> test05ValidWhenShipGetsResetToStart [

	|aShip aBoard aPlayer|
	aShip := Ship withFuel: 1000.
	aBoard := Board withSize: 100 withWorms: false withUnits: (Parsec withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 5.
	aBoard resetToStart: aPlayer.
	self assert: (aShip getShipPosition = 1).  
]

{ #category : #tests }
BoardTest >> test06BoardCanMoveShipBackwards [
	|aShip aBoard aPlayer|
	aBoard := Board withSize: 10 withWorms: false withUnits: (Parsec withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 1000.
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 5.
	aBoard move: aPlayer distance: -3.
	self assert: (aShip getShipPosition = 2).  
]

{ #category : #tests }
BoardTest >> test07ShipsCanExceedBoardGoingBackwards [ 
	|aBoard aBoardSize aShip aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withUnits: (Parsec withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 1000.
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: -3.
	self assert: aShip getShipPosition equals: 8.
]

{ #category : #tests }
BoardTest >> test08BoardSizeCanBeExpressedWithParsecs [

	|aBoard|
	aBoard := Board withSize: 10 withWorms: false withUnits: (Parsec withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	self assert: aBoard getParsecs equals: 3.
]

{ #category : #tests }
BoardTest >> test09BoardSizeCanBeExpressedWithLightYears [

	|aBoard|
	aBoard := Board withSize: 30 withWorms: false withUnits: (LightYear withUnits: 3) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	self assert: aBoard getParsecs equals: 1.
]

{ #category : #tests }
BoardTest >> test10BoardSizeCanMoveAShipSomeParsecAmount [

	|aBoard aPlayer aShip|
	aBoard := Board withSize: 30 withWorms: false withUnits: (Parsec withUnits: 30) withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 10000.
	aPlayer := Player named: 'Test' withShip: aShip.
	aBoard place: aPlayer at: 1.
	aBoard move: aPlayer jumping: 1.
	self assert: aPlayer ship getShipPosition equals: 2.
]
