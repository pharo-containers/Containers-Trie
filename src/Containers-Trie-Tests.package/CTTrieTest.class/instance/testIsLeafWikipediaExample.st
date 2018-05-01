tests - testing
testIsLeafWikipediaExample

	self assert: (trie find: 'to') isLeaf.
	self assert: (trie find: 'tea') isLeaf.
	self assert: (trie find: 'ted') isLeaf.
	self assert: (trie find: 'ten') isLeaf.
	self assert: (trie find: 'a') isLeaf.
	self deny: (trie find: 'i') isLeaf.
	self assert: (trie find: 'inn') isLeaf.
	self deny: (trie find: 'in') isLeaf