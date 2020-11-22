#!/usr/bin/perl -w
# CKEIX - util to flexibly read binary file header info
#  takes byte-based unpack pattern, filename, && optional file offset
#   eg. `perl readhead.pl V2x2v c:\gfx\SoulCal0.bmp 18` prints:
#           292 640 24 (.bmp width, height, bit-depth)

use strict;

my $ptrn = shift || exit(); my $flnm = shift; my $ofst = shift || 0;
my $temp = $ptrn; my $size = 0; my $type = ""; my $incr = 1; my @valz = ();
unless (-e $flnm) { exit(); }
while ($temp =~ /^([a-z])(\d*)/i) {
    ($type, $incr) = ($1, $2);
    if (!defined($type) || $type !~ /^[a-z]$/i) { $type = "z"; }
    if (!defined($incr) || $incr !~ /^\d+$/)    { $incr = 1; }
    if    ($type =~ /^[snv]$/)  { $incr *= 2; }
    elsif ($type =~ /^[flNV]$/) { $incr *= 4; }
    elsif ($type =~ /^[d]$/)    { $incr *= 8; }
    $size += $incr;
    $temp =~ s/^[a-z]\d*//i;
}
open FILE, "<$flnm";
binmode FILE;
read FILE, $temp, $ofst;
read FILE, $temp, $size;
close FILE;
#print "ptrn:$ptrn size:$size ofst:$ofst\n";
#foreach (split //, $temp) { print ord($_), ", "; } print "\n";
while ($ptrn =~ /^([a-z])(\d*)/i) {
    ($type, $incr) = ($1, $2);
    if (!defined($type) || $type !~ /^[a-z]$/i) { $type = "z"; }
    if (!defined($incr) || $incr !~ /^\d+$/)    { $incr = 1; }
    if ($type ne "x") {    # not null
        push(@valz, unpack("$type$incr", $temp));
    }
    if    ($type =~ /^[snv]$/)  { $incr *= 2; }
    elsif ($type =~ /^[flNV]$/) { $incr *= 4; }
    elsif ($type =~ /^[d]$/)    { $incr *= 8; }
    $temp = substr($temp,$incr,(length($temp)-$incr));
    $ptrn =~ s/^[a-z]\d*//i;
}
print "@valz\n";
