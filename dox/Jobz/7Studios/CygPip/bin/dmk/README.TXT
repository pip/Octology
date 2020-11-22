This is DMAKE version 4.11 (plus a patch to fix spurious warnings) compiled for
Win32 using MS VC++ 6.

For information on how to use DMAKE, see man\dmake.nc.

DMAKE needs a set of startup files that are located in a subdirectory called
"startup" where DMAKE.EXE lives, or in a directory specified by a DMAKEROOT
environment variable.  So, to install it, just copy DMAKE.EXE and the startup
subdirectory to some location on your path.

You can change the default platform in the startup\config.mk file (the defaults,
despite appearances, are set up for MS VC++ 6 on Windows NT/2000/XP etc.).  If
you change the defaults, you'll need to make sure the subdirectories you name in
startup\config.mk are populated with setup files (you can use the current
hierarchy as a model).

The original sources of DMAKE were available from:

    http://dmake.wticorp.com

but this site has not been reachable for some time.  The sources are now hosted
in the OpenOffice.org "tools" project, the home page for which is:

    http://tools.openoffice.org/

and details on the OpenOffice.org version of DMAKE can be found at:

    http://tools.openoffice.org/dmake/

You can get the latest "stable" sources from:

    cvs -d :pserver:anoncvs@anoncvs.services.openoffice.org:/cvs co dmake

This version of DMAKE is compiled from the stand-alone dmake 4.11 source package
found at:

    http://tools.openoffice.org/dmake/dmake_4.11.zip

The file PATCH.TXT contains the changes that I made to those sources, namely, a
change to the version string displayed by "dmake -V", plus a couple of other
changes inspired by the changes made by Gurusamy Sarathy in his DMAKE 4.1 build
which is available from:

    ftp://ftp.linux.activestate.com/pub/staff/gsar/

together with a patch to fix spurious warnings taken from attachment #50678 in
OpenOffice.org issue #85014, which can be seen at:

    http://www.openoffice.org/issues/show_bug.cgi?id=85014

Note that there was no version 4.10 in the series of DMAKE releases made
available by OpenOffice.org (or these binary builds of them released on CPAN) to
avoid confusion with Sarathy's release mentioned above (which identified itself
as "Version 4.10, PL 0").

Enjoy!

Steve Hay
shay@cpan.org
07-Jan-2008
