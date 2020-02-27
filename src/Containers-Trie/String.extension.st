Extension { #name : #String }

{ #category : #'*Containers-Trie' }
String >> suffixes [
	
	| suffixes |
	
	self ifEmpty: [ ^ #() ].	
	^ { self } , self allButFirst suffixes
]
