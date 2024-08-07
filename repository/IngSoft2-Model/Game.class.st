"
Game has all the other classes initializers, a status in order to check whether the game is over or not and has a function for playing out the turns.
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'dice',
		'ships',
		'deck',
		'maxLaps',
		'players',
		'turnHolder',
		'effectManager',
		'cardManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Game class >> withBoard: aBoard withDice: someDice withPlayers: somePlayers  withMaxLaps: someLaps [
^(self new) initializeBoard: aBoard initializeDice: someDice initializePlayers: somePlayers  initializeMaxLaps: someLaps initializeDeck: (Deck getDeck).
]

{ #category : #'modifier state' }
Game >> calculateMaxFuel [

	| maxFuel |
	maxFuel := 0.
	dice do: [ :x | maxFuel := maxFuel + x getMax ].
	maxFuel := maxFuel * 2.
	^ maxFuel
]

{ #category : #action }
Game >> canPlay: aPlayer [
|penalization|
	penalization := aPlayer getPenalization.
	penalization = 0 ifFalse: [
		penalization := penalization - 1.
		penalization = 0 ifTrue: [ aPlayer ship resetFuelTank ].
		^ false ].
	^ true
]

{ #category : #action }
Game >> checkBounty: rollRes for: player [

	| prob |
	rollRes = (self calculateMaxFuel / 2) ifFalse: [ ^ self ].
	prob := 100 atRandom.
	prob > 20
		ifTrue: [ player ship addFuelCapacity: 1 ]
		ifFalse: [ player ship addFuelCapacity: -1 ]
]

{ #category : #action }
Game >> getLeaderboard [
   | sortedPlayers |
	sortedPlayers := OrderedCollection new.
	(self getRanking) do: [ :player | sortedPlayers add: (player getName)]	.
	^sortedPlayers.
]

{ #category : #testing }
Game >> getPlayers [
 ^players.
]

{ #category : #action }
Game >> getRanking [

    | sortedPlayers |

    sortedPlayers := players.

    ^ sortedPlayers asSortedCollection: [ :playerA :playerB |
          ((playerA ship getLaps ) * board boardSize + playerA ship getShipPosition)
          >=
          ((playerB ship getLaps ) * board boardSize + playerB ship getShipPosition) ]
]

{ #category : #action }
Game >> giveTurn: aPlayer [

	(self canPlay: aPlayer) ifTrue: [ turnHolder := aPlayer ]
]

{ #category : #action }
Game >> hasWinner [

	^ players anySatisfy: [ :x | x ship getLaps >= maxLaps ]
]

{ #category : #initialization }
Game >> initializeBoard: aBoard initializeDice: someDice initializePlayers: playerAmount initializeMaxLaps: someLaps initializeDeck: aDeck [

	deck := aDeck.
	maxLaps := someLaps.
	board := aBoard.
	dice := someDice.
	players := OrderedCollection new.
	(1 to: playerAmount) do: [ :x |
		players add: ((Player
				  named: x asString
				  withShip: (Ship withFuel: self calculateMaxFuel)) addCards:
				 (Deck getRandomCards: 2)) ].
	effectManager := EffectManager withPlayers: players withBoard: aBoard.
	cardManager  := CardManager withEffectManager: effectManager.
]

{ #category : #action }
Game >> playTurn: player [

	| rollRes thisEffect |
	turnHolder = player ifFalse: [ ^ self ].
	rollRes := player play: dice.
	self checkBounty: rollRes for: player.
	thisEffect := board move: player distance: rollRes.
	effectManager trigger: thisEffect by: player.
]

{ #category : #action }
Game >> player: aPlayer throwsCard: aCard targetting: aTarget [

	(aPlayer = turnHolder or: (cardManager canApply: aCard))
		ifFalse: [ Error signal: 'Permanent card can only be thrown during players turn' ].
	aPlayer
				useCard:
				(aCard withTarget: aTarget withCardUser: aPlayer)
				with: cardManager.
			aPlayer removeCard: aCard.
	
]

{ #category : #action }
Game >> skipTurn: player [

	turnHolder = player ifTrue: [ player ship resetFuelTank ]
]
