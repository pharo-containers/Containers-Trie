"
This Trait extracts the common behavior of a Trie. 
It requires the user to implement #at:update:initial to add/update elements, #findPrefix: to find in it and #removeKey:ifAbsent: to remove elements.
All the other operations are performed using them.
"
Trait {
	#name : #CTTrieOperations,
	#category : #'Containers-Trie'
}

{ #category : #adding }
CTTrieOperations >> add: aString valueWithBlock: aValueBlock [
	"Add the word <aString> into the Trie structure and set its value by evaluating <aValueBlock> with one parameter.
	
	<aString> as first parameter.
	
	(CTTrie new) add: 'abc' valueWithBlock: [:string | string size]. 
	"
	self at: aString put: (aValueBlock value: aString)
]

{ #category : #querying }
CTTrieOperations >> allValues [

	^ OrderedCollection streamContents: [ :s | self withAllValuesDo: [ :aValue | s nextPut: aValue ] ]
]

{ #category : #querying }
CTTrieOperations >> allValuesBeginningWith: aPrefix [

	^ OrderedCollection streamContents: [ :s | self withAllValuesBeginningWith: aPrefix do: [ :aValue | s nextPut: aValue ] ]
]

{ #category : #accessing }
CTTrieOperations >> at: key [ 
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [self errorKeyNotFound: key]
]

{ #category : #accessing }
CTTrieOperations >> at: aString ifAbsent: aBlock [ 
	"Answer the value associated with the aString or, if aString isn't found,
	answer the result of evaluating aBlock."

	^ (self find: aString) ifNil: aBlock ifNotNil: [ :aNode | aNode nodeValue ]
]

{ #category : #accessing }
CTTrieOperations >> at: aString put: anObject [
	"Add the word aString into the Trie structure and set its value to anObject.
	If the key exists it replaces the value.
	Answers anObject"
	
	self at: aString update: [ anObject ] initial: anObject.
	^ anObject
	
]

{ #category : #accessing }
CTTrieOperations >> at: key update: updateBlock [ 
	"I am used to update the value at a given key, or if the key does not exist, to throw an error"

	self at: key update: updateBlock initial: [ self errorKeyNotFound: key ].
]

{ #category : #accessing }
CTTrieOperations >> at: aString update: updateBlock initial: initBlocktOrValue [
	"I am used to update the value at a given key. The updateBlock is passed 
	the existing value, and the result of the block is stored back.
	If the key does not exist, store the value of the initBlocktOrValue.
	initBlocktOrValue can be a block in case the initial value is expencive to compute."

	self explicitRequirement
]

{ #category : #testing }
CTTrieOperations >> contains: aString [
	"Answer a <Boolean> telling if the receiver contains the *word* <aString>"

	^(self find: aString) isNotNil
	

	

	
]

{ #category : #testing }
CTTrieOperations >> containsPrefix: aString [
	"Answer a <Boolean> telling if the receiver contains  <aString> (either as a prefix or complete word)"

	^ (self findPrefix: aString) isNotNil
]

{ #category : #private }
CTTrieOperations >> errorKeyNotFound: key [

	^ KeyNotFound signalFor: key
]

{ #category : #'private - accessing' }
CTTrieOperations >> find: aString [ 
	"Answers a <CTTrieNode> if the word <aString> is found in the receiver, <nil> otherwise"
	
	| node |
	node := self findPrefix: aString.

	^ (node isNotNil and: [node isWord])
		ifTrue: [node]
		ifFalse: [nil]

	

	

	
]

{ #category : #'private - accessing' }
CTTrieOperations >> findPrefix: aString [

	self explicitRequirement
]

{ #category : #initialization }
CTTrieOperations >> occupationRate [

	| intermediateNodes nodes |
	intermediateNodes := 0.
	nodes := 0.

	self rootNode
		withAllChildrenDo: [ :aNode | 
			nodes := nodes + 1.
			(aNode children size = 1 and: [ aNode isWord not ])
				ifTrue: [ intermediateNodes := intermediateNodes + 1 ] ].

	^ ((nodes - intermediateNodes) / nodes) asFloat
]

{ #category : #removing }
CTTrieOperations >> removeKey: aString [

	^ self removeKey: aString ifAbsent: [ self errorKeyNotFound: aString ]
]

{ #category : #removing }
CTTrieOperations >> removeKey: aString ifAbsent: anAbsentBlock [

	self explicitRequirement
]

{ #category : #querying }
CTTrieOperations >> withAllValuesBeginningWith: aPrefix do: aBlock [
	
	| node |
	node := self findPrefix: aPrefix.
	node ifNil: [ ^ self ].
	
	node withAllChildrenDo: [ :aNode | aNode isWord ifTrue: [ aBlock cull: aNode nodeValue ] ]
]

{ #category : #querying }
CTTrieOperations >> withAllValuesDo: aBlock [ 

	"It iterates all the values and evaluates aBlock on each of the values"
	| node |

	node := self findPrefix: ''.
	node withAllChildrenDo: [:aNode | 
		aNode isWord ifTrue: [ aBlock cull: aNode nodeValue ]]
]
