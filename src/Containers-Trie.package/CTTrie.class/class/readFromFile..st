instance creation - bulk
readFromFile: filename
	"A utility method that allows to bulk load a file containing one word per line and add them all to a trie structure"

	| aTrie aFile |
	
	aTrie := self new.
	aFile := StandardFileStream readOnlyFileNamed: filename.
	aFile enableReadBuffering.
	[aFile atEnd]
		whileFalse: [| aWord |
					aWord := aFile nextLine.
					aTrie add: aWord value: aWord size].
	aFile close.
	^aTrie 

	
	