tests - testing
testAnEmptyTrieDoesNotContainPrefix

	self deny: (CTTrie new containsPrefix: 'z').

	