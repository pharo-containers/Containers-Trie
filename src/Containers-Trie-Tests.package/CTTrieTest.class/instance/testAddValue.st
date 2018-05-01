tests - adding
testAddValue
	| aTrie |
	
	aTrie := CTTrie new.
	aTrie add: 'one' value: 1.
	aTrie add: 'two' value: 2.
	aTrie add: 'fourth' value: '4th'.
	aTrie add: 'four' value: 4.

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
	
