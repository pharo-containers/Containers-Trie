"
A tree for storing strings in which there is one node for every common prefix. The strings (words) are *usually* stored in extra leaf nodes.  The root of a Trie can be recognized by the fact that its character instance variable is <nil>.  Words can be determined by the fact that the node completing the word has a nodeValue.  Note that a word does not have to be found at a leaf node (e.g. the word ""in"", see Wipidedia example at link given below).

See <http://en.wikipedia.org/wiki/Trie> for more details.  

Instance Variables: 	
	root  A CTTrieNode instance that is the root node of the tree.
					
Based in the original work of Benoit St-Jean <bstjean@yahoo.com>
MIT license


"
Class {
	#name : #CTTrie,
	#superclass : #Object,
	#traits : 'CTTrieOperations',
	#classTraits : 'CTTrieOperations classTrait',
	#instVars : [
		'root'
	],
	#category : #'Containers-Trie'
}

{ #category : #'instance creation - bulk' }
CTTrie class >> readFromFile: anObject [
	^ self readFromFile: anObject withLineTransformer: [ :str | str ]
]

{ #category : #'instance creation - bulk' }
CTTrie class >> readFromFile: anObject withLineTransformer: aBlock [
	"A utility method that allows to bulk load a file containing one word per line and add them all to a trie structure.
	 aBlock allows one to convert the line before inserting it in the trie (for example one can convert it as lowercase)."

	| aTrie fileReference |
	
	aTrie := self new.
	fileReference := anObject asFileReference.
	fileReference readStreamDo: [ :stream |
		|lineReader|
		lineReader := ZnFastLineReader on: stream.
		[ lineReader atEnd ]
			whileFalse: [ 
				|word|
				word := aBlock value: lineReader nextLine.
				aTrie add: word value: word size ] ].
	^ aTrie

	
	
]

{ #category : #'example instances' }
CTTrie class >> wikipediaSampleInstance [
	"example taken from  <http://en.wikipedia.org/wiki/Trie>"

	<sampleInstance>
	| trie |
	trie := self new.
	"insert short words then long words"
	trie at: 'to' put: 7.
	trie at: 'tea' put: 3.
	trie at: 'ted' put: 4.
	trie at: 'ten' put: 12.

	"orphan word"
	trie at: 'a' put: 15.

	"insert longer word, then shorter, then in between"
	trie at: 'inn' put: 9.
	trie at: 'i' put: 11.
	trie at: 'in' put: 9.
	^ trie
]

{ #category : #adding }
CTTrie >> add: aString value: anObject [

	self
		deprecated: 'Please use #at:put: instead'
		transformWith: '`@receiver add: `@statements1 value: `@statements2' 
						-> '`@receiver at: `@statements1 put: `@statements2'.
						
	^ self at: aString put: anObject	
]

{ #category : #accessing }
CTTrie >> at: aString update: updateBlock initial: initBlocktOrValue [
	"I am used to update the value at a given key. The updateBlock is passed 
	the existing value, and the result of the block is stored back.
	If the key does not exist, store the value of the initBlocktOrValue.
	initBlocktOrValue can be a block in case the initial value is expencive to compute."

	| currentNode ancestors |
	currentNode := root.
	ancestors := OrderedCollection new.
	
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithString: each.
			ancestors add: currentNode.
			currentNode := child notNil
				ifTrue: [ child ]
				ifFalse: [ currentNode addChildWithLetter: each ] ].
	
	[currentNode nodeValue: (currentNode nodeValue 
		ifNil: [ initBlocktOrValue value ]
		ifNotNil: [ :previousValue | updateBlock cull: previousValue])] ensure: [ 
				self compressNode: currentNode	ancestors: ancestors].		
		
]

{ #category : #private }
CTTrie >> compressNode: currentNode ancestors: ancestors [

	| aNode |
	aNode := currentNode.
	ancestors reverse
		do: [ :aParent | 
			"If the node has a nil value, maybe I need to remove it and its ancestors. 
				If it is different than nil, I have nothing to do"
			aNode nodeValue isNil
				ifFalse: [ ^ self ].
			"If the node has children, that is good. We do not remove it"
			aNode children ifNotEmpty: [ ^ self ].
			aParent removeNode: aNode.
			aNode := aParent ]
]

{ #category : #'private - accessing' }
CTTrie >> findPrefix: aString [
	"Answers a <CTTrie> if the prefix <aString> is found in the receiver, <nil> otherwise"

	| currentNode |
	currentNode := root.
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithString: each.
			child notNil
				ifTrue: [ currentNode := child ]
				ifFalse: [ ^ nil ] ].

	^ currentNode
]

{ #category : #inspecting }
CTTrie >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>

	^ composite tree 
		title: 'Nodes';
		rootsExpanded;
		display: [ :each | {#root -> root} ];
		children: [ :each | each value childrenDictionary associations ];
		format: [ :each | 'Character: ' , each key printString , ' Node: ', each value printString ]
]

{ #category : #initialization }
CTTrie >> initialize [

	super initialize.
	root := self nodeSpecies new
]

{ #category : #'private - testing' }
CTTrie >> isCompressed [

	^ root children allSatisfy: [ :aChild | aChild isCompressed ]

]

{ #category : #initialization }
CTTrie >> nodeSpecies [
	
	^ CTTrieNode
]

{ #category : #printing }
CTTrie >> printOn: aStream [

	super printOn: aStream.
	aStream print: root.

]

{ #category : #removing }
CTTrie >> removeKey: aString ifAbsent: anAbsentBlock [
	| currentNode oldValue ancestors |

	currentNode := root.
	ancestors := OrderedCollection new.
	oldValue := nil.

	[	aString
			do: [ :each | 
				| child |
				child := currentNode findChildWithString: each.
				child notNil
					ifTrue: [ ancestors add: currentNode. currentNode := child ]
					ifFalse: [ ^ anAbsentBlock value ] ].
		
		
		currentNode isWord ifFalse: [ ^ anAbsentBlock value ].
		
		oldValue := currentNode nodeValue.
		currentNode nodeValue: nil. 
				
		^ oldValue] ensure: [ self compressNode: currentNode ancestors: ancestors ]
]

{ #category : #'private - accessing' }
CTTrie >> rootNode [
	
	^ root
]
