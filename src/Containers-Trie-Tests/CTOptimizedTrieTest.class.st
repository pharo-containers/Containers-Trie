Class {
	#name : 'CTOptimizedTrieTest',
	#superclass : 'CTTrieTest',
	#category : 'Containers-Trie-Tests',
	#package : 'Containers-Trie-Tests'
}

{ #category : 'utils' }
CTOptimizedTrieTest >> classUnderTest [

	^ CTOptimizedTrie
]

{ #category : 'tests' }
CTOptimizedTrieTest >> testOptimizedTrieCompressesOnDeletion [
    | trie rootNode |
    trie := CTOptimizedTrie new.
    trie at: 'car' put: 1.
    trie at: 'cat' put: 2.
    
    trie removeKey: 'cat'.
    
    self assert: (trie at: 'car' ifAbsent: [ nil ]) equals: 1.
    self assert: (trie at: 'cat' ifAbsent: [ nil ]) isNil.
    
    rootNode := trie instVarNamed: 'root'.
    
    self assert: rootNode children first children isEmpty.
]
