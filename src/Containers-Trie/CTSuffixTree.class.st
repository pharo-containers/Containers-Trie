"
I implement a Suffix tree using an Optimized Trie as a backend. 
I am excellent to perform full text search on substrings of the stored strings.

https://en.wikipedia.org/wiki/Suffix_tree

To access me you can use the messages defined in CTTrieOperations.

And also: 

- atSuffixesOf:put: to set the same value to all the suffixes of a given word.
- atSuffixesOf:update:initial to set or update the same value to all the suffixes of a given word.
- removeSuffixesOf: to remove all the suffixes of a given word
"
Class {
	#name : #CTSuffixTree,
	#superclass : #Object,
	#traits : 'CTTrieOperations',
	#classTraits : 'CTTrieOperations classTrait',
	#instVars : [
		'trie'
	],
	#category : #'Containers-Trie'
}

{ #category : #accessing }
CTSuffixTree >> at: aString update: updateBlock initial: initBlocktOrValue [
	
	^ trie at: aString update: updateBlock initial: initBlocktOrValue
]

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

{ #category : #'private - accessing' }
CTSuffixTree >> findPrefix: aString [

	^ trie findPrefix: aString
]

{ #category : #initialization }
CTSuffixTree >> initialize [

	super initialize.
	trie := CTOptimizedTrie new
]

{ #category : #removing }
CTSuffixTree >> removeKey: aString ifAbsent: anAbsentBlock [

	^ trie removeKey: aString ifAbsent: anAbsentBlock
]

{ #category : #accessing }
CTSuffixTree >> removeSuffixesOf: aString [ 

	aString suffixes do: [:aSuffix | self removeKey: aSuffix ].
	

]
