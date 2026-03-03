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
CTOptimizedTrieTest >> testCompressNodeDoesNotMergeWhenAncestorsTooSmall [
    | rootNode nodeToCheck ancestors |
    trie := CTOptimizedTrie new.
    
    trie at: 'cat' put: 1.
    
    rootNode := trie instVarNamed: 'root'.
    nodeToCheck := rootNode children first. 

    ancestors := OrderedCollection new.
    ancestors add: nodeToCheck.
    
    trie compressNode: nodeToCheck ancestors: ancestors.
    
    self assert: rootNode keys size equals: 1.
    self assert: rootNode keys first equals: 'cat'.
    self assert: (trie at: 'cat') equals: 1.
]

{ #category : 'tests' }
CTOptimizedTrieTest >> testCompressNodeDoesNotMergeWhenHasValue [
    | rootNode nodeToCheck ancestors |
    trie := CTOptimizedTrie new.
    
    trie at: 'cat' put: 1.
    trie at: 'ca' put: 2.
    
    rootNode := trie instVarNamed: 'root'.
    nodeToCheck := rootNode children first. 
    
    ancestors := OrderedCollection new.
    ancestors add: rootNode.
    ancestors add: nodeToCheck.
    
    trie compressNode: nodeToCheck ancestors: ancestors.
    
    self assert: rootNode keys size equals: 1.
    self assert: rootNode keys first equals: 'ca'.
    self assert: (trie at: 'ca') equals: 2.
]

{ #category : 'tests' }
CTOptimizedTrieTest >> testCompressNodeDoesNotMergeWithMultipleChildren [
    | rootNode nodeToCheck ancestors |
    trie := CTOptimizedTrie new.
    
    trie at: 'cat' put: 1.
    trie at: 'car' put: 2.
    
    rootNode := trie instVarNamed: 'root'.
    nodeToCheck := rootNode children first. 
    
    nodeToCheck instVarNamed: 'nodeValue' put: nil.
    
    ancestors := OrderedCollection new.
    ancestors add: rootNode.
    ancestors add: nodeToCheck.
    
    trie compressNode: nodeToCheck ancestors: ancestors.
    
    self assert: rootNode keys size equals: 1.
    self assert: rootNode keys first equals: 'ca'.
    self assert: nodeToCheck keys size equals: 2.
    self assert: (nodeToCheck keys includesAll: #('t' 'r')).
    self assert: (trie at: 'cat') equals: 1.
    self assert: (trie at: 'car') equals: 2.
]

{ #category : 'tests' }
CTOptimizedTrieTest >> testCompressNodeMergesDeepSingleChild [
    | rootNode parentNode nodeToCheck ancestors |
    trie := CTOptimizedTrie new.
    
    trie at: 'a' put: 1.
    trie at: 'ab' put: 2.
    trie at: 'abc' put: 3.
    
    rootNode := trie instVarNamed: 'root'.
    parentNode := rootNode children first. 
    nodeToCheck := parentNode children first. 
    
    nodeToCheck instVarNamed: 'nodeValue' put: nil.
    
    ancestors := OrderedCollection new.
    ancestors add: rootNode.
    ancestors add: parentNode.
    ancestors add: nodeToCheck.
    
    trie compressNode: nodeToCheck ancestors: ancestors.
    
    self assert: parentNode keys size equals: 1.
    self assert: parentNode keys first equals: 'bc'.
    
    self assert: (trie at: 'abc') equals: 3.
    self assert: (trie at: 'a') equals: 1.
]

{ #category : 'tests' }
CTOptimizedTrieTest >> testCompressNodeMergesSingleChildWithoutValue [
    | rootNode nodeToCheck ancestors |
    trie := CTOptimizedTrie new.
    
    trie at: 'cat' put: 1.
    trie at: 'ca' put: 2.
    
    rootNode := trie instVarNamed: 'root'.
    nodeToCheck := rootNode children first. 
    
    nodeToCheck instVarNamed: 'nodeValue' put: nil.
    
    ancestors := OrderedCollection new.
    ancestors add: rootNode.
    ancestors add: nodeToCheck.
    
    trie compressNode: nodeToCheck ancestors: ancestors.
    
    self assert: rootNode keys size equals: 1.
    self assert: rootNode keys first equals: 'cat'.
    self assert: (trie at: 'cat') equals: 1.
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
