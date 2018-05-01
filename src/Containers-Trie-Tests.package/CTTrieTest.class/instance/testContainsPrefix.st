tests - testing
testContainsPrefix

	self deny: (trie containsPrefix: 'z').
	self assert: (trie containsPrefix: 't').
	self assert: (trie containsPrefix: 'to').
	self deny: (trie containsPrefix: 'toz').
	self assert: (trie containsPrefix: 'te').
	self assert: (trie containsPrefix: 'tea').
	self assert: (trie containsPrefix: 'ted').
	self assert: (trie containsPrefix: 'ten').
	self deny: (trie containsPrefix: 'tez').
	self deny: (trie containsPrefix: 'teaz').
	self deny: (trie containsPrefix: 'tedz').
	self deny: (trie containsPrefix: 'tenz').
	self assert: (trie containsPrefix: 'a').
	self deny: (trie containsPrefix: 'az').
	self assert: (trie containsPrefix: 'i').
	self assert: (trie containsPrefix: 'in').
	self assert: (trie containsPrefix: 'inn').
	self deny: (trie containsPrefix: 'iz').
	self deny: (trie containsPrefix: 'inz').
	self deny: (trie containsPrefix: 'innz')