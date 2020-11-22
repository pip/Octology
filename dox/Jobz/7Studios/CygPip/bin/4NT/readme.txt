
                               4NT v3.02

                      README.TXT -- April 12, 1999

                            JP Software Inc.
                             P.O. Box 1470
                      E. Arlington, MA 02474, USA

                             (781) 646-3975
                           fax (781) 646-0904
                         Email sales@jpsoft.com
                       Web http://www.jpsoft.com/


Greetings, and thanks for trying 4NT!

This file contains a variety of information you should read before using
4NT, including:

      Installation and "Branding" Instructions
      New Version Overview
      Revision Information
      Files Included with this Version
      Technical Support
      Legal Notices

Other information is available in other files:

      For ...                                See ...
      -----------------------------------    ------------
      Product and upgrade information        PRODUCTS.TXT
      New customer order form                ORDFORM.TXT
      Current customer upgrade order form    UPGFORM.TXT
      Introduction and Installation Guide    4NT.TXT
         (introductory documentation)
      Complete list of new features          Online help
      Trial version information              TRIAL.TXT
      License agreement                      LICENSE.TXT


INSTALLATION AND "BRANDING" INSTRUCTIONS
----------------------------------------

   This section explains how to install a downloaded copy of
   4NT.
   
   [If you have a copy on diskette or CD, or a copy purchased
   electronically, we assume you have already completed the installation
   -- otherwise this file would not be visible!  If you need to
   reinstall your purchased copy of 4NT, just restart
   the INSTALL program.]

   There are just three steps you need to take to install a downloaded
   copy of 4NT:

      >> Extract all the files to a new directory (do not use a directory
         you're using for other products, or for a previous version of
         4NT).

      >> Start 4NT.  It will "install itself".

      >> If you are upgrading a previously purchased copy, "brand"
         4NT with your name and serial number if necessary.

   Additional details on these steps are below.  For branding and manual
   installation instructions see the sections with those headings below.

   You can view any of the documentation files on-line, or copy them to
   your printer.  The Introduction and Installation Guide in 4NT.TXT
   has page breaks, headers and footers; all other documentation files
   are unpaginated ASCII text.


"Self-Installation"

   To begin the installation process, simply run the program file,
   4NT.EXE, from a prompt or from your desktop.  This will
   automatically start the self-installation file _4INST.BTM, which will
   finish installing 4NT on your system.

   _4INST will prompt you for permission before each installation step,
   and no system files will be modified without asking you first.
   
   When the installation is finished, _4INST renames itself to _4INST.BTX,
   so that it will not be run again.  (If installation terminates
   abnormally, _4INST may not be renamed, and will then run again the
   next time you start the program.)


