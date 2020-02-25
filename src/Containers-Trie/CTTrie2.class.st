Class {
	#name : #CTTrie2,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'Containers-Trie'
}

{ #category : #license }
CTTrie2 class >> license [
	"
	Author: Benoit St-Jean
	Email: bstjean@yahoo.com

	MIT license
	"
	
]

{ #category : #'instance creation' }
CTTrie2 class >> new [

	^(self basicNew) initialize
]

{ #category : #'should not use' }
CTTrie2 class >> new: anObject [

	^self error: 'You should use #new !'
]

{ #category : #'instance creation - bulk' }
CTTrie2 class >> readFromFile: anObject [
	^ self readFromFile: anObject withLineTransformer: [ :str | str ]
]

{ #category : #'instance creation - bulk' }
CTTrie2 class >> readFromFile: anObject withLineTransformer: aBlock [
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
CTTrie2 class >> wikipediaSampleInstance [
	<sampleInstance>
	"example taken from  <http://en.wikipedia.org/wiki/Trie>"
	| trie |
	trie := self new.
	"insert short words then long words"
	trie add: 'to' value: 7.
	trie add: 'tea' value: 3.
	trie add: 'ted' value: 4.
	trie add: 'ten' value: 12.

	"orphan word"
	trie add: 'a' value: 15.

	"insert longer word, then shorter, then in between"
	trie add: 'inn' value: 9.
	trie add: 'i' value: 11.
	trie add: 'in' value: 9.
	^ trie
]

{ #category : #adding }
CTTrie2 >> add: aString value: anObject [

	self add: aString valueWithBlock: [ anObject ]

	
]

{ #category : #adding }
CTTrie2 >> add: aString valueWithBlock: aValueBlock [
	"Add the word <aString> into the Trie structure and set its value by evaluating <aValueBlock> with <aString> as parameter.
	
	(Trie new) add: 'abc' valueWithBlock: [:string | string size]
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
	currentNode nodeValue: (aValueBlock cull: aString cull: currentNode nodeValue )
]

{ #category : #testing }
CTTrie2 >> contains: aString [
	"Answer a <Boolean> telling if the receiver contains the *word* <aString>"

	^(self find: aString) notNil
	

	

	
]

{ #category : #testing }
CTTrie2 >> containsPrefix: aString [
	"Answer a <Boolean> telling if the receiver contains  <aString> (either as a prefix or complete word)"

	| currentNode |
	currentNode := root.
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithLetter: each.
			child notNil
				ifTrue: [ currentNode := child ]
				ifFalse: [ ^ false ] ].
	^ true 
]

{ #category : #private }
CTTrie2 >> find: aString [ 
	"Answers a <Trie> if the word <aString> is found in the receiver, <nil> otherwise"
	| currentNode |
	
	currentNode := root.
	aString do: [:each | 	| child  |			
							child := currentNode findChildWithLetter: each.
							child notNil
								ifTrue: [currentNode := child ]
								ifFalse: [^nil]].
							
	^currentNode isWord
		ifTrue: [currentNode]
		ifFalse: [nil]

	

	

	
]

{ #category : #initialization }
CTTrie2 >> initialize [

	root := CTTrie2Node new
]
