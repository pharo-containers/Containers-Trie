tests - testing
testIsWordWikipediaExample

	self assert: (trie find: 'to') isWord.
	self assert: (trie find: 'tea') isWord.
	self assert: (trie find: 'ted') isWord.
	self assert: (trie find: 'ten') isWord.
	self assert: (trie find: 'a') isWord.
	self assert: (trie find: 'i') isWord.
	self assert: (trie find: 'inn') isWord.
	self assert: (trie find: 'in') isWord