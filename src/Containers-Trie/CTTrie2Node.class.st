Class {
	#name : #CTTrie2Node,
	#superclass : #Object,
	#instVars : [
		'character',
		'children',
		'nodeValue'
	],
	#category : #'Containers-Trie'
}

{ #category : #private }
CTTrie2Node class >> newWithCharacter: aCharacter [
	^ self basicNew
		initialize;
		character: aCharacter
]

{ #category : #private }
CTTrie2Node >> addChildWithLetter: aCharacter [
	| newTrie |
	
	newTrie := self class newWithCharacter: aCharacter.
	self children 
		at: aCharacter 
		put: newTrie.
	^newTrie
]

{ #category : #accessing }
CTTrie2Node >> character [
	^ character
]

{ #category : #accessing }
CTTrie2Node >> character: anObject [
	character := anObject
]

{ #category : #accessing }
CTTrie2Node >> children [
	^ children
]

{ #category : #accessing }
CTTrie2Node >> children: anObject [
	children := anObject
]

{ #category : #private }
CTTrie2Node >> findChildWithLetter: aCharacter [

	^self children at: aCharacter ifAbsent: [nil]
]

{ #category : #accessing }
CTTrie2Node >> initialize [

	super initialize.
	children := IdentityDictionary new.
]

{ #category : #testing }
CTTrie2Node >> isLeaf [

	^self isWord and: [self children isEmpty]
]

{ #category : #testing }
CTTrie2Node >> isNode [

	^self isRoot not
]

{ #category : #testing }
CTTrie2Node >> isRoot [

	^self character isNil
]

{ #category : #testing }
CTTrie2Node >> isWord [

	^self nodeValue notNil
]

{ #category : #accessing }
CTTrie2Node >> nodeValue [
	^ nodeValue
]

{ #category : #accessing }
CTTrie2Node >> nodeValue: anObject [
	nodeValue := anObject
]
