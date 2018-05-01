tests - testing
testContains
	| aTrie |
	aTrie := CTTrie new.
	self deny: (aTrie contains: 'z').

	"now, back to our wikipedia example"
	self deny: (trie contains: 'z').
	self deny: (trie contains: 't').
	self assert: (trie contains: 'to').
	self deny: (trie contains: 'toz').
	self deny: (trie contains: 'te').
	self assert: (trie contains: 'tea').
	self assert: (trie contains: 'ted').
	self assert: (trie contains: 'ten').
	self deny: (trie contains: 'tez').
	self deny: (trie contains: 'teaz').
	self deny: (trie contains: 'tedz').
	self deny: (trie contains: 'tenz').
	self assert: (trie contains: 'a').
	self deny: (trie contains: 'az').
	self assert: (trie contains: 'i').
	self assert: (trie contains: 'in').
	self assert: (trie contains: 'inn').
	self deny: (trie contains: 'iz').
	self deny: (trie contains: 'inz').
	self deny: (trie contains: 'innz')