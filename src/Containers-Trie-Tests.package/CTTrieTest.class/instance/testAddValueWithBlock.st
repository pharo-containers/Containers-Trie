tests - adding
testAddValueWithBlock
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
	
	aTrie := CTTrie new.
	aTrie add: 'one' valueWithBlock: aBlock.
	aTrie add: 'two' valueWithBlock: aBlock.
	aTrie add: 'fourth' valueWithBlock: aBlock.
	aTrie add: 'four' valueWithBlock: aBlock.

	self assert: (aTrie find: 'one') notNil.
	self assert: (aTrie contains: 'one').
	self assert: ((aTrie find: 'one') nodeValue = 1).
	
	self assert: (aTrie find: 'two') notNil.
	self assert: (aTrie contains: 'two').
	self assert: ((aTrie find: 'two') nodeValue = 2).
	
	self assert: (aTrie find: 'fourth') notNil.
	self assert: (aTrie contains: 'fourth').
	self assert: ((aTrie find: 'fourth') nodeValue = '4th').
	
	self assert: (aTrie find: 'four') notNil.
	self assert: (aTrie contains: 'four').
	self assert: ((aTrie find: 'four') nodeValue = 4).