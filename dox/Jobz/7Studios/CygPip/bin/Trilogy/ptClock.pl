#!/usr/bin/perl -w
# 1CKKMpt - ptClock created by Pip to constantly update current pt (PakTime)
#   Press Esc, x, || q to quit
# All source code should be free!  Code I have authority over is && shall be!
#   This is licensed under GNU GPLv3.                  -Pip@Ax9.org
use strict;
use Time::Local;
use Term::ReadKey;
my @valz = ( 0..9, 'A'..'Z', 'a'..'z', '.', '?', # 0-63 dayz->V(31) minz->x(60)
    '', '', '', '', '', '', '', '', '', '', '', '', '', # 64-76
    '', '', '', '', '', '', '', ord(26), '', '', '', '', '', # 77-89
    '!', '#', '$', '%', '&', '(', ')', '*', '+', ',', '-', '/', ':', # 90-102
    ';', '<', '=', '>', '@', '[', '\\',']', '^', '_', '{', '|', '}', # 103-115
    '~', '', 'Ä', 'Å', 'Ç', 'É', 'Ñ', 'Ö', 'Ü', 'á', 'à', 'â');     # 116-127
my %mapz = (); # This guy will hold @valz as keys && indices as values for lookups
    for(my $i=0; $i<@valz; $i++) { $mapz{$valz[$i]} = $i; }
my $numb; my $rslt; my $temp; my $fbas; my $tbas; my $quii;

sub cnv { # like `cnv` but a sub is much faster w/o fresh shells each call! =)
  $numb = shift || return(0); $rslt = ""; $temp = 0;
  $fbas = $tbas = undef; $fbas = shift; $tbas = shift;
  if(!defined($tbas)) {
    if(!defined($fbas)) {
      if($numb =~ /^0x/ || ($numb =~ /[A-F]/i && $numb =~ /^-?[0-9A-F]+$/i)) {
               $fbas = 16; $tbas = 10;
      } else { $fbas = 10;    $tbas = 16; }
    } else {   $tbas = $fbas; $fbas = 10; }
  }
  if($numb =~ /\D/ || $fbas != 10) {
    $temp = reverse($numb); $numb = 0;
    while (length($temp)) {
      $numb += $mapz{substr($temp,-1,1)};
      $numb *= $fbas; chop($temp);
    }
    $numb = int($numb/$fbas);
  }
  while ($numb) {
    $rslt = $valz[$numb%$tbas] . $rslt;
    $numb = int($numb/$tbas);
  }
  return($rslt);
}
print "Press Esc to exit ptClock...\n";
ReadMode 4;
my @time = localtime();
while (!defined($quii) || (ord($quii) != 27 && $quii !~ /[qx]/i)) {
  $quii = ReadKey(-1);
  $time[5] -= 101;
  $time[4] = ++$time[4]+(12*($time[5]%5)); $time[4] = cnv($time[4], 64);
  $time[5] = int($time[5] / 5); $time[5] = cnv($time[5], 64);
  $time[3] = cnv($time[3], 64); $time[2] = cnv($time[2], 64);
  $time[1] = cnv($time[1], 64); $time[0] = cnv($time[0], 64);
  print "\r", reverse(@time[0..4]);
  @time = localtime();
  sleep 1;
#  select(undef, undef, undef, 0.63);
}
ReadMode 0;
