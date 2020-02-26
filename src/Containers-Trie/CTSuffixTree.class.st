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
