MakefileScript
==============
Maker v1.4
Created by Scott Walker

Description: A shell script that creates a C++ makefile.

==============
 How to use 
==============

Type 'maker' in your project directory with any of the following flags (or none)
  
-v
> verbose: tell user what is being done
  
-n outputname
> name: changes the name of the output executable
  
-g
> debug: run compiler with -g flag and add a debug command to the makefile
  
-m
> minimal: only create compiler commands in the makefile

-d
> compile by default: compile your project with make after the makefile has been completed

-df
> compile by default (forced): compile your project with make after the makefile has been
> completed and don't check for overwrites

-gcc
> use gcc: normally it defaults to g++

===========
 Example 
===========

maker -v -g -n bar.x
> builds a makefile in the current directory, tells the user what maker is doing, 
> compiles for debugging, and names the executable bar.x

===========  
 Install 
===========

1. git clone git://github.com/Blaaaaarg/MakefileScript.git
2. cd MakefileScript
3. mv maker.sh ~/bin/maker
  
Note: this will only work if ~/bin/ is in your PATH variable but it should be by default.
  
================
 Known bugs 
================

- the d flag will check in subdirectories for files with the same name
- Using this on programs like cygwin might not work unless you use the dos2unix command

==================  
 Future updates 
==================

- add support for .c files
- find more useful features
