"
I implement the node of a CTTrie.
I have a character and a set of children. 
Also I can have a value if I am complete word, if I am a prefix, I have nil as value.
Use ifLeaf, isNode, isRoot, and isWord to test my condition.

Users should not use objects of this class directly, they should use CTTrie.
"
Class {
	#name : #CTTrieNode,
	#superclass : #Object,
	#instVars : [
		'character',
		'children',
		'nodeValue'
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

{ #category : #accessing }
CTTrieNode >> children [
	^ children
]

{ #category : #accessing }
CTTrieNode >> children: anIdentityDictionary [
	children := anIdentityDictionary
]

{ #category : #private }
CTTrieNode >> findChildWithLetter: aCharacter [

	^self children at: aCharacter ifAbsent: [nil]
]

{ #category : #initialization }
CTTrieNode >> initialize [
	super initialize.
	children := IdentityDictionary new.

]

{ #category : #testing }
CTTrieNode >> isCompressed [

	^ children
		ifEmpty: [ self isWord ]
		ifNotEmpty: [ children allSatisfy: [ :aChild | aChild isCompressed ] ]
]

{ #category : #testing }
CTTrieNode >> isLeaf [

	^self isWord and: [self children isEmpty]
]

{ #category : #testing }
CTTrieNode >> isNode [

	^self isRoot not
]

{ #category : #testing }
CTTrieNode >> isRoot [

	^self character isNil
]

{ #category : #testing }
CTTrieNode >> isWord [

	^self nodeValue notNil
]

{ #category : #accessing }
CTTrieNode >> nodeValue [
	^ nodeValue
]

{ #category : #accessing }
CTTrieNode >> nodeValue: anObject [
	nodeValue := anObject
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
		print: self isLeaf;
		cr;
		nextPutAll: 'isCompressed : ';
		print: self isCompressed.		
]

{ #category : #accessing }
CTTrieNode >> withAllChildrenDo: aBlock [ 

	aBlock cull: self.
	children do: [ :aChild | aChild withAllChildrenDo: aBlock ]
]
