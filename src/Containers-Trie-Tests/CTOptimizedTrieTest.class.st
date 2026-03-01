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
    
    self assert: (trie at: 'car') equals: 1.
    
    rootNode := trie instVarNamed: 'root'.
    
    self assert: rootNode children first children isEmpty.
]

{ #category : 'tests' }
CTOptimizedTrieTest >> testOptimizedTrieDoesNotMergeWhenParentIsWord [
	| trie rootNode parentNode |
	trie := CTOptimizedTrie new.
	
	trie at: 'ca' put: 1.
	trie at: 'cat' put: 2.
	trie at: 'car' put: 3.
	
	trie removeKey: 'cat'.
	
	self assert: (trie at: 'ca') equals: 1.
	self assert: (trie at: 'car') equals: 3.
	
	rootNode := trie instVarNamed: 'root'.
	parentNode := rootNode children first. 
	
	self assert: parentNode isWord.
	self assert: parentNode nodeValue equals: 1.
	self assert: parentNode keys size equals: 1.
]

{ #category : 'tests' }
CTOptimizedTrieTest >> testOptimizedTrieDoesNotMergeWithMultipleChildren [
	| trie rootNode parentNode |
	trie := CTOptimizedTrie new.
	
	trie at: 'cat' put: 1.
	trie at: 'car' put: 2.
	trie at: 'cab' put: 3.
	
	trie removeKey: 'cat'.
	
	self assert: (trie at: 'car') equals: 2.
	self assert: (trie at: 'cab') equals: 3.
	
	rootNode := trie instVarNamed: 'root'.
	parentNode := rootNode children first.
	
	self assert: parentNode isWord not.
	self assert: parentNode keys size equals: 2.
]
