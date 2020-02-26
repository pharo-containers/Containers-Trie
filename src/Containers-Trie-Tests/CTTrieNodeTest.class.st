Class {
	#name : #CTTrieNodeTest,
	#superclass : #AbstractCTTrieTest,
	#category : #'Containers-Trie-Tests'
}

{ #category : #'tests - nodes' }
CTTrieNodeTest >> testIsLeaf [
	| aTrie aWord aLongerWord aNode |
	aTrie := self newInstance.
	self deny: aTrie rootNode isLeaf.

	"Just add a node with a private method"
	aNode := aTrie rootNode addChildWithLetter: $r.
	self deny: aNode isLeaf.
	aTrie at: 'rush' put: 2112.
	aWord := aTrie find: 'rush'.
	self assert: aWord isLeaf.
	self deny: aTrie rootNode isLeaf.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie at: 'rushed' put: 1.
	aWord := aTrie find: 'rush'.
	self deny: aWord isLeaf.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isLeaf
]

{ #category : #'tests - nodes' }
CTTrieNodeTest >> testIsLeafWikipediaExample [

	self assert: (trie find: 'to') isLeaf.
	self assert: (trie find: 'tea') isLeaf.
	self assert: (trie find: 'ted') isLeaf.
	self assert: (trie find: 'ten') isLeaf.
	self assert: (trie find: 'a') isLeaf.
	self deny: (trie find: 'i') isLeaf.
	self assert: (trie find: 'inn') isLeaf.
	self deny: (trie find: 'in') isLeaf.
	
	self assert: (trie isCompressed)
]

{ #category : #'tests - nodes' }
CTTrieNodeTest >> testIsNode [
	| aTrie aWord aLongerWord aNode |
	aTrie := self newInstance.
	self deny: aTrie rootNode isNode.

	"Just add a node with a private method"
	aNode := aTrie rootNode addChildWithLetter: $r.
	self assert: aNode isNode.
	aTrie at: 'rush' put: 2112.
	aWord := aTrie find: 'rush'.
	self assert: aWord isNode.
	self deny: aTrie rootNode isNode.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie at: 'rushed' put: 1.
	aWord := aTrie find: 'rush'.
	self assert: aWord isNode.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isNode.

	"now, back to our wikipedia example"
	self assert: (trie find: 'to') isNode.
	self assert: (trie find: 'tea') isNode.
	self assert: (trie find: 'ted') isNode.
	self assert: (trie find: 'ten') isNode.
	self assert: (trie find: 'a') isNode.
	self assert: (trie find: 'i') isNode.
	self assert: (trie find: 'inn') isNode.
	self assert: (trie find: 'in') isNode.
	self deny: trie rootNode isNode
]

{ #category : #'tests - nodes' }
CTTrieNodeTest >> testIsNotCompressed [

	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 1.
	aTrie at: 'three' put: 1.
	aTrie at: 'four' put: 1.

	(aTrie find: 'three') nodeValue: nil.
		
	self deny: aTrie isCompressed
]

{ #category : #'tests - nodes' }
CTTrieNodeTest >> testIsRoot [
	| aTrie aWord aLongerWord aNode |
	aTrie := self newInstance.
	self assert: aTrie rootNode isRoot.

	"Just add a node with a private method"
	aNode := aTrie rootNode addChildWithLetter: $r.
	self deny: aNode isRoot.
	aTrie at: 'rush' put: 2112.
	aWord := aTrie find: 'rush'.
	self deny: aWord isRoot.
	self assert: aTrie rootNode isRoot.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie at: 'rushed' put: 1.
	aWord := aTrie find: 'rush'.
	self deny: aWord isRoot.
	aLongerWord := aTrie find: 'rushed'.
	self deny: aLongerWord isRoot.

	"now, back to our wikipedia example"
	self deny: (trie find: 'to') isRoot.
	self deny: (trie find: 'tea') isRoot.
	self deny: (trie find: 'ted') isRoot.
	self deny: (trie find: 'ten') isRoot.
	self deny: (trie find: 'a') isRoot.
	self deny: (trie find: 'i') isRoot.
	self deny: (trie find: 'inn') isRoot.
	self deny: (trie find: 'in') isRoot.
	self assert: trie rootNode isRoot
]

{ #category : #'tests - nodes' }
CTTrieNodeTest >> testIsWord [
	| aTrie aWord aLongerWord aNode |
	aTrie := self newInstance.
	self deny: aTrie rootNode isWord.

	"Just add a node with a private method"
	aNode := aTrie rootNode addChildWithLetter: $r.
	self deny: aNode isWord.
	aTrie at: 'rush' put: 2112.
	aWord := aTrie find: 'rush'.
	self assert: aWord isWord.
	self deny: aTrie rootNode isWord.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie at: 'rushed' put: 1.
	aWord := aTrie find: 'rush'.
	self assert: aWord isWord.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isWord
]

{ #category : #'tests - nodes' }
CTTrieNodeTest >> testIsWordWikipediaExample [

	self assert: (trie find: 'to') isWord.
	self assert: (trie find: 'tea') isWord.
	self assert: (trie find: 'ted') isWord.
	self assert: (trie find: 'ten') isWord.
	self assert: (trie find: 'a') isWord.
	self assert: (trie find: 'i') isWord.
	self assert: (trie find: 'inn') isWord.
	self assert: (trie find: 'in') isWord
]
