# Containers-Trie
A trie implementation (original version from Benoit St-Jean).

<a href="https://www.pharo.org">
    <img alt="Pharo" src="https://img.shields.io/static/v1?style=for-the-badge&message=Pharo&color=3297d4&logo=Harbor&logoColor=FFFFFF&label=" />
</a>

This package is part of the Containers project: This project is to collect, clean, 
test and document alternate collection datastructures. Each package is modular so that users 
can only load the collection they need without 100 of related collections.

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
