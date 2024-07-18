Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> test01PlayerCanUseInstantCardsAnytime [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 1.
















]

{ #category : #tests }
CardTest >> test02PlayerCanOnlyUsePermanentCardOnHisTurn [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 3)  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame player: aPlayer throwsCard: Ally targetting: bPlayer.
	self deny: (aPlayer getAlly) equals: bPlayer.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetting: bPlayer.
	self assert: (aPlayer getAlly) equals: bPlayer.
	
















]

{ #category : #tests }
CardTest >> test03RepeatCardMovesTargetShipBackwarsWhenLastEffectIsBlackHole [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 1. 
]

{ #category : #tests }
CardTest >> test04AccelerationIncreasesAllPlayersThrow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetting: aGame getPlayers.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 11.
	self assert: (bPlayer ship getShipPosition) equals: 11.



]

{ #category : #tests }
CardTest >> test05OverloadReducesPlayersThrow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload targetting: bPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 8.


]

{ #category : #tests }
CardTest >> test06AllyCardSetsAnAlly [

	| aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).

	aLoadedBoard := LoadedBoard clone: (Board
			                 withSize: 20
			                 withWorms: false
			                 withUnits: (Parsec withUnits: 1)
			                 withDice: someDice).
	aLoadedBoard removeEffects.
	aGame := Game
		         withBoard: aLoadedBoard
		         withDice: someDice
		         withPlayers: 2
		         withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.

	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	
	aPlayer addCards: (OrderedCollection with: Ally).	
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetting: bPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: aPlayer ship getShipPosition equals: 20.
	self assert: bPlayer ship getFuel equals: 5.
]

{ #category : #tests }
CardTest >> test07AllyCardLeavesActiveCardInPlayer [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetting: bPlayer.
	self assert: (aPlayer getActiveCards size) equals: 1.



]

{ #category : #tests }
CardTest >> test08AllyCardAndItsEffectCanBeRemovedFromPlayer [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetting: bPlayer.
	aPlayer deactivateCard: Ally.
	self assert: (aPlayer getActiveCards size) equals: 0.



]

{ #category : #tests }
CardTest >> test09CancellationCanRemoveAccelerationCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame cardPlayed|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetting: aGame getPlayers.
	aGame giveTurn: bPlayer.
	cardPlayed := Acceleration withTarget: aGame getPlayers withCardUser: aPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetting: cardPlayed.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> test10CancellationCanRemoveOverloadCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame cardPlayed|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload targetting: bPlayer.
	aGame giveTurn: bPlayer.
	cardPlayed := Overload withTarget: bPlayer withCardUser: aPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetting: cardPlayed.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> test11CancellationCardCanRemoveAllyEfect [
	|aPlayer bPlayer someDice aLoadedBoard aGame cardPlayed|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetting: bPlayer.
	cardPlayed := Ally withTarget: bPlayer withCardUser: aPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetting: cardPlayed.
	
	self assert: (aPlayer getActiveCards size) equals: 0.
	self assert: (aPlayer getAlly) equals: nil.
	self assert: (bPlayer getAlly) equals: nil.

]

{ #category : #tests }
CardTest >> test12RedoCardCopiesRepeat [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	bPlayer addCards: (OrderedCollection with: Redo with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame player: bPlayer throwsCard: Redo targetting: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 2.



]

{ #category : #tests }
CardTest >> test13RedoCardDoesNothingIfNoCardsWereUsed [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: bPlayer throwsCard: Redo targetting: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10.
	self assert: (bPlayer ship getShipPosition) equals: 5.


]

{ #category : #tests }
CardTest >> test14RedoCardCanBeThrownMultipleTimesInARow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	bPlayer addCards: (OrderedCollection with: Redo with: Redo with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame player: bPlayer throwsCard: Redo targetting: aPlayer.
	aGame giveTurn: aPlayer.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetting: aPlayer.
	aGame giveTurn: aPlayer.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetting: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 14.



]

{ #category : #tests }
CardTest >> test15RepeatCardMovesTargetShipForwardWhenLastEffectIsHyperJump [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard initializeEffect: (HyperJump withUnits: (OrderedCollection with: (Parsec withUnits: 2))) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 9.
]

{ #category : #tests }
CardTest >> test16RepeatCardMovesAllShipsToStartWhenLastEffectIsAtomicBomb [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard initializeEffect: (AtomicBomb new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 1.
	self assert: (aPlayer ship getShipPosition) equals: 1.
]

{ #category : #tests }
CardTest >> test17RepeatCardGivesAnotherCardToTargetPlayerWhenLastEffectIsCardDealer [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard initializeEffect: (CardDealer new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (bPlayer getCards size) equals: 3.
]

{ #category : #tests }
CardTest >> test18RepeatCardSetsGravityLevelToTargetPlayerWhenLastEffectIsHyperGravity [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard initializeEffect: (HyperGravity withNecessaryRolledResult: 4) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	aGame giveTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 5.
]

{ #category : #tests }
CardTest >> test19RepeatCardMovesAllOtherShipsButTargetBackwardsWhenLastEffectIsMoonWalk [
	|aPlayer bPlayer cPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard initializeEffect: (MoonWalk withDistance: 1) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aLoadedBoard place: cPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 4.
	self assert: (cPlayer ship getShipPosition) equals: 3.
	self assert: (aPlayer ship getShipPosition) equals: 9.
	

]

{ #category : #tests }
CardTest >> test20RepeatCardMovesTargetPlayerWhenLastEffectIsWormEffect [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard initializeEffect: (WormEffect withLink: 19) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 19.
]

{ #category : #tests }
CardTest >> test21RepeatCardDoesNotAffectPlayersWhenLastEffectIsNullEffect [
	|aPlayer bPlayer cPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard initializeEffect: (NullEffect new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aLoadedBoard place: cPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetting: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10.
	self assert: (bPlayer ship getShipPosition) equals: 5.
	self assert: (cPlayer ship getShipPosition) equals: 5.
]

{ #category : #tests }
CardTest >> test22RedoCardCopiesOverload [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 1)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload targetting: bPlayer.
	aGame skipTurn: aPlayer. "FOR FUEL"
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetting: aPlayer.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 13.



]

{ #category : #tests }
CardTest >> test23RedoCardCopiesAlly [
	|aPlayer bPlayer cPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aLoadedBoard place: cPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetting: bPlayer.
	aGame skipTurn: aPlayer. "FOR FUEL"
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetting: cPlayer.
	self assert: (cPlayer getAlly) equals: bPlayer.



]

{ #category : #tests }
CardTest >> test24RedoCardCopiesAcceleration [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetting: aGame getPlayers.
	aGame skipTurn: aPlayer. "FOR FUEL"
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetting: aGame getPlayers.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 12.


]

{ #category : #tests }
CardTest >> test25RedoCardCopiesCancellation [
	|aPlayer bPlayer someDice aLoadedBoard aGame cardPlayed|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withUnits: (Parsec withUnits: 10)  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration with: Acceleration with: Cancellation).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetting: aGame getPlayers.
	aGame player: aPlayer throwsCard: Acceleration targetting: aGame getPlayers.
	cardPlayed := Acceleration withTarget: aGame getPlayers withCardUser: aPlayer.
	aGame player: aPlayer throwsCard: Cancellation targetting: cardPlayed.
	aGame skipTurn: aPlayer. "FOR FUEL"
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetting: cardPlayed.
	self assert: (bPlayer getActiveCards size) equals: 0.
	

]
