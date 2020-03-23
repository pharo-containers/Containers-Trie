Extension { #name : #String }

{ #category : #'*Containers-Trie' }
String >> suffixes [
	
	self ifEmpty: [ ^ #() ].	
	^ { self } , self allButFirst suffixes
]

{ #category : #'*Containers-Trie' }
String >> suffixesDo: aBlock minLength: minLength [

	2 to: self size - minLength do: [ :initial | 
		aBlock value: (self copyFrom: initial to: self size)	
	].

]
