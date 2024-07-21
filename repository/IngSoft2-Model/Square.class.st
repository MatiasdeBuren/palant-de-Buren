"
Square can dock and undock ships from itself and can return which ships are docked there.
"
Class {
	#name : #Square,
	#superclass : #Object,
	#instVars : [
		'dockedShips',
		'myEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Square class >> createEmptySquare [
	^(self new) initializeWithEffect: NullEffect new.
]

{ #category : #accessing }
Square >> deactivateCard: aCard [
	myEffect := myEffect reverseBack.
]

{ #category : #initialization }
Square >> dockShip: aShip [
	dockedShips add: aShip.
	^myEffect.
]

{ #category : #testing }
Square >> getDockedShips [
	^dockedShips.
]

{ #category : #testing }
Square >> getEffect [
	^myEffect.
]

{ #category : #initialization }
Square >> initializeWithEffect: anEffect [

	myEffect := anEffect.
	dockedShips := OrderedCollection new
]

{ #category : #action }
Square >> revertEffect [
	myEffect := ReverseEffectWrapper withEffectToReverse: myEffect.
]

{ #category : #modifying }
Square >> undockShip: aShip [

	dockedShips remove: aShip ifAbsent: [ ^ false ].
	^ true
]
