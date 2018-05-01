tests - testing
testIsWord
	| aTrie aWord aLongerWord aNode |
	aTrie := CTTrie new.
	self deny: aTrie isWord.

	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self deny: aNode isWord.
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	self assert: aWord isWord.
	self deny: aTrie isWord.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie add: 'rushed' value: 1.
	aWord := aTrie find: 'rush'.
	self assert: aWord isWord.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isWord.

	