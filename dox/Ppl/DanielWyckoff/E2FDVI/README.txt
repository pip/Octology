e2fdvi README
=========================
First off, sorry about this and the LGPL file being in Windows "\r\n" format instead of 
the Unix format.  To rid yourself of those ridiculous characters at the end of each line, 
in vim, type ":set ff=unix" and then ":w" and you should be fine!
(I do development on an offline Linux box, then transfer files on my parents' Windows
box.  Don't ask!)

During these initial pre-alpha phases of e2fdvi, there will be little in the way of 
user-friendliness.  This is because I'm only at the beginning stages of development. 
The following packages / APIs / libraries must be installed on your system in order for the 
main file e2fdvi.c to compile:
	*gcc
	*RCS
	*GTK+
	*FreeType
	*Cairo
The versions of the above correspond to the Gutsy release of Ubuntu, but hopefully should
work for more up-to-date versions.  Sorry about the lag-time.  

Also, SourceForge.net doesn't allow commas in their file-systems, so the first thing 
you should do after you unpack this package is rename e2fdvi.c to e2fdvi.c,v
.

Then you should type "co -l e2fdvi.c" 
(without the quotes of course).

The command to compile it is the following: 

gcc -Wall -g e2fdvi.c -o e2fdvi `pkg-config --cflags gtk+-2.0` `pkg-config --libs gtk+-2.0` `freetype-config --cflags` `freetype-config --libs`

It might be a bit redundant, but I never bothered doing anything about it!  It should work.  

Also, add a symlink to the path of the dvi file you wish to view in the e2fdvi directory, 
as such: "ln -s [path-to-DVI-file] sample.dvi"

Sorry again about the humble state of e2fdvi at present time.  Will be vastly improved 
as the months progress.

Thanks for your interest, and enjoy.  