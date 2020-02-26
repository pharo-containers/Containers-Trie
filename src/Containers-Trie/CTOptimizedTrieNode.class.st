Class {
	#name : #CTOptimizedTrieNode,
	#superclass : #Object,
	#instVars : [
		'children',
		'nodeValue'
	],
	#category : #'Containers-Trie'
}

{ #category : #private }
CTOptimizedTrieNode >> addChildWithLetter: aCharacter [

	^ self error: 'Should not be called'
]

{ #category : #accessing }
CTOptimizedTrieNode >> at: aKey put: aNode [

	children := children , { aKey. aNode }
]

{ #category : #accessing }
CTOptimizedTrieNode >> children [
	
	^ children pairsCollect: [ :aKey :aChild | aChild ]
]

{ #category : #accessing }
CTOptimizedTrieNode >> childrenDictionary [
	
	^ Dictionary newFromPairs: children
]

{ #category : #private }
CTOptimizedTrieNode >> findChildWithString: aString [

	^ self findChildWithString: aString storingAncestors: OrderedCollection new adding: false.
]

{ #category : #accessing }
CTOptimizedTrieNode >> findChildWithString: aString storingAncestors: ancestors adding: isAdding [ 

	| newChild keyIndexToSplit splitKey keyToSplit nodeToSplit splittedNode |
	
	aString 
		ifEmpty: [ ^ self ].

	ancestors add: self.

	children pairsDo: [ :aKey :aChild | (aString beginsWith: aKey) 
		ifTrue: [ ^ aChild findChildWithString: (aString allButFirst: aKey size) storingAncestors: ancestors adding: isAdding ] ].
	
	isAdding ifFalse: [ ^ nil ].

	keyIndexToSplit := self findKeyIndexToSplit: aString.
	
	(keyIndexToSplit = -1) ifTrue: [  
		newChild := self class new.
		children := children , { aString. newChild }.
		^ newChild
	].
	
	keyToSplit := children at: keyIndexToSplit.
	nodeToSplit := children at: keyIndexToSplit + 1.
	
	splitKey := keyToSplit takeFirst: (keyToSplit charactersExactlyMatching: aString).
	self removeNode: nodeToSplit.
	
	splittedNode := nodeToSplit splitOn: splitKey oldKey: keyToSplit.
	
	children := children , { splitKey. splittedNode }.
	^ splittedNode findChildWithString: (aString allButFirst: splitKey size) storingAncestors: ancestors adding: isAdding.
		
]

{ #category : #private }
CTOptimizedTrieNode >> findKeyIndexToSplit: aString [ 
	
	| indexToSplit lengthOfPrefix index |
	indexToSplit := -1.
	lengthOfPrefix := 0.
	index := 1.
	
	[ index <= children size ] whileTrue: [  | key prefixLength |
			key := children at:index.
			
			((prefixLength := key charactersExactlyMatching: aString) > lengthOfPrefix) 
				ifTrue: [ indexToSplit := index. lengthOfPrefix := prefixLength ].
			
			index := index + 2.
		].
	
	^ indexToSplit.
]

{ #category : #initialization }
CTOptimizedTrieNode >> initialize [
	super initialize.
	children := #().

]

{ #category : #testing }
CTOptimizedTrieNode >> isCompressed [

	^ children
		ifEmpty: [ self isWord ]
		ifNotEmpty: [ self children allSatisfy: [ :aChild | aChild isCompressed ] ]
]

{ #category : #testing }
CTOptimizedTrieNode >> isWord [
	
	^ nodeValue isNotNil
]

{ #category : #accessing }
CTOptimizedTrieNode >> nodeValue [
	^ nodeValue
]

{ #category : #accessing }
CTOptimizedTrieNode >> nodeValue: anInteger [ 
	nodeValue := anInteger
]

{ #category : #printing }
CTOptimizedTrieNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: 'children : ';
		print: (Dictionary newFromPairs: children) keys asSortedCollection;
		cr;
		nextPutAll: 'value : ';
		print: self nodeValue.
]

{ #category : #private }
CTOptimizedTrieNode >> removeNode: aNode [ 
	
	| nodeIndex keyIndex |
	nodeIndex := children detectIndex: [ :e | e = aNode ].
	keyIndex := nodeIndex - 1.
	
	children at: nodeIndex put: nil.
	children at: keyIndex put: nil.
	
	children := children reject: [ :e | e isNil ].
]

{ #category : #private }
CTOptimizedTrieNode >> splitOn: newKey oldKey: oldKey [ 
	
	| index newParent |
	
	newParent := self class new.
	newParent at: (oldKey allButFirst: newKey size) put: self.
	
	index := 1.
	
	^ newParent
]

{ #category : #private }
CTOptimizedTrieNode >> withAllChildrenDo: aBlock [ 

	aBlock cull: self.
	self children do: [ :aChild | aChild withAllChildrenDo: aBlock ]
]
