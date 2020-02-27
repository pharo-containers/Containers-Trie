Class {
	#name : #CTSuffixTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'suffixTree'
	],
	#category : #'Containers-Trie-Tests'
}

{ #category : #running }
CTSuffixTreeTest >> setUp [
	
	super setUp.
	suffixTree := CTSuffixTree new
]

{ #category : #tests }
CTSuffixTreeTest >> testAddingAStringAddsAllSubstring [

	suffixTree atSuffixesOf: 'banana' put: 1.
	
	#('a' 'na' 'ana' 'nana' 'anana' 'banana')
		do: [ :e | self assert: (suffixTree at: e) equals: 1 ]	
	
]

{ #category : #tests }
CTSuffixTreeTest >> testRemovingAStringRemovesAllSuffixes [

	suffixTree atSuffixesOf: 'banana' put: 1.
	suffixTree removeSuffixesOf: 'banana'.
	
	#('a' 'na' 'ana' 'nana' 'anana' 'banana')
		do: [ :e | self deny: (suffixTree contains: e) ]	
	
]
