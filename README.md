# Containers-Trie
A trie implementation (original version from Benoit St-Jean).

This package is part of the Containers project: This project is to collect, clean, 
test and document alternate collection datastructures. Each package is modular so that users 
can only load the collection they need without 100 of related collections.

[![Build Status](https://travis-ci.com/Ducasse/Containers-Trie.svg?branch=master)](https://travis-ci.com/Ducasse/Containers-Trie)
[![Coverage Status](https://coveralls.io/repos/github//Ducasse/Containers-Trie/badge.svg?branch=master)](https://coveralls.io/github//Ducasse/Containers-Trie?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Pharo version](https://img.shields.io/badge/Pharo-6.1-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
<!-- [![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)  -->



## Loading

```
Metacello new
   baseline: 'ContainersTrie';
   repository: 'github://Ducasse/Containers-Trie/src';
   load.
```

## If you want to depend on it

```
spec 
   baseline: 'ContainersTrie' 
   with: [ spec repository: 'github://Ducasse/Containers-Trie/src' ].
```

## History
I harvested the code from the old SmalltalkHub/PharoExtras repository. Interested archeologues can find relevant commit history there. 
http://www.smalltalkhub.com/#!/~PharoExtras/OrderPreservingDictionary

----
The best way to predict the future is to do it!
Less talking more doing. stepharo.self@gmail.com
