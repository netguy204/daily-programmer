What is This?
=============

This is an interesting starting point for quick (and perhaps larger)
C++ applications. It's optimized for getting stuff done with minimal
thought.

* It integrates the lazycpp preprocessor to let you combine your class
  declaration and specification into a single file. The lzz
  preprocessor then splits this file into the .h and .cpp files you
  would normally have to maintain separately.
  
* Introduces the convention that each .lzz file contains the
  implementation of a single class of the same name. This lets us
  generate predeclarations for all of the classes.
  
* Includes the Boehm garbage collector. Your classes can opt-into
  garbage collection by extending the gc class.


Why is This?
============

* Maintaining separate .cpp and .h files is annoying (IMHOP).

* Sometimes having garbage collection enables some very interesting
  design options. Sometimes the stack or reference counting smart
  pointers are the right answer. Let the developer choose based on the
  circumstances.
  
