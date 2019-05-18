Class {
	#name : #BaselineOfContainersTrie,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersTrie
}

{ #category : #baselines }
BaselineOfContainersTrie >> baseline: spec [
	<baseline>

	spec for: #pharo do: [
		spec package: 'Containers-Trie'.
		spec package: 'Containers-Trie-Tests' with: [ spec requires: #('Containers-Trie') ]
	]
]
