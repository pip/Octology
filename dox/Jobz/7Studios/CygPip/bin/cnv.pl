#!/usr/bin/perl -w
# cnv (CoNVert number bases) <number> <fromBase> <toBase>
# If you only supply a number, it will convert to hex if it's decimal &&
#   decimal if it contains only valid hex digits.  If you just provide one
#   base parameter, it assumes that your number is already base10 && that
#   you've supplied the toBase.  Otherwise, you need from && to parameters.
#  Examples:    `perl cnv 127   10 16` == "7F"
#               `perl cnv 7F    16 3`  == "11201"
#               `perl cnv 11201 3  7`  == "241"
#               `perl cnv 241   7  10` == "127"
# !ERROR! checking is minimal at best so don't assume perfection... yet =).
# All source code should be free!  Code I have authority over is && shall be!
#                                             -Pip@Ax9.org

use strict;
my @valz = ( 0..9, 'A'..'Z', 'a'..'z', '.', '?', # 0-63 dayz->V(31) minz->x(60)
    '', '', '', '', '', '', '', '', '', '', '', '', '', # 64-76
    '', '', '', '', '', '', '', '', '', '', '', '', '', # 77-89
    '!', '#', '$', '%', '&', '(', ')', '*', '+', ',', '-', '/', ':', # 90-102
    ';', '<', '=', '>', '@', '[', '\\',']', '^', '_', '{', '|', '}', # 103-115
    '~', '', 'Ä', 'Å', 'Ç', 'É', 'Ñ', 'Ö', 'Ü', 'á', 'à', 'â');     # 116-127
my %mapz = (); # This guy will hold @valz as keys && indices as values for lookups
    for(my $i=0; $i<@valz; $i++) { $mapz{$valz[$i]} = $i; }
my $numb = shift || exit(); my $rslt = ""; my $temp = 0;
my $fbas = shift; my $tbas = shift;
if (!defined($tbas)) {
    if (!defined($fbas)) {
        if ($numb =~ /^0x/ || ($numb =~ /[A-F]/i && $numb =~ /^-?[0-9A-F]+$/i)) {
            $fbas = 16; $tbas = 10;
#        } elsif ($numb =~ /^[01]+b$/) { # try to detect only binary "10110b"
#            $fbas = 2; $tbas = 10;
        } else {
            $fbas = 10; $tbas = 16;
        }
    } else {
        $tbas = $fbas;
        $fbas = 10;
    }
}
if ($numb =~ /\D/ || $fbas != 10) {
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
print "$rslt";
