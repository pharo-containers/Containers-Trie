Class {
	#name : #AbstractCTTrieTest,
	#superclass : #TestCase,
	#instVars : [
		'trie'
	],
	#category : #'Containers-Trie-Tests'
}

{ #category : #utils }
AbstractCTTrieTest >> classUnderTest [
	
	^ CTTrie
]

{ #category : #utils }
AbstractCTTrieTest >> newInstance [
	
	^ self classUnderTest new
]

{ #category : #running }
AbstractCTTrieTest >> setUp [
	"example taken from  <http://en.wikipedia.org/wiki/Trie>"

	super setUp.
	trie := self classUnderTest wikipediaSampleInstance
]
