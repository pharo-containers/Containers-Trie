private
findChildWithLetter: aCharacter

	^self children at: aCharacter ifAbsent: [nil]