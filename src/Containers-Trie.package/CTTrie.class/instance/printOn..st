printing
printOn: aStream

	super printOn: aStream.
	aStream
		cr;
		nextPutAll: 'children : ';
		nextPutAll: self children keys asSortedCollection asArray printString;
		cr;
		nextPutAll: 'value : ';
		nextPutAll: self nodeValue printString;
		cr;
		nextPutAll: 'leaf : ';
		nextPutAll: self isLeaf printString.