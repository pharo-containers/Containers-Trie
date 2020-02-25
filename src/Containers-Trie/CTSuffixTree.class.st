Class {
	#name : #CTSuffixTree,
	#superclass : #CTTrie,
	#category : #'Containers-Trie'
}

{ #category : #accessing }
CTSuffixTree >> atSuffixesOf: aString put: aValue [.

	aString suffixes do: [:aSuffix | self at: aSuffix put: aValue ].
	
	^ aValue
]

{ #category : #accessing }
CTSuffixTree >> atSuffixesOf: aString update: updateBlock initial: initBlocktOrValue [
	
	aString suffixes do: [:aSuffix | 
		aSuffix size > 2 ifTrue: [self at: aSuffix update: updateBlock initial: initBlocktOrValue ]].

]
