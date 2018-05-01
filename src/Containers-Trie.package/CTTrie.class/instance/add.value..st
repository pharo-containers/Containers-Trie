adding
add: aString value: anObject
	"Add the word <aString> into the Trie structure and set its value to <anObject>"
	|  currentNode |
	
	currentNode := self.
	aString do: [:each | 	|  child  |
						child := currentNode findChildWithLetter: each.
						currentNode := child notNil
											ifTrue: [child ]
											ifFalse: [currentNode addChildWithLetter: each]
							 ].
	currentNode nodeValue: anObject.
	

	