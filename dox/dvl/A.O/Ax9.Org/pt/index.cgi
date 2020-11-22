#!/usr/bin/perl
# 75O9Rod - index.cgi created by Pip Stuart <Pip@CPAN.Org> to demonstrate Time::PT
# 2do:
#   updt param splitting since newer module blanks day && month when appropriate so color mappings are off sometimes
use strict;
use warnings;
use CGI ":standard";
#use LWP::Simple;
use Math::BaseCnv qw(:all);
use Time::PT;
my $DBUG = 0;
my $colr = 1;# Red    Orange Yellow Green  Cyan   Blue   Purple
my @fiel = qw( Year   Month  Day    hour   minute second frame  ); # of the per-field color-codes, the upper set is bright && lower is dark
my @cold = qw( FF1B2B FF7B2B FFFF1B 1BFF3B 1BFFFF 1B7BFF BB1BFF
               7F0B1B 7F3B1B 7F7F0B 0B8F2B 0B7F7F 0B3B7F 5B0B7F ); $_ = '"#' . $_ . '"' for(@cold); # quote && pound each one
my @colz; push(@colz, "<font color=$cold[$_]>") for(0..$#fiel); # load bright font colors && terminator
my @crcl =( 2,  1,  2,  3,  0 );
my @rang =(63, 12, 31, 23, 59, 59, 59 );
my $smod = 1;
my $name = 'HTTP://Pip.LBox.Org';#Ax9.Org';
my $port = '';#:8080';
my $shrt = "$name$port/pt";
my $this = "$shrt/index.cgi";
my $path = "/usr/local/bin/pt";#`which pt`; chomp($path);
my $crpt = Time::PT->new();#`$path`;
my $crtm = $crpt->expand();#`$path $crpt`;
my $lrpt = $crpt; my $chpo = $crpt; my $chpt = $crpt;
my $lrtm = $crtm; my $chtm = $crtm; my $lhpt = $chpt; my $lhtm = $chtm;
my @fldz; my @tfld; my $temp; my $coln = '<font color="#FFFFFF">:</font>';
if(param()) { if   (param('pt')) { $chpt = param('pt'      ); }
              elsif(param('fr')) { $chpt = param('fr'      ); }
              else               { $chpt = param('keywords'); } }
if("$chpt" ne "$crpt") { $chpt =~ s/[^,:\?0-9A-Z._]*//gi; $chpt = substr($chpt, 0, 7) if($chpt !~ /\s/ && length($chpt) > 7);
  unless(param('fr') ) { $chpo = Time::PT->new($chpt); $chtm = $chpo->expand(); $chtm = 'Fri Jan  0 00:00:00:00 2000' if($chpt eq '0'); $lhtm = $chtm; }
  $lhpt = $chpt; }
if($colr) { @fldz =  split(   //, $lrpt); $lrpt = ''; for(0..$#fldz) {               $lrpt .= $colz[              $_ ] . $fldz[$_] . '</font>'      ; }
            @fldz =  split(   //, $lhpt); $lhpt = ''; for(0..$#fldz) { param('fr') ? $lhpt .= $colz[(7 - @fldz) + $_ ] . $fldz[$_] . '</font>'
                                                                                   : $lhpt .= $colz[              $_ ] . $fldz[$_] . '</font>'      ; }
            @fldz =  split(/\s+/, $lrtm); $lrtm = ''; for(0..$#fldz) {               $lrtm .= $colz[        $crcl[$_]] . $fldz[$_] . '</font>' . ' '; }
            @tfld =  split(  /:/, $fldz[3]);
            $temp =  $tfld[0] . $coln . $colz[4] . $tfld[1] . '</font>' .  $coln . $colz[5] . $tfld[2] . '</font>' .  $coln . $colz[6] . $tfld[3] . '</font>';
            $lrtm =~ s/$fldz[3]/$temp/;
            @fldz =  split(/\s+/, $lhtm); $lhtm = ''; for(0..$#fldz) {               $lhtm .= $colz[        $crcl[$_]] . $fldz[$_] . '</font>' . ' '; }
            @tfld =  split(  /:/, $fldz[3]);
            $temp =  $tfld[0] . $coln . $colz[4] . $tfld[1] . '</font>' .  $coln . $colz[5] . $tfld[2] . '</font>' .  $coln . $colz[6] . $tfld[3] . '</font>';
            $lhtm =~ s/$fldz[3]/$temp/; }
print "Content-type: text/html\n\n";
print <<END_HEADER;
<html><head><title>PakTime</title></head><body bgcolor="#03070F"
text="#AEFEBE" link="#0000F0" vlink="#00A070" alink="#D0A000"><center>
<h1><a href="/pt/">pt</a></h1>
<h3>Current   PakTime: $lrpt == ( $lrtm ) <br /><hr /><br />
END_HEADER
if(param('fr')) { print qq|<h3>Converted   Frame: $lhpt              </h3><br />|; }
else            { print qq|<h3>Converted PakTime: $lhpt == ( $lhtm ) </h3><br />|; }
print <<END_FORMS;
<table>     <tr><form method="POST" action="$this">
  <td><input type="text"   name="pt" value="$chpt"           ></td>
  <td><input type="submit" name="sb" value="Convert PT..."   ></td>
</tr></form><tr><form method="POST" action="$this">
  <td><input type="text"   name="fr" value="$chpt"           ></td>
  <td><input type="submit" name="sb" value="Convert Frame..."></td>
</tr></form></table><br />
<table border="1" width="97%"><tr><th>Decimal</th>
END_FORMS
for(0..63) { if(($_ + 1) % $smod) { print( '<td>'                  , "&nbsp;</td>\n"         ); }
             else                 { printf("<td><font size=\"1\">%02d</font></td>\n",     $_ ); } } print "</tr><tr><th>Base64</th>\n";
for(0..63) { if(($_ + 1) % $smod) { print( '<td>'                  , "&nbsp;</td>\n"         ); }
             else                 { printf("<td><font size=\"1\">%s  </font></td>\n", b64($_)); } } print "</tr><tr><td>&nbsp;</td>\n";
$temp = $chpt; $temp = sprintf("%07s", $temp) if(param('fr')); @fldz = split(//, $temp);
for my $bndx (0..$#fiel) {
  print qq(</tr><tr bgcolor=$cold[$bndx]><th bgcolor="#03071B"><font color="#A8F8F0">$fiel[$bndx]</font></th>\n);
  for(0..63) {
    if   ($bndx < @fldz && $_ <= b10($fldz[$bndx])) { print  '<td'                           , ">&nbsp;</td>\n"; }
    elsif(!param('fr')  && $_ <=     $rang[$bndx] ) { print  '<td bgcolor=', $cold[$bndx + 7], ">&nbsp;</td>\n"; }
    else                                            { print q(<td bgcolor="#000000")         , ">&nbsp;</td>\n"; }
  }
}
print <<END_EXPLAIN;
</tr></table>
<br /><h4>PakTime Description</h4>
</center>
<p>  &nbsp;&nbsp;pt was created because I like abbrev. too much.  I enjoy
representing base-10 numbers (our familiar decimal system) as 
base-64 for many purposes.  So I wanted a human-readable, yet 
still highly compact && useful mechanism to store precise time.
Each character in a pt represents a unique time field (with a
couple of exceptions).  The fields are:</p>
<center><pre>
  $colz[0]Year</font>, $colz[1]Month</font>, $colz[2]Day</font>, $colz[3]hour</font>, $colz[4]minute</font>, $colz[5]second</font>, $colz[6]frame (60th-of-a-second)</font>
</pre></center>
<p>  &nbsp;&nbsp;They are typically utilized as a 7-character string.   Examples:</p>
<center><pre>
  <a href="$shrt?1234567">$colz[0]1</font>$colz[1]2</font>$colz[2]3</font>$colz[3]4</font>$colz[4]5</font>$colz[5]6</font>$colz[6]7</font></a>
  <a href="$shrt?3CAAvYq">$colz[0]3</font>$colz[1]C</font>$colz[2]A</font>$colz[3]A</font>$colz[4]v</font>$colz[5]Y</font>$colz[6]q</font></a>
  <a href="$shrt?3CB3rdl">$colz[0]3</font>$colz[1]C</font>$colz[2]B</font>$colz[3]3</font>$colz[4]r</font>$colz[5]d</font>$colz[6]l</font></a>
</pre></center>
If you need less precision like just the date, you can take the 
  first 3 characters.  It's flexible && easy to use only as many
  fields as you need.                                  Examples:
<center><pre>
  <a href="$shrt?01">$colz[0]0</font>$colz[1]1</font></a>  ($colz[0]2000</font> $colz[1]January</font>    )
  <a href="$shrt?16">$colz[0]1</font>$colz[1]6</font></a>  ($colz[0]2001</font> $colz[1]June</font>       )
  <a href="$shrt?241">$colz[0]2</font>$colz[1]4</font>$colz[2]1</font></a> ($colz[0]2002</font> $colz[1]April   </font> $colz[2] 1</font>)
  <a href="$shrt?3CC">$colz[0]3</font>$colz[1]C</font>$colz[2]C</font></a> ($colz[0]2003</font> $colz[1]December</font> $colz[2]12</font>)
  <a href="$shrt?417">$colz[0]4</font>$colz[1]1</font>$colz[2]7</font></a> ($colz[0]2004</font> $colz[1]January </font> $colz[2] 7</font>)
</pre></center>
The exceptions to the one-character-per-field rule are:
<center><pre>
  0) For each 13 added to the Month,       add  64 to the Year.  
  1) If the hour field is greater than 23, add 256 to the Year.  
  2) If the Day  field is greater than 31, make the Year negative
                                              before adding 2000.
</pre></center>
These allow any 60th-of-a-second instant from Midnight New Years
  of 1489 through the end of December 31st 2511 to be represented
  in only 7 characters.                                Examples:
<center><pre>
  <a href="$shrt?0"      >$colz[0]0</font></a>                          ($colz[0]2000</font>)
  <a href="$shrt?_"      >$colz[0]_</font></a>                          ($colz[0]2063</font>)
  <a href="$shrt?0D"     >$colz[0]0</font>$colz[1]D</font></a>                         ($colz[0]2064</font>)
  <a href="$shrt?000O"   >$colz[0]0</font>$colz[1]0</font>$colz[2]0</font>$colz[3]O</font></a>                       ($colz[0]2256</font>)
  <a href="$shrt?30W"    >$colz[0]3</font>$colz[1]0</font>$colz[2]W</font></a>                        ($colz[0]1997</font>)
  <a href="$shrt?_eWO"   >$colz[0]_</font>$colz[1]e</font>$colz[2]W</font>$colz[3]O</font></a>                       ($colz[0]1489</font>)
  <a href="$shrt?_pVlxxx">$colz[0]_</font>$colz[1]p</font>$colz[2]V</font>$colz[3]l</font>$colz[4]x</font>$colz[5]x</font>$colz[6]x</font></a> ($colz[1]Dec</font> $colz[2]31</font> $colz[3]23</font>:$colz[4]59</font>:$colz[5]59</font>:$colz[6]59</font> $colz[0]2511</font>)
</pre></center>
<p>  &nbsp;&nbsp;Depending on the font used, there can be some troubling 
ambiguity with characters like 0, O, && o, 1, I, && l,
as well as 6 && G.  Good fonts distinguish each of these
similar but distinct characters so please employ such
a font when printing a pt.  Thanks. =)</p>
END_EXPLAIN
print <<END_FOOTER;
<br /><p>The source code to represent && convert time like this is available
from <a href="HTTP://Search.CPAN.Org/~Pip">HTTP://Search.CPAN.Org/~Pip</a> as
Time::PT.</p>
END_FOOTER
print '<center><br /><hr /><br /><h5>Smaller Graph to Fit Screen Width</h5><br /><table width="97%"><tr>';
for my $bndx (0..$#fiel) {
  print qq(</tr><tr bgcolor=$cold[$bndx]><td bgcolor="#03071B" width="8%"><pre>), substr($fiel[$bndx], 0, 1), qq(:$fldz[$bndx]</pre></td>\n);
  for(0..63) {
    if   ($bndx < @fldz && $_ <= b10($fldz[$bndx])) { print  '<td'                           , ">&nbsp;</td>\n"; }
    elsif(!param('fr')  && $_ <=     $rang[$bndx] ) { print  '<td bgcolor=', $cold[$bndx + 7], ">&nbsp;</td>\n"; }
    else                                            { print q(<td bgcolor="#000000"),          ">&nbsp;</td>\n"; }
  }
} print '</tr></table></body></html>';
