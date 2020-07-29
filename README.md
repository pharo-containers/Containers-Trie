# Containers-Trie
A trie implementation (original version from Benoit St-Jean).

This package is part of the Containers project: This project is to collect, clean, 
test and document alternate collection datastructures. Each package is modular so that users 
can only load the collection they need without 100 of related collections.

[![Build Status](https://travis-ci.com/pharo-containers/Containers-Trie.svg?branch=master)](https://travis-ci.com/pharo-containers/Containers-Trie)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()

[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)


## Loading

```
Metacello new
   baseline: 'ContainersTrie';
   repository: 'github://pharo-containers/Containers-Trie/src';
   load.
```

## If you want to depend on it

```
spec 
   baseline: 'ContainersTrie' 
   with: [ spec repository: 'github://pharo-containers/Containers-Trie/src' ].
```

----
The best way to predict the future is to do it!
Less talking more doing. stephane.ducasse@inria.fr
