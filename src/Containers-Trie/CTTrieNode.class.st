"
I implement the node of a CTTrie.
I have a character and a set of children. 
Also I can have a value if I am complete word, if I am a prefix, I have nil as value.
Use ifLeaf, isNode, isRoot, and isWord to test my condition.

Users should not use objects of this class directly, they should use CTTrie.
"
Class {
	#name : #CTTrieNode,
	#superclass : #CTAbstractTrieNode,
	#instVars : [
		'character'
	],
	#category : #'Containers-Trie'
}

{ #category : #private }
CTTrieNode class >> newWithCharacter: aCharacter [
	^ self basicNew
		initialize;
		character: aCharacter
]

{ #category : #private }
CTTrieNode >> addChildWithLetter: aCharacter [
	| newTrie |
	
	newTrie := self class newWithCharacter: aCharacter.
	self children 
		at: aCharacter 
		put: newTrie.
	^newTrie
]

{ #category : #accessing }
CTTrieNode >> character [
	^ character
]

{ #category : #accessing }
CTTrieNode >> character: aCharacter [
	character := aCharacter
]

{ #category : #private }
CTTrieNode >> findChildWithString: aString [

	^self children at: aString ifAbsent: [nil]
]

{ #category : #initialization }
CTTrieNode >> initialize [
	super initialize.
	children := IdentityDictionary new.

]

{ #category : #testing }
CTTrieNode >> isNode [

	^self isRoot not
]

{ #category : #testing }
CTTrieNode >> isRoot [

	^self character isNil
]

{ #category : #printing }
CTTrieNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		cr;
		nextPutAll: 'character : ';
		print: self character;
		cr;
		nextPutAll: 'children : ';
		print: self children keys asSortedCollection;
		cr;
		nextPutAll: 'value : ';
		print: self nodeValue;
		cr;
		nextPutAll: 'leaf : ';
		print: self isLeaf.		
]

{ #category : #private }
CTTrieNode >> removeNode: aNode [ 
	
	children removeKey: (children keyAtValue: aNode)
]

{ #category : #private }
CTTrieNode >> withAllChildrenDo: aBlock [ 

	aBlock cull: self.
	self children do: [ :aChild | aChild withAllChildrenDo: aBlock ]
]
