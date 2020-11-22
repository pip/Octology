#!/usr/bin/perl -w
use strict;
my $cwd = shift || die;
my $iwd = $cwd;
my $swd = $cwd; my $sdr = "";
$cwd =~ s/\//\\/g;
$swd =~ s/\\.*//;
while($cwd =~ s/\\([^\\]+)//) {
  $sdr = $1;
  if(length($sdr) > 8 || $sdr =~ /( |\.....+)/) {
    $sdr =~ s/ //g;
    $sdr =~ s/^([^.][^.]?[^.]?[^.]?[^.]?[^.]?).*\.(...).+$/$1~1$2/; # w/ ext
    $sdr =~ s/^([^.][^.][^.][^.][^.][^.])[^.][^.][^.]+(\.?.*)$/$1~1$2/; # wo ext
  }
  $swd .= "\\$sdr";
}
print "$iwd";
#print "& echo $iwd & echo $cwd & echo $swd";
