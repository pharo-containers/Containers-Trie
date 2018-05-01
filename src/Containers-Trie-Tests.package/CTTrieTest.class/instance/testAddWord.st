testing
testAddWord
	| unTrie |
	unTrie := CTTrie new.
	unTrie add: 'bon' value: 3.
	self assert: (unTrie contains: 'bon').
	self assert: (unTrie find: 'bon') notNil.
	self assert: (unTrie find: 'bon') nodeValue = 3