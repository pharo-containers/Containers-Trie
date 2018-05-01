tests - testing
testIsLeaf
	| aTrie aWord aLongerWord aNode |
	aTrie := CTTrie new.
	self deny: aTrie isLeaf.

	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self deny: aNode isLeaf.
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	self assert: aWord isLeaf.
	self deny: aTrie isLeaf.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie add: 'rushed' value: 1.
	aWord := aTrie find: 'rush'.
	self deny: aWord isLeaf.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isLeaf.

	