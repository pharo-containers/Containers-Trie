"
SUnit tests for class Trie.

For licensing, see class method #license
"
Class {
	#name : #CTTrieTest,
	#superclass : #AbstractCTTrieTest,
	#category : #'Containers-Trie-Tests'
}

{ #category : #license }
CTTrieTest class >> license [
	"
	Author: Benoit St-Jean
	Email: bstjean@yahoo.com

	MIT license. 
	"
]

{ #category : #'tests - adding' }
CTTrieTest >> testAddValueWithBlock [
	| aTrie aBlock |
	
	aBlock := [:string | 	(string = 'one')
							ifTrue: [1]
							ifFalse: [(string = 'two')
										ifTrue: [2]
										ifFalse: [(string = 'fourth')
													ifTrue: ['4th']
													ifFalse: [(string = 'four')
																ifTrue: [4]
																ifFalse: [0]]]]].
	
	aTrie := self newInstance.
	aTrie add: 'one' valueWithBlock: aBlock.
	aTrie add: 'two' valueWithBlock: aBlock.
	aTrie add: 'fourth' valueWithBlock: aBlock.
	aTrie add: 'four' valueWithBlock: aBlock.

	self assert: (aTrie find: 'one') notNil.
	self assert: (aTrie contains: 'one').
	self assert: (aTrie find: 'one') nodeValue equals: 1.
	
	self assert: (aTrie find: 'two') notNil.
	self assert: (aTrie contains: 'two').
	self assert: (aTrie find: 'two') nodeValue equals: 2.
	
	self assert: (aTrie find: 'fourth') notNil.
	self assert: (aTrie contains: 'fourth').
	self assert: (aTrie find: 'fourth') nodeValue equals: '4th'.
	
	self assert: (aTrie find: 'four') notNil.
	self assert: (aTrie contains: 'four').
	self assert: (aTrie find: 'four') nodeValue equals: 4.

	self assert: (aTrie isCompressed)	
]

{ #category : #'tests - adding' }
CTTrieTest >> testAddWord [
	| unTrie |
	unTrie := self newInstance.
	unTrie at: 'bon' put: 3.
	self assert: (unTrie contains: 'bon').
	self assert: (unTrie find: 'bon') notNil.
	self assert: (unTrie find: 'bon') nodeValue equals: 3
]

{ #category : #'tests - querying' }
CTTrieTest >> testAllValues [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.
	
	self assertCollection: #(1 2 3) hasSameElements: aTrie allValues
]

{ #category : #'tests - testing' }
CTTrieTest >> testAnEmptyTrieDoesNotContainPrefix [

	self deny: (self newInstance containsPrefix: 'z').

	
]

{ #category : #'tests - adding' }
CTTrieTest >> testAt [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	
	self assert: (aTrie at: 'one') equals: 1.
	self should: [aTrie at: 'two'] raise: KeyNotFound.	
]

{ #category : #'tests - adding' }
CTTrieTest >> testAtIfAbsent [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	
	self assert: (aTrie at: 'one' ifAbsent: [self error]) equals: 1.
	self assert: (aTrie at: 'two' ifAbsent: [2]) equals: 2.	
]

{ #category : #'tests - adding' }
CTTrieTest >> testAtPut [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 2.
	aTrie at: 'fourth' put: '4th'.
	aTrie at: 'four' put: 4.

	self assert: (aTrie find: 'one') notNil.
	self assert: (aTrie contains: 'one').
	self assert: (aTrie find: 'one') nodeValue equals: 1.
	self assert: (aTrie find: 'two') notNil.
	self assert: (aTrie contains: 'two').
	self assert: (aTrie find: 'two') nodeValue equals: 2.
	self assert: (aTrie find: 'fourth') notNil.
	self assert: (aTrie contains: 'fourth').
	self assert: (aTrie find: 'fourth') nodeValue equals: '4th'.
	self assert: (aTrie find: 'four') notNil.
	self assert: (aTrie contains: 'four').
	self assert: (aTrie find: 'four') nodeValue equals: 4
]

{ #category : #'tests - adding' }
CTTrieTest >> testAtUpdate [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	
	aTrie at: 'one' update: [:oldValue | oldValue * 3].
	
	self assert: (aTrie at: 'one') equals: 3.
	self should: [aTrie at: 'two' update: [:oldValue | oldValue * 3]] raise: KeyNotFound.	
	
	"Check if the Trie is still compressed"
	self assert: aTrie isCompressed.
]

{ #category : #'tests - adding' }
CTTrieTest >> testAtUpdateInitial [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	
	aTrie at: 'one' update: [:oldValue | oldValue * 3] initial: [self error].
	aTrie at: 'two' update: [self error] initial: [2].
	
	self assert: (aTrie at: 'one') equals: 3.
	self assert: (aTrie at: 'two') equals: 2.
	
	
	"Check if the Trie is still compressed"
	self assert: aTrie isCompressed.
]

{ #category : #'tests - adding' }
CTTrieTest >> testAtUpdateWithNilValueRemovesTheKey [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	
	aTrie at: 'one' update: [:oldValue | nil].
	self should: [aTrie at: 'two'] raise: KeyNotFound.	
	
	"Check if the Trie is still compressed"
	self assert: aTrie isCompressed.
]

{ #category : #'tests - testing' }
CTTrieTest >> testContains [
	| aTrie |
	aTrie := self newInstance.
	self deny: (aTrie contains: 'z').

	"now, back to our wikipedia example"
	self deny: (trie contains: 'z').
	self deny: (trie contains: 't').
	self assert: (trie contains: 'to').
	self deny: (trie contains: 'toz').
	self deny: (trie contains: 'te').
	self assert: (trie contains: 'tea').
	self assert: (trie contains: 'ted').
	self assert: (trie contains: 'ten').
	self deny: (trie contains: 'tez').
	self deny: (trie contains: 'teaz').
	self deny: (trie contains: 'tedz').
	self deny: (trie contains: 'tenz').
	self assert: (trie contains: 'a').
	self deny: (trie contains: 'az').
	self assert: (trie contains: 'i').
	self assert: (trie contains: 'in').
	self assert: (trie contains: 'inn').
	self deny: (trie contains: 'iz').
	self deny: (trie contains: 'inz').
	self deny: (trie contains: 'innz')
]

{ #category : #'tests - testing' }
CTTrieTest >> testContainsPrefix [

	self deny: (trie containsPrefix: 'z').
	self assert: (trie containsPrefix: 't').
	self assert: (trie containsPrefix: 'to').
	self deny: (trie containsPrefix: 'toz').
	self assert: (trie containsPrefix: 'te').
	self assert: (trie containsPrefix: 'tea').
	self assert: (trie containsPrefix: 'ted').
	self assert: (trie containsPrefix: 'ten').
	self deny: (trie containsPrefix: 'tez').
	self deny: (trie containsPrefix: 'teaz').
	self deny: (trie containsPrefix: 'tedz').
	self deny: (trie containsPrefix: 'tenz').
	self assert: (trie containsPrefix: 'a').
	self deny: (trie containsPrefix: 'az').
	self assert: (trie containsPrefix: 'i').
	self assert: (trie containsPrefix: 'in').
	self assert: (trie containsPrefix: 'inn').
	self deny: (trie containsPrefix: 'iz').
	self deny: (trie containsPrefix: 'inz').
	self deny: (trie containsPrefix: 'innz')
]

{ #category : #'tests - nodes' }
CTTrieTest >> testIsCompressed [

	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 1.
	aTrie at: 'three' put: 1.
	aTrie at: 'four' put: 1.

	self assert: aTrie isCompressed
]

{ #category : #'tests - removing' }
CTTrieTest >> testRemoveKey [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.

	self assert: (aTrie removeKey: 'one') equals: 1.
	self should: [ aTrie at:'one' ] raise: KeyNotFound.
	self should: [aTrie removeKey: 'one'] raise: KeyNotFound.
	
	"Check if the Trie is still compressed"
	self assert: aTrie isCompressed.
]

{ #category : #'tests - removing' }
CTTrieTest >> testRemoveKeyIfAbsent [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.

	self assert: (aTrie removeKey: 'one' ifAbsent: [ self error ]) equals: 1.
	self should: [ aTrie at:'one' ] raise: KeyNotFound.
	self assert: (aTrie removeKey: 'one' ifAbsent: [ 2 ]) equals: 2.
	
	"Check if the Trie is still compressed"
	self assert: aTrie isCompressed.
]

{ #category : #'tests - removing' }
CTTrieTest >> testRemoveKeyOfANodeWithChilds [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 't' put: 1.5.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.

	self assert: (aTrie removeKey: 't') equals: 1.5.

	self assert: (aTrie findPrefix: 't') isNotNil.
	self deny: (aTrie findPrefix: 't') isWord.
	self assert: (aTrie findPrefix: 't') nodeValue isNil.
	self assert: (aTrie findPrefix: 't') children size equals: 2.

	self assert: (aTrie at: 'two') equals: 2.
	self assert: (aTrie at: 'three') equals: 3.
	
	"Check if the Trie is still compressed"
	self assert: aTrie isCompressed.	


	
]

{ #category : #'tests - removing' }
CTTrieTest >> testRemoveKeyOfANodeWithoutChilds [
	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'z' put: 1.5.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.

	self assert: (aTrie findPrefix: 'z') isNotNil.
	self assert: (aTrie findPrefix: 'z') isWord.
	self assert: (aTrie findPrefix: 'z') children size equals: 0.

	self assert: (aTrie removeKey: 'z') equals: 1.5.

	self assert: (aTrie findPrefix: 'z') isNil.

	"Check if the Trie is still compressed"
	self assert: aTrie isCompressed.


	
]

{ #category : #'tests - nodes' }
CTTrieTest >> testRemovingWikipediaExampleKeepsCompressed [

	#('to' 'tea' 'ted' 'ten' 'a' 'inn' 'i' 'in') 
		do: [ :aKey | trie removeKey: aKey. self assert: trie isCompressed ]


]

{ #category : #'tests - nodes' }
CTTrieTest >> testWikipediaExampleIsCompressed [

	self assert: trie isCompressed
]

{ #category : #'tests - querying' }
CTTrieTest >> testWithAllValuesBeginningWithdo [

	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.

	self assertCollection: #(2 3) hasSameElements: (aTrie allValuesBeginningWith: 't')
]

{ #category : #'tests - querying' }
CTTrieTest >> testWithAllValuesBeginningWithdoWithEmptyCollection [

	| aTrie |

	aTrie := self newInstance.
	self assertCollection: #() hasSameElements: (aTrie allValuesBeginningWith: 'z')
]

{ #category : #'tests - querying' }
CTTrieTest >> testWithAllValuesBeginningWithdoWithEmptyResults [

	| aTrie |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.
	
	self assertCollection: #() hasSameElements: (aTrie allValuesBeginningWith: 'z')
]

{ #category : #'tests - querying' }
CTTrieTest >> testWithAllValuesDo [
	| aTrie elements |

	aTrie := self newInstance.
	aTrie at: 'one' put: 1.
	aTrie at: 'two' put: 2.
	aTrie at: 'three' put: 3.

	elements := OrderedCollection new.
	aTrie withAllValuesDo: [ :e | elements add: e ].
	
	self assertCollection: #(1 2 3) hasSameElements: elements
]

{ #category : #'tests - querying' }
CTTrieTest >> testWithAllValuesDoOnEmptyDoesNotCall [
	| aTrie |

	aTrie := self newInstance.

	self shouldnt: [ aTrie withAllValuesDo: [ self error ] ] raise: Error.

]
