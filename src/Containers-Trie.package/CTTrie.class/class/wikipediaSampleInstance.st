example instances
wikipediaSampleInstance
	<sampleInstance>
	"example taken from  <http://en.wikipedia.org/wiki/Trie>"
	| trie |
	trie := CTTrie new.
	"insert short words then long words"
	trie add: 'to' value: 7.
	trie add: 'tea' value: 3.
	trie add: 'ted' value: 4.
	trie add: 'ten' value: 12.

	"orphan word"
	trie add: 'a' value: 15.

	"insert longer word, then shorter, then in between"
	trie add: 'inn' value: 9.
	trie add: 'i' value: 11.
	trie add: 'in' value: 9.
	^ trie