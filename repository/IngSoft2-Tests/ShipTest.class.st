Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
ShipTest >> testIsValidWhenShipsFuelReducesProportionallyToMovement [

	| aShip aBoard |
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0.
	aShip := Ship named: 'Pepe'.
	aShip initializeTank: (FuelTank withMax: 10).
	aBoard place: aShip at: 1.
	aBoard move: aShip distance: 5.
	self assert: aShip tank status = 5
]

{ #category : #tests }
ShipTest >> testPassesWhenShipCanRollMultipleDice [
	
	|aShip dice |
	dice:= OrderedCollection new.
	dice add: (LoadedDie of: 4).
	dice add: (LoadedDie of: 5).
	aShip := Ship named: 'Nave1'.
	aShip initializeTank: (FuelTank withMax: 1000).
	aShip rollDice: dice.
	self assert: ((aShip rollDice: dice) = 9).
]

{ #category : #tests }
ShipTest >> testShipCannotBeCreatedWithEmptyName [
	self should:[Ship named: ''] raise: Error withMessage: 'Ship must have a name'
]

{ #category : #tests }
ShipTest >> testShipDoesntMoveWhenSkipsTurn [
	|aShip aBoard|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0. 
	aShip := Ship named: 'Pepe'.
	aShip initializeTank: (FuelTank withMax: 1000).
	aBoard place: aShip at: 1.
	aBoard move: aShip distance: (aShip skipTurn).
	self assert: ((aBoard findShip: aShip) = 1). 
]

{ #category : #tests }
ShipTest >> testShipGetsRefueledWhenSkipsTurn [
	|aShip aBoard|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0. 
	aShip := Ship named: 'Pepe'.
	aShip initializeTank: (FuelTank withMax: 20).
	aBoard place: aShip at: 1.
	aBoard move: aShip distance: 5.
	aBoard move: aShip distance: (aShip skipTurn).
	self assert: (aShip tank status = 20). 
]

{ #category : #tests }
ShipTest >> testShipsPositionIsResetWhenShipDoesNotHaveEnoughFuelToMove [
	|aShip aBoard|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 0. 
	aShip := Ship named: 'Pepe'.
	aShip initializeTank: (FuelTank withMax: 3).
	aBoard place: aShip at: 1.
	aBoard move: aShip distance: 10.
	self assert: ((aBoard findShip: aShip) = 1). 
]