Manual Installation

   For complete manual installation instructions, see the Introduction
   and Installation Guide in the file 4NT.TXT.  The detailed
   instructions for 4NT are in Chapter 7.
   
   If you choose to perform a manual installation you should rename the
   automated installation file, _4INST.BTM (we recommend renaming it to
   _4INST.BTX, which is what the file itself does when it's finished).
   If you don't, it will start automatically the first time you run
   4NT.


Branding

   If you are upgrading from a previously purchased copy you may need to
   run the "branding" program to install your name and serial number
   in 4NT (trial version users can skip this section).

   Your previous version's brand program may be the older version named
   BRAND.EXE, or the newer version named BR4NT.EXE.

   If you are installing this version as a maintenance release from
   version 3.01, and you branded version 3.01 with the newer
   BR4NT.EXE brand program, then in most cases you can skip the
   remainder of this section because your name and serial number will be
   transferred automatically to your new copy of 4NT.

   If you are unsure of how the previous version was branded, or if you
   find that the name and serial number are not transferred for any
   reason, follow the instructions below to brand your new version.  You
   will also need the instructions below if you previously used a "file
   brand" following special instructions from our technical support
   department.
   
   In order to perform the branding you will need the brand program, and
   the registered name, serial number, and validation code which came
   with your purchased copy of 4NT.

   (If you have lost your branding information it is replaceable, but a
   small charge is required as recreating the codes is a multi-step
   process.  To request replacement codes contact JP Software at
   sales@jpsoft.com, or at one of the addresses listed at the start of
   this file.  (We are currently hoping to make replacement brand codes
   available through the support area of our web site at
   http://www.jpsoft.com/, but we do not yet know when this service will
   be available.)

   The older BRAND.EXE program modifies the 4NT.EXE file, and can only
   be used while 4NT is not running.  To use it:

      (1) Exit from all copies of 4NT.

      (2) Start a command prompt session (use another JP Software
      product, or the operating system's built-in command processor).

      (3) Change to the directory where 4NT.EXE is installed, and
      verify that both 4NT.EXE and BRAND.EXE are in that directory.

      (4) Locate the branding information which came with your copy of
      4NT (information from other products won't work!).

      (5) Enter the command BRAND and follow the instructions on the
      screen.
   
   The newer BR4NT.EXE program does not have the same restrictions, and
   can be run using this simpler procedure:

      (1) Start 4NT.

      (2) Change to the directory where 4NT.EXE is installed, and
      verify that both 4NT.EXE and BR4NT.EXE are in that directory.

      (3) Locate the branding information which came with your copy of
      4NT.

      (4) Enter the command BR4NT and follow the instructions on the
      screen.

   If you attempt to brand your downloaded copy and receive the message
   "brand installation error 4" or "contact JP Software or your dealer
   for an upgrade", then you are not eligible to download and brand a
   trial version of this release -- instead, you must purchase the
   upgrade.  See UPGFORM.TXT for an order form.  Once you have ordered
   an upgrade you can continue to use the trial version until your
   upgrade arrives.

   If you receive any other error, you have probably mistyped your name,
   serial number, or validation code, or are attempting to use the brand
   program or codes from one product with another product, which will
   not work.


NEW VERSION OVERVIEW
--------------------

Since the last major release we've added 150 new features to
4NT!

Here are a very small number of major highlights; for complete details,
see the online help:

   >> Extended Directory Searches allow you to change to a directory
      anywhere on your system by entering only part of its name.  See
      Directory Navigation in the help for complete details.

   >> You can directly execute URLs, and files with Windows
      associations, from the 4NT prompt.

   >> New commands include:

          OPTION:  Offers complete configuration adjustment in all
          products, either through interactive dialogs or on the command
          line.

          SWITCH:  Provides for "case" statements in batch files.

          TOUCH:  Adjusts file dates and times.

          TREE:  Displays the directory tree, with or without file
          names, in a variety of formats.

   >> New file exclusion ranges provide a convenient way to exclude
      files from any internal command -- faster and more flexible than
      using EXCEPT.

   >> The new batch file debugger can execute each line step by step,
      process or trace into additional batch files, and display
      variables, aliases, and expanded commands at each step.

See the online help for 150+ additional new command line tools,
switches, variables, functions and other enhancements!


REVISION INFORMATION
--------------------

This update fixes a range of minor problems in version 3.01.  For
complete details on all bug fixes and compatibility enhancements see
the "What's New" topic in the online help.


FILES INCLUDED
--------------

   The following files are included with 4NT 3.02:

         4NT.EXE           4NT program file
         4NT.HLP           4NT help text
         4NT.CNT           4NT help contents file
         4NT.TXT           ASCII copy of the 4DOS, 4OS2, and 4NT
                              Introduction and Installation Guide
         _4INST.BTM        *Self-installation batch file
         BATCOMP.EXE       Batch file compression utility
         BR4NT.EXE         #Brand program for registered users to
                              install name and product serial number
         EXAMPLES.BTM      Sample batch file demonstrating the use of
                              variable functions and internal variables
         FILE_ID.DIZ       *Description file for BBS and other uploads
         INSTHELP.EXE      Installation helper program
         INTERNAT.TXT      Shipping rates and dealer list for
                              international customers
         JP4NT.INF         Setup file to install 4NT registry extensions
         JP4NTSC.INF       Setup file to install JP Software program
                              group and shortcuts
         LICENSE.TXT       License agreement
         ORDFORM.TXT       New customer order form
         PRODUCTS.TXT      Product and ordering information
         README.TXT        This file
         SHRALIAS.EXE      Utility program for retention of global
                              alias and history lists
         TRIAL.TXT         Explanation of trial version
         UPGFORM.TXT       Upgrade order form
         VENDOR.TXT        *Information for shareware vendors

      * Included with downloaded trial copies only.
      # Included with purchased copies only.


TECHNICAL SUPPORT
-----------------

   Complete details on technical support are in the Introduction and
   Installation Guide, in the file 4NT.TXT.

   Often the quickest way to reach us for support is electronically.
   Current options are listed below; any additional options offered or
   changes made in the future will be listed on our web site at
   http://www.jpsoft.com/.

   In brief, your support options are:

      >> Internet email to support@jpsoft.com.

      >> JP Software's CompuServe area, accessible via the Quick
         Reference Word "JPSOFT" or directly in section 2 of the
         "CVTHREE" forum.  For support leave a message in this area
         addressed to user ID 75300,1215.

      >> Telephone support on a one business day callback basis (though
         often we return calls much more quickly than that).

         From the US and Canada, the quickest method to reach our
         support staff by phone is to leave a message on our support
         voice message line at 781-646-0798.  Messages are checked
         regularly throughout the day.  Do not use this line for sales,
         customer service, or shipping questions, and please call our
         main number at 781-646-3975 if you find yourself playing
         "telephone tag" with the support staff.

      >> Fax support at 781-646-0904 (however, you will almost always
         receive a faster response to email than to faxed support
         questions).

   When possible, we also read messages posted on the Usenet
   comp.os.msdos.4dos newsgroup.  This newsgroup offers valuable
   information and discussions with other users, but is not managed by
   JP Software, and is not an official support channel.

   To download JP Software files, including upgdates and trial versions,
   visit:

      >> Our web site at http://www.jpsoft.com/

      >> Our ftp site at ftp.jpsoft.com

      >> Our CompuServe file area, accessible via the Quick Reference
         Word "JPSOFT" or directly in library 2 of the "CVTHREE" forum


LEGAL STUFF
-----------

Copyright 1999, JP Software Inc., All Rights Reserved.  Published by JP
Software Inc., P.O. Box 1470, E. Arlington, MA 02474, U.S.A., phone
781-646-3975, fax 781-646-0904.

Take Command and 4DOS are registered trademarks of JP Software Inc.
4DOS, 4OS2, and 4NT are JP Software Inc.'s trademarks for its family of
character-mode command processors.  JP Software, jpsoft.com, and all JP
Software designs and logos are also trademarks of JP Software Inc. Other
product and company names are trademarks of their respective owners.

All prices and terms subject to change without notice.

