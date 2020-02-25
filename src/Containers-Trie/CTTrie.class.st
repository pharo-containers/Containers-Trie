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

{ #category : #adding }
CTTrie >> add: aString valueWithBlock: aValueBlock [
	"Add the word <aString> into the Trie structure and set its value by evaluating <aValueBlock> with one parameter.
	
	<aString> as first parameter.
	
	(CTTrie new) add: 'abc' valueWithBlock: [:string | string size]. 
	"

	| currentNode |
	currentNode := root.
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithLetter: each.
			currentNode := child notNil
				ifTrue: [ child ]
				ifFalse: [ currentNode addChildWithLetter: each ] ].
	currentNode nodeValue: (aValueBlock value: aString )
]

{ #category : #querying }
CTTrie >> allValues [

	^ OrderedCollection streamContents: [ :s | self withAllValuesDo: [ :aValue | s nextPut: aValue ] ]
]

{ #category : #querying }
CTTrie >> allValuesBeginningWith: aPrefix [

	^ OrderedCollection streamContents: [ :s | self withAllValuesBeginningWith: aPrefix do: [ :aValue | s nextPut: aValue ] ]
]

{ #category : #accessing }
CTTrie >> at: key [ 
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [self errorKeyNotFound: key]
]

{ #category : #accessing }
CTTrie >> at: aString ifAbsent: aBlock [ 
	"Answer the value associated with the aString or, if aString isn't found,
	answer the result of evaluating aBlock."

	^ (self find: aString) ifNil: aBlock ifNotNil: [ :aNode | aNode nodeValue ]
]

{ #category : #accessing }
CTTrie >> at: aString put: anObject [
	"Add the word aString into the Trie structure and set its value to anObject.
	If the key exists it replaces the value.
	Answers anObject"
	
	self at: aString update: [ anObject ] initial: anObject.
	^ anObject
	
]

{ #category : #accessing }
CTTrie >> at: key update: updateBlock [ 
	"I am used to update the value at a given key, or if the key does not exist, to throw an error"

	self at: key update: updateBlock initial: [ self errorKeyNotFound: key ].
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
			child := currentNode findChildWithLetter: each.
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
			aParent children removeKey: aNode character.
			aNode := aParent ]
]

{ #category : #testing }
CTTrie >> contains: aString [
	"Answer a <Boolean> telling if the receiver contains the *word* <aString>"

	^(self find: aString) isNotNil
	

	

	
]

{ #category : #testing }
CTTrie >> containsPrefix: aString [
	"Answer a <Boolean> telling if the receiver contains  <aString> (either as a prefix or complete word)"

	^ (self findPrefix: aString) isNotNil
]

{ #category : #private }
CTTrie >> errorKeyNotFound: key [

	^ KeyNotFound signalFor: key
]

{ #category : #'private - accessing' }
CTTrie >> find: aString [ 
	"Answers a <CTTrieNode> if the word <aString> is found in the receiver, <nil> otherwise"
	
	| node |
	node := self findPrefix: aString.

	^ (node isNotNil and: [node isWord])
		ifTrue: [node]
		ifFalse: [nil]

	

	

	
]

{ #category : #'private - accessing' }
CTTrie >> findPrefix: aString [ 
	"Answers a <CTTrie> if the prefix <aString> is found in the receiver, <nil> otherwise"
	|  currentNode |
	
	currentNode := root.
	aString do: [:each | 	| child  |
			
							child := currentNode findChildWithLetter: each.
							child notNil
								ifTrue: [currentNode := child ]
								ifFalse: [^nil]
							 ].
	^ currentNode
]

{ #category : #inspecting }
CTTrie >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>

	^ composite tree 
		title: 'Nodes';
		rootsExpanded;
		display: [ :each | {root} ];
		children: [ :each | each children ]
]

{ #category : #initialization }
CTTrie >> initialize [

	super initialize.
	root := CTTrieNode new
]

{ #category : #'private - testing' }
CTTrie >> isCompressed [

	^ root children allSatisfy: [ :aChild | aChild isCompressed ]

]

{ #category : #printing }
CTTrie >> printOn: aStream [

	super printOn: aStream.
	aStream print: root.

]

{ #category : #removing }
CTTrie >> removeKey: aString [

	^ self removeKey: aString ifAbsent: [ self errorKeyNotFound: aString ]
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
				child := currentNode findChildWithLetter: each.
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

{ #category : #querying }
CTTrie >> withAllValuesBeginningWith: aPrefix do: aBlock [
	
	| node |
	node := self findPrefix: aPrefix.
	node ifNil: [ ^ self ].
	
	node withAllChildrenDo: [ :aNode | aNode isWord ifTrue: [ aBlock cull: aNode nodeValue ] ]
]

{ #category : #querying }
CTTrie >> withAllValuesDo: aBlock [ 

	"It iterates all the values and evaluates aBlock on each of the values"

	root withAllChildrenDo: [:aNode | 
		aNode isWord ifTrue: [ aBlock cull: aNode nodeValue ]]
]
