A tree for storing strings in which there is one node for every common prefix. The strings (words) are *usually* stored in extra leaf nodes.  The root of a Trie can be recognized by the fact that its caracter instance variable is <nil>.  Words can be determined by the fact that the node completing the word has a nodeValue.  Note that a word does not have to be found at a leaf node (e.g. the word "in", see Wipidedia example at link given below).

See <http://en.wikipedia.org/wiki/Trie> for more details.  

Instance Variables: 	
	character	<Character> | <nil >				
	children	<IdentityDictionary> with keys <Character>  and values <Trie>
	nodeValue	<Object>
		
		
Public API:
			
Method 				usage 	
add:value: 				add: aString value: anObject
add:valueWithBlock: 	add: aString valueWithBlock: aBlock
contains: 				contains: aString
containsPrefix: 			containsPrefix: aString
			
For licensing, see class method #license


