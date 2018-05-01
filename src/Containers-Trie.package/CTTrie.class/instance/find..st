private
find: aString 
	"Answers a <Trie> if the word <aString> is found in the receiver, <nil> otherwise"
	|  currentNode |
	
	currentNode := self.
	aString do: [:each | 	| child  |
			
							child := currentNode findChildWithLetter: each.
							child notNil
								ifTrue: [currentNode := child ]
								ifFalse: [^nil]
							 ].
	^currentNode isWord
		ifTrue: [currentNode]
		ifFalse: [nil]

	

	

	