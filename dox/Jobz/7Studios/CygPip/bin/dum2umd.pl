#!/usr/bin/perl -w
# CKLhG - dum2umd.pl created by Pip to replace dtou.exe && utod.exe
#   because they choke on ascii 26 (Ctrl-Z == EOF in normal Win32 ie. w/o
#   binmode).  Old utils clobbered a bunch of my files =( ... I knew Perl
#   could do better =)
# First param is file to convert.  Optional second param can be "d" or "m"
#   for result file to get Dos or Mac formatted EndOfLines respectively.
#   No second param will result in unix format.
# Note: No intermediate file is used so you need enough RAM to store the
#   whole file in a scalar.  It might be bad news if you try to use this
#   util on a huge binary file.
# All source code should be free!  Code I have authority over is && shall be!
#                                             -Pip@Ax9.org

use strict;

my $flnm = shift || exit(); my $rslt = shift || "u"; my $snrf = "";
unless (-e $flnm) { exit(); }
open FILE, "<$flnm";
binmode FILE;
$snrf = join '', <FILE>;
close FILE;

if    (lc($rslt) eq "d") { $snrf =~ s/(\015\012|\015|\012)/\015\012/g; } # Dos
elsif (lc($rslt) eq "m") { $snrf =~ s/(\015\012|\015|\012)/\015/g; } # Mac
else                     { $snrf =~ s/(\015\012|\015|\012)/\012/g; } # Unix

open FILE, ">$flnm";
binmode FILE;
print FILE $snrf;
close FILE;

