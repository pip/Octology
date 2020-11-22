#!/bin/sh
# HAOMLuPL:GetL8stBool2GoodAut.sh crE8d by PipStuart <Pip@CPAN.Org> to autom8 the download && conversion of Danny Wyckoff's goodaut.tex (akin to my 8.txt);
#   After fixing raw file URL, also needed to: <root@AkuI2PLLf7H/home/pip>ai texlive-latex-base texlive-latex-recommended texlive-latex-extra dot2tex
#     to get ~900MB of TeX-rel8d fonts && a bunch of other d8a, including needed comment.sty && mathrsfs.sty, which allowed PDF gener8ion to run now;
#   Might also want to `diff` new PDF against any old versions, before determining whether new is unique && worth keeping, or should be removed as duplic8.
#     Further, since autom8d backups are made for all files && originals are versioned online, probably only the l8st PDF result should be kept prominent;
GABN='goodaut'   ; # setup the expected GoodAutomorphismsBaseName to be reused for all the intermeD8 filenames of various sepR8 purposes && extensions
 TTY='/dev/pts/0'; # assuming the first Pseudo-Terminal seems to suffice as the expected first parameter for my old backup utility to save all 4 files
#get HTTP://Web.CVS.Savannah.NonGNU.Org/viewvc/bool2/bool2/theory/goodaut.tex; # seems this was pulling a wrapping webpage, so below gets raw .tex
wget HTTP://Web.CVS.Savannah.NonGNU.Org/viewvc/\*checkout\*/bool2/bool2/theory/$GABN.tex
pdflatex           $GABN.tex
$HOME/bin/bak $TTY $GABN.tex $GABN.log $GABN.aux $GABN.pdf
rm                 $GABN.tex $GABN.log $GABN.aux
mv                 $GABN.pdf GoodAut-omorphisms_ofBooleanAlgebras-from_Bool2-by_DannyWyckoff-`d8`.pdf
