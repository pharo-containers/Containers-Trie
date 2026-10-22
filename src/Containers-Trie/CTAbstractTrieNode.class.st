"
I am an abstract node used to handle the common behavior and state of the Trie nodes.
I have a collection of children and a value.
"
Class {
	#name : 'CTAbstractTrieNode',
	#superclass : 'Object',
	#instVars : [
		'nodeValue',
		'children'
	],
	#category : 'Containers-Trie-Core',
	#package : 'Containers-Trie',
	#tag : 'Core'
}

{ #category : 'accessing' }
CTAbstractTrieNode >> children [
	^ children
]

{ #category : 'testing' }
CTAbstractTrieNode >> isCompressed [

	^ self children
		ifEmpty: [ self isWord ]
		ifNotEmpty: [ self children allSatisfy: [ :aChild | aChild isCompressed ] ]
]

{ #category : 'testing' }
CTAbstractTrieNode >> isLeaf [

	^self isWord and: [self children isEmpty]
]

{ #category : 'testing' }
CTAbstractTrieNode >> isWord [

	^self nodeValue notNil
]

{ #category : 'accessing' }
CTAbstractTrieNode >> nodeValue [
	^ nodeValue
]

{ #category : 'accessing' }
CTAbstractTrieNode >> nodeValue: anObject [
	nodeValue := anObject
]
