MakefileScript
==============
Maker v1.2
Created by Scott Walker

Description: A shell script that creates a C++ makefile.

How to use:

  maker <filename.cpp>
  // filename should contain the main entrypoint
  
  -v
  // verbose: tell user what is being done (WIP)
  
  -n <outputname>
  // name: changes the name of the output executable (WIP)
  
  -g
  // debug: run compiler with -g flag and add a debug command to the makefile
  
  -m
  // minimal: only create compiler commands in makefile
  
Example:

  maker foo.cpp -v -g -n bar
  // builds a makefile for foo.cpp, tells the user what maker is doing, compiles for debugging, 
  // and names the executable bar.x
  
Install:

  git clone git://github.com/Blaaaaarg/MakefileScript.git
  cd MakefileScript
  mv maker.sh ~/bin/maker
  
  Note: this will only work if ~/bin/ is in your PATH variable but it should be by default.
  
Known issues:

  -n gets confused unless it is the last flag passed. Make sure you do this or makefile will likely not work right.
  
Future updates:

  - add support for gcc so it works for both compilers and can be used for C code
  - fix the -n issue
  - find other useful options
  - make -v more interesting
