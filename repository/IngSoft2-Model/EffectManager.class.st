Class {
	#name : #EffectManager,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'lastEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectManager class >> withPlayers: somePlayers withBoard: aBoard [ 
	^(self new) initializePlayers:  somePlayers initializeBoard: aBoard 
]

{ #category : #action }
EffectManager >> applyAtomicBomb [
	players do: [ :aPlayer |
		aPlayer ship getGravity > 0 ifFalse: [ board resetToStart: aPlayer ] ]
]

{ #category : #action }
EffectManager >> applyBlackHoleOn: aPlayer [
	board move: (aPlayer) distance: -4
]

{ #category : #action }
EffectManager >> applyCardDealerOn: aPlayer [
	aPlayer addCards: (Deck getRandomCards: 1).
]

{ #category : #action }
EffectManager >> applyHyperGravityOn: aPlayer withNecessaryRolledResult: necessaryRolledResult [
	aPlayer ship setGravity: necessaryRolledResult.
]

{ #category : #action }
EffectManager >> applyHyperJumpOn: aPlayer withCycleDistance: someParsecs [
	board move: aPlayer jumping: someParsecs.
]

{ #category : #action }
EffectManager >> applyLastEffectTriggeredBy: targetPlayer [
	lastEffect applyEffectWithManager: self triggeredBy: targetPlayer.
]

{ #category : #action }
EffectManager >> applyMoonWalkWithDistance: someDistance triggeredBy: immunePlayer [
	players do: [ :aPlayer |
		immunePlayer = aPlayer ifFalse: [
			aPlayer ship getGravity > 0 ifFalse: [
				board move: aPlayer distance: someDistance * -1 ] ] ]
]

{ #category : #action }
EffectManager >> applyReverseBlackHoleOn: aPlayer [
	board move: (aPlayer) distance: 4
]

{ #category : #action }
EffectManager >> applyReverseCardDealerOn: aPlayer [
	aPlayer removeRandomCard.
]

{ #category : #action }
EffectManager >> applyReverseHyperJumpOn: aPlayer withCycleDistance: someParsecs [
	board move: aPlayer jumping: someParsecs * (-1).
]

{ #category : #action }
EffectManager >> applyReverseMoonWalkWithDistance: someDistance triggeredBy: immunePlayer [
	players do: [ :aPlayer |
		immunePlayer = aPlayer ifFalse: [
			aPlayer ship getGravity > 0 ifFalse: [
				board move: aPlayer distance: someDistance ] ] ]
]

{ #category : #action }
EffectManager >> applyWormOn: aPlayer withLink: linkPosition [
	board takeOut: aPlayer.
	board place: aPlayer at: linkPosition
]

{ #category : #initialization }
EffectManager >> initializePlayers: somePlayers initializeBoard: aBoard [
	players := somePlayers.
	board := aBoard.
	lastEffect := NullEffect new.
]

{ #category : #'as yet unclassified' }
EffectManager >> revertEffectOf: targetSquare [
	board changeEffectOf: targetSquare.
]

{ #category : #'as yet unclassified' }
EffectManager >> trigger: anEffect by: aPlayer [
	anEffect applyEffectWithManager: self triggeredBy: aPlayer.
	lastEffect := anEffect.
]
