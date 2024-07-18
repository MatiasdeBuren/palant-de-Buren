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

{ #category : #'as yet unclassified' }
EffectManager >> applyAtomicBomb [
	players do: [ :aPlayer |
		aPlayer ship getGravity > 0 ifFalse: [ board resetToStart: aPlayer ] ]
]

{ #category : #'as yet unclassified' }
EffectManager >> applyBlackWholeOn: aPlayer [
	board move: (aPlayer) distance: -4
]

{ #category : #'as yet unclassified' }
EffectManager >> applyCardDealerOn: aPlayer [
	aPlayer addCards: (Deck getRandomCards: 1).
]

{ #category : #'as yet unclassified' }
EffectManager >> applyHyperGravityOn: aPlayer withNecessaryRolledResult: necessaryRolledResult [
	aPlayer ship setGravity: necessaryRolledResult.
]

{ #category : #'as yet unclassified' }
EffectManager >> applyHyperJumpOn: aPlayer withCycleDistance: someParsecs [
	board move: aPlayer jumping: someParsecs.
]

{ #category : #'as yet unclassified' }
EffectManager >> applyLastEffectTriggeredBy: targetPlayer [
	lastEffect applyEffectWithManager: self triggeredBy: targetPlayer.
]

{ #category : #'as yet unclassified' }
EffectManager >> applyMoonWalkWithDistance: someDistance triggeredBy: immunePlayer [
	players do: [ :aPlayer |
		immunePlayer = aPlayer ifFalse: [
			aPlayer ship getGravity > 0 ifFalse: [
				board move: aPlayer distance: someDistance * -1 ] ] ]
]

{ #category : #'as yet unclassified' }
EffectManager >> applyWormOn: aPlayer withLink: linkPosition [
	board takeOut: aPlayer.
	board place: aPlayer at: linkPosition
]

{ #category : #initialization }
EffectManager >> initializePlayers: somePlayers initializeBoard: aBoard [
players := somePlayers.
board := aBoard.
]

{ #category : #initialization }
EffectManager >> setLastEffect: anEffect [
	lastEffect := anEffect.
]
