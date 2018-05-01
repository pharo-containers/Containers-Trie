adding
add: aString valueWithBlock: aValueBlock
	"Add the word <aString> into the Trie structure and set its value by evaluating <aValueBlock> with <aString> as parameter.
	
	(Trie new) add: 'abc' valueWithBlock: [:string | string size]
	"

	| currentNode |
	currentNode := self.
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithLetter: each.
			currentNode := child notNil
				ifTrue: [ child ]
				ifFalse: [ currentNode addChildWithLetter: each ] ].
	currentNode nodeValue: (aValueBlock value: aString)