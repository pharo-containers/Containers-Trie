testing
containsPrefix: aString
	"Answer a <Boolean> telling if the receiver contains  <aString> (either as a prefix or complete word)"

	| currentNode |
	currentNode := self.
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithLetter: each.
			child notNil
				ifTrue: [ currentNode := child ]
				ifFalse: [ ^ false ] ].
	^ true 