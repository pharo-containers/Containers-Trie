"
I am the node of a optimized Trie node, I have the children in an array as pairs. 
I am used inside a CTOptimizedTrie
The first element is the key and the second the node.
This nodes have a string as a key, not a single character.

My users should use:

- #findChildWithString: to get my subnode that aplies to the given string, nil if there is not node.
- #findChildWithString:storingAncestors:adding: to get my subnode that aplies to the given string, nil if there is not node. If the node does not exists, it will be added depending of the adding parameter. Also it will store the ancestors passed to reach the final node. 
- #removeNode: Removes a node from my self.
- #withAllChildrenDo: iterates over me and my children.

Private methods are:

- #findKeyIndexToSplit: looks for the correct index of the child to split for a given text. Used during the adding of an element.
- #splitOn:oldKey: I return a new node that includes myself as a child splitting the string in two, so we can add a sibling of my self to the tree.

"
Class {
	#name : #CTOptimizedTrieNode,
	#superclass : #CTAbstractTrieNode,
	#category : #'Containers-Trie'
}

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

{ #category : #'looking-up' }
CTOptimizedTrieNode >> findChildWithString: aString [

	^ self findChildWithString: aString storingAncestors: OrderedCollection new adding: false.
]

{ #category : #'looking-up' }
CTOptimizedTrieNode >> findChildWithString: aString storingAncestors: ancestors adding: isAdding [ 

	| newChild keyIndexToSplit splitKey keyToSplit nodeToSplit splittedNode |
	
	aString 
		ifEmpty: [ ^ self ].

	ancestors add: self.

	children pairsDo: [ :aKey :aChild | (aString beginsWith: aKey) 
		ifTrue: [ ^ aChild findChildWithString: (aString allButFirst: aKey size) storingAncestors: ancestors adding: isAdding ] ].
	
	isAdding ifFalse: [ 
		"If I am not adding, I have to see if any of the children has a key starting with 
		the text I am looking for"
		children pairsDo: [ :aKey :aChild | 
			(aKey beginsWith: aString) 
				ifTrue: [ ^ aChild] ].
		^ nil ].

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

{ #category : #'looking-up' }
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

{ #category : #accessing }
CTOptimizedTrieNode >> keys [

	^ children pairsCollect: [ :aKey :aChild | aKey ]
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

{ #category : #'adding - removing' }
CTOptimizedTrieNode >> removeNode: aNode [ 
	
	| nodeIndex keyIndex |
	nodeIndex := children detectIndex: [ :e | e = aNode ].
	keyIndex := nodeIndex - 1.
	
	children at: nodeIndex put: nil.
	children at: keyIndex put: nil.
	
	children := children reject: [ :e | e isNil ].
]

{ #category : #'adding - removing' }
CTOptimizedTrieNode >> splitOn: newKey oldKey: oldKey [ 
	
	| index newParent |
	
	newParent := self class new.
	newParent at: (oldKey allButFirst: newKey size) put: self.
	
	index := 1.
	
	^ newParent
]

{ #category : #iterating }
CTOptimizedTrieNode >> withAllChildrenDo: aBlock [ 

	aBlock cull: self.
	self children do: [ :aChild | aChild withAllChildrenDo: aBlock ]
]
