tests - testing
testIsRoot
	| aTrie aWord aLongerWord aNode |
	
	aTrie := CTTrie new.
	self assert: aTrie isRoot.
	
	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self deny: aNode isRoot.	
	
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	
	self deny: aWord isRoot.
	self assert: aTrie isRoot.
	
	"Add a longer word with rush as prefix so rush is no longer a leaf"	
	aTrie add: 'rushed' value: 1.

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
	self assert: trie isRoot


	
	
	