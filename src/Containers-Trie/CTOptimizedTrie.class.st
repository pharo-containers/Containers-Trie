"
I am an optimized version of the trie. 
I create nodes for a given string only if this is splitted in two.

Normal trie for aWord -> v1, aTord -> v2 and aTerd -> v3
========================================================

(a) -> (W) -> (o) -> (r) -> (d)-->v1
  \
   \-> (T) -> (o) -> (r) -> (d)-->v2
			\
          \-> (e) -> (r) -> (d)-->v3



Optimized trie for aWord -> v1 and aTord -> v2
===========================================

(a) -> (Word) -->v1
  \
   \-> (T) -> (ord)-->v2
        \
         \ -> (erd)-->v3


"
Class {
	#name : #CTOptimizedTrie,
	#superclass : #CTTrie,
	#category : #'Containers-Trie'
}

{ #category : #accessing }
CTOptimizedTrie >> at: aString update: updateBlock initial: initBlocktOrValue [
	"I am used to update the value at a given key. The updateBlock is passed 
	the existing value, and the result of the block is stored back.
	If the key does not exist, store the value of the initBlocktOrValue.
	initBlocktOrValue can be a block in case the initial value is expencive to compute."

	| currentNode ancestors |
	currentNode := root.
	ancestors := OrderedCollection new.
	
	currentNode := root findChildWithString: aString storingAncestors: ancestors adding: true.
	
	[currentNode nodeValue: (currentNode nodeValue 
		ifNil: [ initBlocktOrValue value ]
		ifNotNil: [ :previousValue | updateBlock cull: previousValue])] ensure: [ 
				self compressNode: currentNode	ancestors: ancestors].		
		
]

{ #category : #'private - accessing' }
CTOptimizedTrie >> findPrefix: aString [

	^ root findChildWithString: aString

]

{ #category : #initialization }
CTOptimizedTrie >> nodeSpecies [
	
	^ CTOptimizedTrieNode 
]

{ #category : #removing }
CTOptimizedTrie >> removeKey: aString ifAbsent: anAbsentBlock [
	| currentNode oldValue ancestors |

	ancestors := OrderedCollection new.
	currentNode := root findChildWithString: aString storingAncestors: ancestors adding: false.
	
	currentNode ifNil: [ ^ anAbsentBlock value ].
	currentNode isWord ifFalse: [ ^ anAbsentBlock value ].

	^ [	oldValue := currentNode nodeValue.
	  	currentNode nodeValue: nil. 
		oldValue] ensure: [ self compressNode: currentNode ancestors: ancestors ]

]
