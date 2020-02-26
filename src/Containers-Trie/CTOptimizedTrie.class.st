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

{ #category : #initialization }
CTOptimizedTrie >> occupationRate [

	| intermedios todos |
	intermedios := 0.
	todos := 0.

	self rootNode
		withAllChildrenDo: [ :aNode | 
			todos := todos + 1.
			(aNode children size = 1 and: [ aNode isWord not ])
				ifTrue: [ intermedios := intermedios + 1 ] ].

	^ ((todos - intermedios) / todos) asFloat
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
