#!/usr/bin/perl
# 267BPZA - 
# 42DBZGb - script written to auto backup a file into './.bak/' with a
#   -`pt` appended before extension or at end if none.  Made for 4NT shell
#   (adapted from GNU/Linux tool of same name) by Pip Stuart <Pip@CPAN.Org>
# 77O3wVc - updated for CygWin to have slash/ dir-separators instead of bak\
# 2do:
#   handle spaces in filenames
#   use Time::PT when it's ready
use strict;
use File::Copy qw(cp);
my $srcf = shift || $ENV{'editfile'} || ''; # EDTF
my $cmsp = shift || $ENV{'COMSPEC' } || ''; my $dsep = '/'; my $tmpd;
my $dstf; my $pktm = `pt` ; chomp($pktm); my $extn; my @tsts; my $pass;
$dsep = q(\\\\) if($cmsp !~ /cmd\.exe$/i);
if($srcf eq '*') {
  unshift(@ARGV, $_) for(glob("*.*"));
  $srcf = shift;
}
die "!*EROR*! Please pass bak a filename to backup!\n" unless(-r $srcf);
unless(-d '.bak') {
  mkdir('.bak') || die "!*EROR*! Couldn't create '.bak' directory!\n";
}
unless(-w '.bak') {
                   die "!*EROR*! Cannot write to '.bak' directory!\n";
}
while($srcf) {
  if(-f $srcf && -r $srcf) {
    $dstf = $srcf;
    $extn = '';
    if($dstf =~ s/^(.+)(\..{1,4}|\.xhtml)$/$1/) { # strip file extension
# *note* I can't think of any extensions I want to support longer than 4 chars.
      $extn  = $2;
      if($dstf =~ s|^\.tar$||) { # put -`pt` before .tar.(gz|bz2) also
        $extn  = ".tar" . $extn;
      }
    }
    if($dstf =~ m|$dsep|) { $dstf =~ s|(.*)$dsep|$1$dsep.bak$dsep|; }
    else                  { $dstf =~ s|^|.bak$dsep|;                }
    @tsts = reverse(sort(glob($dstf . "-???????" . $extn)));
    $pass = 1;
    if(@tsts) { # test last 3 backups for differences before proceeding
      @tsts = @tsts[0..2] if(@tsts > 3);
      for(@tsts) {
        if($dsep eq '/') { $pass = `diff --brief $_ $srcf`; }
        else             { $pass = `fc           $_ $srcf`;
          $pass = '' if($pass =~ /\nFC: no differences encountered\n/); }
        if($pass) { $pass = 1; }
        else      { $pass = 0;
#          $_    =~ s/(.*)-(.)(.)(.)(.)(.)(.)(.)/$1-\e[1;31m$2\e[0;33m$3\e[1;33m$4\e[1;32m$5\e[1;36m$6\e[1;34m$7\e[1;35m$8\e[1;32m/;
          printf("!*EROR*! File: '%-16s already bak'd up as '$_'!\n", $srcf . "'");
          last;
        }
      }
    }
    if($pass) {
      $dstf .= "-$pktm" . $extn;
      cp($srcf, $dstf);
      if($dsep eq '/') { $pass = `diff --brief $srcf $dstf`;
        $pass = 1 if($pass eq ''); }
      else             { $pass = `fc           $srcf $dstf`;
        $pass = 1 if($pass =~ /\nFC: no differences encountered\n/); }
        $pass = 0 if($pass != 1);
      $tmpd = $dstf; $tmpd =~ s|\\|| if($dsep ne '/');
      if(-e $dstf) {
        if($pass) { # SUCCESS!
#          $dstf =~ s/(.*)-(.)(.)(.)(.)(.)(.)(.)/$1-\e[1;31m$2\e[0;33m$3\e[1;33m$4\e[1;32m$5\e[1;36m$6\e[1;34m$7\e[1;35m$8\e[1;32m/;
          printf("bak'd up: '%-16s as '$tmpd'\n", $srcf . "'"); 
        } else {    # FAILED `diff`
          printf("!*EROR*! File: '%-16s differs from '$tmpd'!\n", $srcf . "'");
        }
      } else {      # FAILED output-file-creation or something else
        printf("!*EROR*! Couldn't bak up: '%-16s as '$tmpd'\n", $srcf . "'");
      }
    }
  } $srcf = shift;
}
