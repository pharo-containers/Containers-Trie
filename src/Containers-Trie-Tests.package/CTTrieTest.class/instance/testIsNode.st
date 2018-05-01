tests - testing
testIsNode
	| aTrie aWord aLongerWord aNode |
	
	aTrie := CTTrie new.
	self deny: aTrie isNode.
	
	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self assert: aNode isNode.	
	
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	
	self assert: aWord isNode.
	self deny: aTrie isNode.
	
	"Add a longer word with rush as prefix so rush is no longer a leaf"	
	aTrie add: 'rushed' value: 1.

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
	self deny: trie isNode


	
	
	