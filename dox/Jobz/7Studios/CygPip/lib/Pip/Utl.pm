# 4BR6kpc - Pip::Utl.pm created by Pip Stuart <Pip@CPAN.Org> to centralize my personal utility programs.
package Pip::Utl;
require Exporter;
use strict;
#use warnings;
use base qw(Exporter); # load the following modules if available
eval('use File::Copy                                           qw(cp mv);');
eval('use Pod::Text;'                                                     );
eval('use Math::BigInt'                                                   );
eval('use Math::BaseCnv                                         qw(:all);');
eval('use Games::Cards::Poker                                   qw(:all);');
eval('use Time::DayOfWeek                                       qw(:all);');
eval('use Time::PT;'                                                      );
eval('use Curses::Simp;'                                                  );
eval('use XML::Tidy;'                                                     );
eval('use XML::Merge;'                                                    );
our @EXPORT      = ('e', 'bak', 'updt',                    'shuf', # dvl utl
                    'asci', 'calc', 'qolm', 'syncdate', 'vollabel',# cli utl
                    'ftst', 'forfiles', 'dum2umd', 'readhead',     # flz utl
                    'cdx', 'frip', 'foggsync',                     # muz utl
                    'scal', 'shot', 'cfdd',                        # img utl
                    'timerun', 'runbench',                         # tim utl
                    'bcho',                                        # mth utl
                    'domserch',                                    # dom utl
                    'tild', 'curs',                                # Unx utl
                    'coma', 'left', 'rght', 'tolo', 'genbats',     # 4NT utl
                    'tiglet', 'lspt', 'fpt', 'reso', 'critarch',   # other
                   );
our $VERSION     = '1.0.776J9Pl'; our $PTVR = $VERSION; $PTVR =~ s/^\d+\.\d+\.//; # Please see `perldoc Time::PT` for an explanation of $PTVR.
sub calc { # 5575iid - calc created to use Perl as a quick cmd-line calculator
  print(eval(join(' ', @_))); # was alias cln basically wrapping raw `perl`
}
sub coma { # 315F0ZS - coma created to add commas to long number strings
  my $strn = shift; my $comc = shift || ","; my $blok = shift || 3;
  unless(defined($strn) && $strn) { $strn .= $_ while(<STDIN>); }
  if(defined($strn) && $strn) {
    $strn = reverse($strn); $strn =~ s/(.{$blok})/$1$comc/g;
    $strn = reverse($strn); $strn =~ s/^$comc//; return($strn);
  }
  # from PerlFAQ5 @ HTTP://Perl.Com/doc/manual/html/pod/perlfaq5.html#How_can_I_output_my_numbers_with
  local $_ = shift; 1 while s/^(-?\d+)(\d{3})/$1,$2/; return $_; # You can't just: s/^(-?\d+)(\d{3})/$1,$2/g; cuz must put coma in, then recalc pos
  # && from Andrew Johnson <AJohnson@GPU.Srv.UAlberta.Ca> this comafies all numbs in line whether||! have decimal parts, are preceded by + or -, or whatever:
  my $inpt = shift; $inpt = reverse $inpt; $inpt =~ s<(\d\d\d)(?=\d)(?!\d*\.)><$1,>g; return reverse $inpt; # 2do: study this regex!
}
sub tild { # translating tildes (~) in filenames (also from PerlFAQ5)
  # use <> (glob()) operator w/ shell that groks tildes or try Glob::KGlob || File::HomeDir instead of straight Perl below:
  my $filn = shift; $filn =~ s/^~([^\/]*)/$1 ? (getpwnam($1))[7] : ( $ENV{'HOME'} || $ENV{'LOGDIR'} )/ex; return($filn); # Eval replacement && Xtra spaces
}
sub left { # gets the  left-most X characters of a string
  my $coun = shift; my $strn = shift; if(defined($strn) && defined($coun) && $coun =~ /^\d+$/) { return(substr($strn,      0, $coun)); } else { return(''); }
}
sub rght { # gets the right-most X characters of a string
  my $coun = shift; my $strn = shift; if(defined($strn) && defined($coun) && $coun =~ /^\d+$/) { return(substr($strn, -$coun, $coun)); } else { return(''); }
}
sub asci { # 2BNCDfo - asci created to print all ASCII characters
  my $optz = shift() || ''; my $strt = 32; $strt = 0 if($optz =~ /a/);
  for(my $indx = $strt; $indx < 256; $indx++) { 
    print "\n" unless($indx % 32 || $indx == 32);
    unless($indx % 8) { my $hexa = hex($indx); printf("   %03d:%2s:", $indx, $hexa); } # my Math::BaseCnv::hex() which hexifies, !Perl's which decifies.
    printf("%1s", chr($indx));
  } print "\n";
# !*NOTE*! Windows treats ASCII 26 (Ctrl-Z) as EOF!  Ctrl lines replaced w/ just txt-vers of their vim appearance here to avoid that problem
  #   000: 0:^@^A^B^C^D^E^F^G   008: 8:^H^I ^K^L^M^N^O   016:10:^P^Q^R^S^T^U^V^W   024:18:^X^Y^Z^[^\^]^^^_   
  #   032:20: !"#$%&'   040:28:()*+,-./   048:30:01234567   056:38:89:;<=>?
  #   064:40:@ABCDEFG   072:48:HIJKLMNO   080:50:PQRSTUVW   088:58:XYZ[\]^_
  #   096:60:`abcdefg   104:68:hijklmno   112:70:pqrstuvw   120:78:xyz{|}~^?
  #   128:80:~@~A~B~C~D~E~F~G   136:88:~H~I~J~K~L~M~N~O   144:90:~P~Q~R~S~T~U~V~W   152:98:~X~Y~Z~[~\~]~^~_
  #   160:A0:| ¡¢£¤¥¦§   168:A8:¨©ª«¬­®¯   176:B0:°±²³´µ¶·   184:B8:¸¹º»¼½¾¿
  #   192:C0:ÀÁÂÃÄÅÆÇ   200:C8:ÈÉÊËÌÍÎÏ   208:D0:ÐÑÒÓÔÕÖ×   216:D8:ØÙÚÛÜÝÞß
  #   224:E0:àáâãäåæç   232:E8:èéêëìíîï   240:F0:ðñòóôõö÷   248:F8:øùúûüýþÿ
  #
  #   !"#$%&' ()*+,-./ 01234567 89:;<=>?
  #  @ABCDEFG HIJKLMNO PQRSTUVW XYZ[\]^_
  #  `abcdefg hijklmno pqrstuvw xyz{|}~^?
  #  ~@~A~B~C~D~E~F~G ~H~I~J~K~L~M~N~O ~P~Q~R~S~T~U~V~W ~X~Y~Z~[~\~]~^~_
  #  | ¡¢£¤¥¦§ ¨©ª«¬­®¯ °±²³´µ¶· ¸¹º»¼½¾¿
  #  ÀÁÂÃÄÅÆÇ ÈÉÊËÌÍÎÏ ÐÑÒÓÔÕÖ× ØÙÚÛÜÝÞß
  #  àáâãäåæç èéêëìíîï ðñòóôõö÷ øùúûüýþÿ
}
sub bak { # 267BPZA - auto-backup a file into './.bak/' with a -`pt` appended before the extension or at the end if none.
  # 2do: refactor ~/.erc searching code from bak&&e,add -optz lsb LiStBakz,bkd parm2tst isBkDup?,dif w/prev,re[sv] RE(Store|Vert2) prev,ifc 2onlyBakIfSrcCmpilz
  #   detect $^O OS Type&&use `cd`&&`fc.exe` 4 MSWin,hndl flnmz =~ /\s/,tst
  my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); # at least assume 4NT shell
  my $ttyn = $ENV{'TTY'} || $ENV{'_SHELL'} || ''; $ttyn = shift || '' unless(length($ttyn));
  my $srcf = shift ||  $ENV{'EDTF'} || $ENV{'EDITFILE'} || ''; my $dstf; my $home = $ENV{'HOME'} || '/home/pip';
  $home = 'C:\\home\\pip' if($osty ne 'good' && $home eq '/home/pip'); $home =~ s/[\\\/]$//; my $cwdr;
  if(length($ttyn)) {
    if   ($ttyn =~ /^(\/dev\/(tty|vc\/))/) { $ttyn =~ s/^$1//;  }
    elsif($ttyn =~ /^(\/dev\/pts\/)/     ) { $ttyn =~ s/^$1/x/; }
    elsif(!length($srcf))                  { $srcf = $ttyn;     }
  }
  unless(-d $home . '/.erc') {
    mkdir(  $home . '/.erc', 0700); system("attrib /d +h $home/.erc") if(-d $home . '/.erc' && $osty ne 'good');
  }
  if(-d $home . '/.erc') {
    my $ercg = $home . '/.erc/eall';      # Global .erc/eall  filelist
    my $ercl = $home . '/.erc/e' . $ttyn; # Local  .erc/e$TTY filelist
    if($osty eq 'good') { $cwdr = `pwd`; }
    else                { $cwdr =  `cd`;
      if($srcf eq  '*') { unshift(@ARGV, $_) for(glob("*.*")); $srcf = shift; }
    }
    chomp($cwdr);
    my $pktm = Time::PT->new(); chomp($pktm); my $extn; my @tsts; my $pass;
    if(!-r $srcf && -r $ercl && open(ERCL, '<', $ercl)) { chomp($srcf = <ERCL>); close(ERCL); }
    if(!-r $srcf && -r $ercg && open(ERCG, '<', $ercg)) { chomp($srcf = <ERCG>); close(ERCG); }
    die "!*EROR*! Please pass bak a filename to backup!\n" unless(-r $srcf);
    unless(-d '.bak') { mkdir('.bak') || die "!*EROR*! Couldn't create '.bak' directory!\n"; }
    unless(-w '.bak') {                  die "!*EROR*! Cannot write to '.bak' directory!\n"; }
    system('attrib /d +h .bak') unless($osty eq 'good');
    while($srcf) {
      if(-f $srcf && -r $srcf) { $dstf = $srcf; $extn = '';
        if($dstf =~ s/^(.+)(\..{1,4})$/$1/) { $extn  = $2;  # strip file extension  !*Note*! Are there any extensions >4 chars worth supporting?  Not so far.
          $extn  = ".tar" . $extn if($dstf =~ s/^\.tar$//); # special-case to put -`pt` before .tar.(gz|bz2) also
        }
        if($dstf =~ /\//) { $dstf =~ s/(.*)\//$1\/.bak\//; } else { $dstf =~ s/^/.bak\//; }
        unless($osty eq 'good') { $srcf =~ s/\//\\/g; $dstf =~ s/\//\\/g; } # kaka dir-separators?
        @tsts = reverse(sort(glob($dstf . "-???????" . $extn))); $pass = 1;
        if(@tsts) { @tsts = @tsts[0..2] if(@tsts > 3); # test last 3 backups for differences before proceeding
          for(@tsts) { 
            if($osty eq 'good') { $pass = `diff --brief $_ $srcf`;
              unless($pass)                                 { $_    =~ s/^$cwdr[\\\/]//; $srcf =~ s/^$cwdr[\\\/]//;
                $_    =~ s/(.*)-(.)(.)(.)(.)(.)(.)(.)/$1-\e[1;31m$2\e[0;33m$3\e[1;33m$4\e[1;32m$5\e[1;36m$6\e[1;34m$7\e[1;35m$8\e[1;32m/;
                printf("!*EROR*! File: '%-16s already bak'd up as '%s'!\n", $srcf . "'", $_); last;
              }
            } else              { $pass = `fc           $_ $srcf`;
              if($pass =~ /FC: no differences encountered/) { $_    =~ s/^$cwdr[\\\/]//; $srcf =~ s/^$cwdr[\\\/]//; # 2do: tap into Time::PT to get colors
  #              $_    =~ s/(.*)-(.)(.)(.)(.)(.)(.)(.)/$1-& color 0c & echos $2 & color 06 & echos $3 & color 0e & echos $4 & color 0a & echos $5 & color 0b & echos $6 & color 09 & echos $7 & color 0d & echos $8 & color 0a & echos /;
  # & color 0c & echos 4 & color 06 & echos C & color 0e & echos K & color 0a & echos 0 & color 0b & echos a & color 09 & echos 2 & color 0d & echos V
                printf("!*EROR*! File: '%-16s already bak'd up as '%s'!\n", $srcf . "'", $_); last;
              } else { $pass = 1; } # set pass to simple truth since files were different
            }
          }
        }
        if($pass) { $dstf .= "-$pktm" . $extn;     cp($srcf,$dstf);
          if($osty eq 'good') { $pass = `diff --brief $srcf $dstf`; if(length($pass))                             { $pass = 0; } else { $pass = 1; } }
          else                { $pass = `fc           $srcf $dstf`; if($pass !~ /FC: no differences encountered/) { $pass = 0; } else { $pass = 1; } }
          $srcf =~ s/^$cwdr[\\\/]//; $dstf =~ s/^$cwdr[\\\/]//;
          if(-e $dstf) {
            if($pass) { # SUCCESS!
              if($osty eq 'good') { $dstf =~ s/(.*)-(.)(.)(.)(.)(.)(.)(.)/$1-\e[1;31m$2\e[0;33m$3\e[1;33m$4\e[1;32m$5\e[1;36m$6\e[1;34m$7\e[1;35m$8\e[1;32m/; }
              else                { }#$dstf =~ s/(.*)-(.)(.)(.)(.)(.)(.)(.)/$1-& color 0c & echos $2 & color 06 & echos $3 & color 0e & echos $4 & color 0a & echos $5 & color 0b & echos $6 & color 09 & echos $7 & color 0d & echos $8 & color 0a & echos /; }
                     printf("bak'd up: '%-16s as '%s'\n",                 $srcf . "'", $dstf); 
            } else { printf("!*EROR*! File: '%-16s differs from '%s'!\n", $srcf . "'", $dstf); } # FAILED `diff`
          } else   { printf("!*EROR*! Couldn't bak up: '%-16s as '%s'\n", $srcf . "'", $dstf); } # FAILED output-file-creation or something else
        }
      } $srcf = shift;
    }
  } else           { print( "!*EROR*! Couldn't find ~/.erc/ at: '$home/.erc/'\n"); }
}
sub ftst { # 37M06SK - utility to run through Perl File TeSTs on its parameter or the file piped or typed into it from StdIn
  my $file = shift || 'STDIN'; my @oper = ( 'r', 'readable',           'w', 'writable',
                                            'x', 'executable',         'o', 'owned',
                                            'R', 'readable by real',   'W', 'writable by real',
                                            'X', 'executable by real', 'O', 'owned by real',
                                            'e', 'exists',             'z', 'zero size',
                                            's', 'size',               'f', 'file',
                                            'd', 'directory',          'l', 'link',
                                            'p', 'named pipe (FIFO)',  'S', 'socket',
                                            'b', 'block special file', 'c', 'character special file',
                                            't', 'tty',                'u', 'setuid bit',
                                            'g', 'setgid bit',         'k', 'sticky bit',
                                            'T', 'Text',               'B', 'Binary',
                                            'M', 'age of file in days since Modification',
                                            'A', 'age of file in days since last Access',
                                            'C', 'age of file in days since mode Change',            );
  for(my $i=0; $i<@oper; $i+=2) {                                                    print '(-'  ,"$oper[$i] $file) == (";
    if($oper[$i] =~ /[TB]/) { print           "Can't test! except in MS Windows?"; }
    else                    { eval("(-$oper[$i] \'$file\') ? print 1 : print 0;"); } print ') : ', $oper[$i+1],      "\n";
  }
}
sub cfdd { # 776EPNb - tk a dir param containing subdirs of form .+-PipTime which should have all contents compared to Consolidate Files, Discarding Duplicates
  my $srcd = shift || './'; $srcd =~ s/[\\\/]+$/\//; my %filz; my %namz; my $pass; my $size; my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); #assume4NT
  die "!*EROR*! Please pass $0 a directory name to consolidate files under!\n" unless(-d $srcd); $srcd =~ s/\//\\/g unless($osty eq 'good'); # kaka dir-separs?
  for(glob($srcd . '**/*')) { $pass = 1; $size = -s; #printf("TstF:size:%10d name:$_...\n", $size);
    if(exists($filz{$size})) {
      for my $file (keys(%{$filz{$size}})) {
        if($osty eq 'good') { $pass = `diff --brief $_ $file`;
          unless($pass)                                 {       printf("!*WARN*! Already found file:'$_'!\n"); last; }
        } else              { $pass = `fc           $_ $file`;                                      # set pass to simple truth below since files were different
          if($pass =~ /FC: no differences encountered/) {       printf("!*WARN*! Already found file:'$_'!\n"); last; } else { $pass = 1; }
        }
      }
    }
    if($pass) {
      if(/^\.\/pix-KRZR-(\w{7})\//) { my $pipt = '776DDNN'; # 776JVCL: custom KRZR pix matching for consolidation
        #my $ptim = $1; if($ptim ne $pipt) { my $srcf = $_; s/^(\.\/pix-KRZR-)$ptim\//$1$pipt\//; mv($srcf,$_); print "mv($srcf,$_);\n"; }
      } $filz{$size}{$_} = 1;
    }
  }
  for(keys(%filz)) { for my $file (sort(keys(%{$filz{$_}}))) { $namz{$file} = 1; delete($filz{$_}{$file}); } }
  print "\n\nUnique files:\n",join("\n",sort(keys(%namz))),"\n";
}
sub updt { # 58LNk1v - update most recent .pm file into '~/lib/'
  # 2do: might not want to cp all -x files to ~/bin since CygWin mkz .pmz +x
  my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); # at least assume 4NT shell
  my $ttyn = $ENV{'TTY'} || $ENV{'_SHELL'} || ''; $ttyn = shift || '' unless(length($ttyn));
  my $srcf = shift || $ENV{'EDTF'} || $ENV{'EDITFILE'} || ''; my $dstf;my $home = $ENV{'HOME'} || '/home/pip';
  $home = 'C:\\home\\pip' if($osty ne 'good' && $home eq '/home/pip'); $home =~ s/[\\\/]$//; my $cwdr;
  if(length($ttyn)) {
    if   ($ttyn =~ /^(\/dev\/(tty|vc\/))/) { $ttyn =~ s/^$1//;  }
    elsif($ttyn =~ /^(\/dev\/pts\/)/     ) { $ttyn =~ s/^$1/x/; }
    elsif(!length($srcf))                  { $srcf = $ttyn;     }
  }
  unless(-d $home . '/.erc') { mkdir($home . '/.erc', 0700);
    system("attrib /d +h $home/.erc") if(-d $home . '/.erc' && $osty ne 'good');
  }
  if(-d $home . '/.erc') {
    my $ercg = $home . '/.erc/eall';      # Global .erc/eall  filelist
    my $ercl = $home . '/.erc/e' . $ttyn; # Local  .erc/e$TTY filelist
    if($osty eq 'good') { $cwdr = `pwd`; }
    else                { $cwdr =  `cd`; if($srcf eq  '*') { unshift(@ARGV, $_) for(glob("*.pm")); $srcf = shift; } }
    chomp($cwdr);
    my $pktm = Time::PT->new(); chomp($pktm); my $extn; my @tsts; my $pass;
    if(!-r $srcf && -r $ercl && open(ERCL, '<', $ercl)) { chomp($srcf = <ERCL>); close(ERCL); }
    if(!-r $srcf && -r $ercg && open(ERCG, '<', $ercg)) { chomp($srcf = <ERCG>); close(ERCG); }
    while($srcf) {
      die "!*EROR*! Please pass updt filenames of readable .pm or +x files to install!\n" unless(-r $srcf && (-x $srcf || $srcf =~ /\.pm$/));
      if(-x $srcf) { print "updt $srcf -> $home/bin/...\n";       cp($srcf, "$home/bin/"     ); }     # && cp file
      else { my $dirn; open(SRCF, '<', $srcf); # read module package path && construct ~/lib dirs necessary
        while(<SRCF>) {
          if(/^package\s+([^;]+);/i) { my $pkgn = $1; my $filn; $dirn = $pkgn; $dirn =~ s/::/\//g; 
            if($dirn =~ s/\/([^\/]+)\/?$//) { $filn = $1; }
            if(defined($filn) && $srcf =~ /$filn\.pm$/) {   system("mkdir -p $home/lib/$dirn"); last; } # -p will create Parent directories on a good OS
          }
        }
        close(SRCF); print "updt $srcf -> $home/lib/$dirn/...\n"; cp($srcf, "$home/lib/$dirn");       # && cp file
      } $srcf = shift;
    }
  } else { print("!*EROR*! Couldn't find ~/.erc/ at: '$home/.erc/'\n"); }
}
sub cdx { # Pipz CDXtraction script `cdx <directory> <title>`
  my $mp3d = shift || ''; $mp3d =~ s/-$//; $mp3d = 'mp3/' . $mp3d; my $file = ''; my $mp3f = '';
  my $titl = shift || ''; $titl =~ s/_$//; unless($titl) { $titl = $mp3d; $mp3d = "mp3/unsorted"; }
  system("cdparanoia -B -- '1-'"); # rip the whole cd
  for my $file (glob("*.wav")) {   # turn all the .wav'z to .mp3'z
    $mp3f = $file; $mp3f =~ s/\.wav$/\.mp3/;
    if($titl) { $mp3f = ''; unless($mp3d eq "mp3/unsorted") { $mp3f = $mp3d . "-"; $mp3f =~ s/^mp3\///; }
      if($file =~ /^track(\d+)/) { $mp3f .= $titl . "_" . $1 . ".mp3"; }
    }
  #  print "lame --r3mix -b 256 $file $mp3f\n";
  #  print "lame -b 256 -h -m s $file $mp3f\n";
    system("lame -b 256 -h -m s $file $mp3f"); unlink($file);
    system("mkdir -p \"$mp3d/$titl\"") unless(-d "$mp3d/$titl");
    system("mv $mp3f ${mp3d}/${titl}");
  }
}
sub domserch { # find all short unused domains # Params: StringLengths2Test, #ofIncrementalTests, Start# : 34,1258,1294
  my $logf = "freedomz.txt";
  my @tldz = ("Com", "Net", "Org");
  my @chrz = ('0'..'9', 'a'..'z' );
  my $dlim = shift || 3;
  my $limt = shift || scalar(@chrz)**$dlim; # 4
  my $strt = shift || 0;
  my $test = ""; my $rslt = ""; my $temp = ""; 
  my $digt = @chrz; $digt = $digt**$dlim;
  $strt %= $digt; if ($limt > ($digt - $strt)) { $limt = $digt - $strt; }
  print "Starting: $strt Ending: $limt...\n";
  while ($strt < $limt) {
    my $tstr = $strt; $test = "";
    for(my $l=1;$l<$dlim;$l++) {
      if($tstr > $#chrz) {
        $digt = $tstr - (int($tstr / ($#chrz+1)) * ($#chrz+1));
        $test = $chrz[$digt] . $test;
        $tstr /= ($#chrz+1);
      }
    }
    $test = $chrz[$tstr] . $test;
    while(length($test) < $dlim) { $test = $chrz[0] . $test; } #print "$test,"; 
    for(@tldz) { $rslt = `whois $test.$_`;
      if($rslt =~ /No match for "$test/i) { open(LOGF, '>>', $logf); print LOGF "$test.$_\n"; close(LOGF); }
    } $strt++; #print ".";
  } open(LOGF, '>>', $logf); print LOGF "Completed $limt!\n"; close(LOGF);
}
sub qolm {
  my $dfil = shift || "freedmz3.txt"; my $line = ''; my $poop = 0; my $limt = shift || 0; #256
  open(DFIL, '<', $dfil);
  while(<DFIL>) {
    $_ =~ s/(\.Org|\n)//g;
    if((length($line) + length($_) + 1) > 80) { print "$line\n"; $line = ''; }
    else { $line .= "$_ "; } $poop++; last if($limt && $poop > $limt);
  }
  close(DFIL);
}
sub dum2umd {
  my($auth,$vers,$name)=('Pip@CPAN.Org','37VB1xa','dum2umd');
  # 1CKLhG0 - dum2umd created by Pip@CPAN.Org to replace dtou.exe && utod.exe because they choke on ascii 26 (Ctrl-Z == EOF in normal
  #   Win32 ie. w/o binmode).  Old utils clobbered a bunch of my files =( ... I knew Perl could do better =)
  # 23FBRE0 - added 's' parameter to turn all double newlines into singles
  # Usag: 1st param is file to convert.  Optional 2nd param is "d" or "m" for Dos or Mac formatted EndOfLines.  Empty 2nd param does Unix format.
  # Note: No intermediate file is used so you need enough RAM to store the whole file in a scalar.  Expect problems if you try this util on a huge text file.
  my $flnm = shift || '-h'; my $rslt = shift || 'u'; my $oopt = shift || '';
  my $coun = 1; my $snrf = ''; 
  ($flnm, $rslt) = ($rslt, $flnm) if(-e $rslt);
  ($flnm, $oopt) = ($oopt, $flnm) if(-e $oopt);
  if($rslt =~ /^-*s$/i) { $coun = 2; $rslt = $oopt; }
  if($oopt =~ /^-*s$/i) { $coun = 2; }
  if($flnm =~ /^-*[h?](elp)?$/i || $rslt =~ /^-*[h?](elp)?$/i) { # print help
    print "Usage: $name FILE [OPTIONS]
  Convert newline characters between different common formats.
                                                           hex  dec    oct
        -u  convert newlines in FILE to UNIX format (  LF) ( A) (  10) (  12)
        -m  convert newlines in FILE to MAC  format (CR  ) (D ) (13  ) (15  )
        -d  convert newlines in FILE to DOS  format (CRLF) (DA) (1310) (1512)
        -s  convert double newlines in FILE to SINGLES
        -h  display this help and exit
  
    $name vers:$vers by auth:$auth
  "; return();
  }
  return() unless(-e $flnm);
  open(FILE, '<', $flnm); binmode(FILE); $snrf = join '', <FILE>; close(FILE);
  if   (lc($rslt) =~ /^-*d/i) { $snrf =~ s/(\015\012|\015|\012){$coun}/\015\012/g; } # Dos             1512 CRLF
  elsif(lc($rslt) =~ /^-*m/i) { $snrf =~ s/(\015\012|\015|\012){$coun}/\015/g;     } # Mac             15   CR
  else                        { $snrf =~ s/(\015\012|\015|\012){$coun}/\012/g;     } # (Uni|GNU/Linu)x   12   LF
  open(FILE, '>', $flnm); binmode(FILE); print FILE $snrf;        close(FILE);
}
sub e {
  my($auth,$vers,$name)=('Pip@CPAN.Org','1.0.77PLr7I','e');
  # 398GX2X - e created by Pip@CPAN.Org to manage file editing
  # 2do:
  #   refactor ~/.erc/ searching code from e,bak,updt,cfdd w/ ~/.erc/* in ~/.e/
  #   mv .erc/.erc ..
  #   add kwalitee:
  #    - has_proper_version: remove letters? nah
  #    + has_changelog: need 'CHANGES' file to dup CHANGES section
  #    + has_test_pod: needs test using Test::Pod to ck correctness
  #    + has_test_pod_coverage: needs test using Test::Pod::Coverage
  #    + no_pod_errors: fix them
  #    + has_meta_yml: need 'META.yml' (auto through buildtool?) mk conform to latest spec: HTTP://Module-Build.SF.Net/META-spec-current.html
  #    + has_example: file|dir e[gx]|demo w/ use cases (warn if !-e)
  #    + dump SYNOPSIS to ex/synopsis.pl if !-e xmpl
  #    + gen t/00podc.t w/ "use Test::Pod::Coverage 'tests' => '1'; pod_coverage_ok('fULnAME', 'POD Covered');"
  #   ck if test.pl (&&!t/*.t) && mv to t/01test.t
  #   study Module::Build && use it instead of e (or at least learn from it)
  #   add gen of cmd-line wrappers
  #   add dvl shortcuts (or path searching with globs?)
  #   once new Simp works, mk `e dvl` bring up proj selector
  # Notz:
  #   OOP (Conway) p.96 minimum class documentation:
  #   * name && purpose
  #   * version of class documentation documents
  #   * synopsis of how to use class
  #   * more extensive description of class usage including:
  #     - creation details
  #     - (both object && class) methods available
  #     - special features
  #     - limitations
  #   * diagnostics list with descriptions && known error conditions
  #       which cannot be diagnosed
  #   * environment variables that can (or must) be used
  #   * other modules needed && how to get them if not via CPAN
  #   * bugs && suggested workarounds
  #   * cross-references to any other relevant documentation
  #   * copyright notice
  #   * name && contact details of author(s)
#  =head1 NAME
#    Full::Class::Name - one line summary of purpose of class
#  =head1 VERSION
#    This document refers to version N.NN of Full::Class::Name,
#      released MMMM DD, YYYY.
#  =head1 SYNOPSIS
#    # Short examples of Perl code that illustrate the use of the class
#  =head1 DESCRIPTION
#  =head2 Overview
#  =head2 Constructor && initialization
#  =head2 Class && object methods
#  =head2 Any other important information
#  =head1 ENVIRONMENT
#    List of environment variables && other O/S related information
#      on which the class relies
#  =head1 DIAGNOSTICS
#  =over 4
#  =item "eror message that may appear"
#    Explanation of message
#  =item "another eror message that may appear"
#    Explanation of another message
#  ...
#  =back
#  =head1 BUGS
#    Description of known bugs (&& any work-arounds).
#    Usually also includes an invitation to send the author bug reports.
#  =head1 FILES
#    List of any files or other Perl modules needed by the class && a
#      brief explanation why.
#  =head1 SEE ALSO
#    Cross-references to any other relevant documentation.
#  =head1 AUTHOR(S)
#    Name(s) <e-mail address(es)>
#  =head1 COPYRIGHT
#    Copyright (c) YYYY(s), Author(s).  All Rights Reserved.
#    This module is Free Software.  It may be used under the terms of the
#    GNU GPL version 2.
#  =cut
  my $verb = 1; # verbose  flag
  my $dbug = 0; # debug    flag
  my $skip = 0; # skip     flag
  my $mkfl = 1; # makefile flag
  my $bdfl = 1; # Build.PL flag
  my $bdfn = 'Build.PL'; # Build.PL filename (removing the dot will stop make from picking it up)
  my $edit = $ENV{'EDITOR'};
  my $home = $ENV{'HOME'};
  my $ttyn = $ENV{'TTY'} || ''; 
     $ttyn =     shift() || '' unless(length $ttyn);
  my $file =     shift() || ''; my $optn;
  if(length($ttyn)) {
    if   ($ttyn =~ /^(\/dev\/(tty|vc\/))/) { $ttyn =~ s/^$1//;  }
    elsif($ttyn =~ /^(\/dev\/pts\/)/     ) { $ttyn =~ s/^$1/x/; }
    elsif(!length($file))                  { $file = $ttyn;     }
  }
  my $ercl = $home . '/.erc/e' . $ttyn; # Local  .erc/e$TTYN filelist
  my $ercg = $home . '/.erc/eall';      # Global .erc/eall   filelist
  my $cwdr = `pwd`; chomp($cwdr);
  my %pref =('gl'   => $ercg, # Global file List (eall  )
             'll'   => $ercl, #  Local file List (e$ttyn)
             'rc'   => '~/.erc/.erc',
             'a'    => '~/.zshrc',
             'z'    => '~/.zshrc',
             'v'    => '~/.vimrc',
             'h'    => '~/.history',
             'p'    => '~/dox/phonbook.txt',
             't'    => '~/dox/2do/Taki.txt',
             '2'    => '~/dox/2do/2do.txt');
  if(-r "$home/.erc/.erc") {
    open(ERCF, '<', "$home/.erc/.erc");
    while(<ERCF>) {
      my @eflz = split();
      if(@eflz == 2 && defined($eflz[0]) && length($eflz[0]) && $eflz[0] !~ /^#/ &&
                       defined($eflz[1]) && length($eflz[1])) { $pref{$eflz[0]} = $eflz[1]; }
    }
    close(ERCF);
  }
  my $escf = $file; $escf =~ s/([\.\(\)\s])/\\$1/g;
  my @srch =(qr/^.*\/$escf/,
             qr/^.*\/.*$escf/,
             qr/$escf/,
             qr/dvl\/.*$escf/);
  my %podr =('name' => qr/NAME/, 
             'vers' => qr/VERSION/, 
             'syno' => qr/SYNOPSIS/, 
             'desc' => qr/DESCRIPTION/, 
             'lice' => qr/(LICENSE|COPYRIGHT)/, 
             'auth' => qr/AUTHOR.?/ );
  my %pkgd = (); my @ldat = (); my @gdat = (); my @pkgz = ();
  if(-r $ercl && open(ERCL, '<', $ercl)) { chomp(@ldat = <ERCL>); close(ERCL); }
  if(-r $ercg && open(ERCG, '<', $ercg)) { chomp(@gdat = <ERCG>); close(ERCG); }
  my $line = '';
  mkdir("$home/.erc", 0700) unless(-d "$home/.erc"); # mk sure ~/.erc/
  if(!length($file) || $file =~ /^(l+|g+)$/) {
    if(@gdat && (!@ldat || $file =~ /^g+$/)) {
      if   (        !length($file)) { $file = $gdat[0];  }
      elsif(@gdat <= length($file)) { $file = $gdat[-1]; }
      else { $file = splice(@gdat, length($file), 1);    }
    } elsif(@ldat) {
      if   (        !length($file)) { $file = $ldat[0];  }
      elsif(@ldat <= length($file)) { $file = $ldat[-1]; }
      else { $file = splice(@ldat, length($file), 1);    }
    }
  }
  if(exists $pref{$file}) { $file = $pref{$file}; $file =~ s/~/$home/; }
  if     ($file eq 'dvl') { system('cd ~/dvl; ls'); # 'dvl' file case
  } elsif($file eq 'up' ) { updt();                 # 'up'  file case to update ~lib|bin
  } elsif($file eq 'pkg') {                         # 'pkg' file case
  # Possible to ck Perl's $^O for OS info.
  #So generation (through `e pkg`) should:
    $pkgd{'fail'} = 1;
  # read optional specified pt version
    $optn         = shift() || undef;
  #  0) read shift().pm or last edited local for path holding .pm && MANIFEST
    $pkgd{'wich'} = shift() || '';
  # set abstract string to initially empty
    $pkgd{'abst'} =            '';
  #  1) obtain pIPtIME from $optn parameter or current system `pt`;
    $pkgd{'ptim'} = Time::PT->new();                         # get current  pt()
    $pkgd{'ptim'} = Time::PT->new('str' => $optn) if($optn); # get optional pt()
    $pkgd{'ptpt'} = $pkgd{'ptim'}->expand(); # get expanded current pt()
    # do special checks on wich to qualify valid packages or match wich first
    unless(length($pkgd{'wich'}) && -r $pkgd{'wich'}) {
      unless(-r $pkgd{'wich'}) { for(@ldat) { if(/\.pm$/)  { $pkgd{'wich'} = $_; last; } } } # search for LOCAL  .pm matches # should these ignore case?
      unless(-r $pkgd{'wich'}) { for(@gdat) { if(/\.pm$/)  { $pkgd{'wich'} = $_; last; } } } # search for GLOBAL .pm matches
    } # find a file that exists
    if(-r $pkgd{'wich'}) {
      $pkgd{'wpth'} = $pkgd{'wich'};
      $pkgd{'wpth'} =~ s/^(.*)\/[^\/]*$/$1/; # isolate path
      $pkgd{'wpth'} =~ s/\/lib\/.*$//; # get MANIFEST below lib/ if .pm there
      $pkgd{'wman'} = $pkgd{'wpth'} . '/MANIFEST';
      $pkgd{'wmsk'} = $pkgd{'wman'} . '.SKIP';
      if(-r $pkgd{'wman'} && open(WMAN, '<', $pkgd{'wman'})) {
        chomp(@{$pkgd{'mdat'}} = <WMAN>); close(WMAN); # save MANIFEST data
        for(@{$pkgd{'mdat'}}) {
          if   (!exists($pkgd{'wipm'}) && /\.pm$/              ) { $pkgd{'wipm'} = $pkgd{'wpth'} . '/' . $_; }
          elsif( exists($pkgd{'wipm'}) && /\.pm$/              ) { push(@{$pkgd{'wopm'}}, $pkgd{'wpth'} . '/' . $_); } # more .pms than just 1st in MANIFEST
          elsif(!exists($pkgd{'rdme'}) && /^README$/           ) { $pkgd{'rdme'} = 1; }
          elsif(!exists($pkgd{'chgz'}) && /^CHANGES$/          ) { $pkgd{'chgz'} = 1; }
          elsif(!exists($pkgd{'meta'}) && /^META\.ya?ml$/i     ) { $pkgd{'meta'} = 1; }
          elsif(!exists($pkgd{'mkfl'}) && /^Makefile\.PL$/     ) { $pkgd{'mkfl'} = 1; }
          elsif(!exists($pkgd{'bdfl'}) && /^Build\.PL$/        ) { $pkgd{'bdfl'} = 1; }
          elsif(!exists($pkgd{'test'}) && /^t(est.pl|\/.+\.t)$/) { $pkgd{'test'} = 1;
             if(!exists($pkgd{'podc'}) && /^t\/\d*podc\.t$/    ) { $pkgd{'podc'} = 1; } }
          elsif(!exists($pkgd{'xmpl'}) && /^((examples?|samples?|demos?)\.p(m|od)|((ex|eg|examples?|samples?|demos?)\/.+))$/i) { $pkgd{'xmpl'} = 1; }
          elsif(                          /^bin\//             ) { push(@{$pkgd{'binz'}}, $_); }
        }
        print ":*WARN*: No ex/*        found.  Auto-adding ex/synopsis.pl.\n" unless(exists($pkgd{'xmpl'}));
        if(exists($pkgd{'wipm'}) && open(WIPM, '<', $pkgd{'wipm'})) {
          chomp(@{$pkgd{'pdat'}} = <WIPM>); close(WIPM); # save .PM data
          $pkgd{'flag'}->{'namesect'} = 0; 
          $pkgd{'flag'}->{'chngsect'} = 0;
          $pkgd{'flag'}->{'chngtext'} = 0;
          for(@{$pkgd{'pdat'}}) { # find Full Pkg Name, VERSION, && all POD headings in .pm file
            if($pkgd{'flag'}->{'namesect'}) {
              if(/^\s*$/) {
                $pkgd{'flag'}->{'namesect'} = 0 if($pkgd{'abst'});
              } else {
                $pkgd{'abst'} .= ' ' if($pkgd{'abst'});
                $pkgd{'abst'} .= qq($_);
              }
            } elsif($pkgd{'flag'}->{'chngsect'}) {
              if(/^\s*\*\s*/) {
                $pkgd{'flag'}->{'chngsect'} = 0;
                $pkgd{'flag'}->{'chngtext'} = 1 if(/^\s*\*\s*\S/);
              }
            } elsif(/^package\s+([^;]+);/ && !exists($pkgd{'fnam'})) { 
              $pkgd{'pnam'} = $pkgd{'fnam'} = $1; 
              $pkgd{'pnam'} =~ s/^.*:://; # should be same as wipm less /\.pm$/
              if($pkgd{'wipm'} !~ /$pkgd{'pnam'}\.pm$/) {
                print ":*WARN*: MANIFEST .pm file: $pkgd{'wipm'} differs from\n";
                print "  first found package name: $pkgd{'pnam'}.pm!\n";
                print "  Assuming MANIFEST is correct && ignoring found name.\n";
                $pkgd{'pnam'} = $pkgd{'wipm'};
                $pkgd{'pnam'} =~ s/(^.*\/|\.pm$)//g;
                delete($pkgd{'fnam'});
              }
            # CPAN: /([\$*])(([\w\:\']*)\bVERSION)\b.*\=/
            } elsif(/^\s*(my|our)\s+\$VERSION\s*=\s*['"]([^'"]+)['"]\s*;/) {
  #  2) update .pm $VERSION line with pIPtIME in new sub copy
              $pkgd{'pver'} = $2; $pkgd{'pver'} =~ s/pIPtIME/$pkgd{'ptim'}/;
            } elsif(/^\s*(require|use)\s+([^ ;]+)/) { # find reqs
              $pkgd{'reqs'}->{$2} = 0;
            } elsif(/^\s*(my|our)\s+\$\w+\s*=\s*eval\(\s*\"\s*use\s+([^ ;]+)/) { # find optional uses (maybe should not require eval assignment)
              $pkgd{'reqs'}->{$2} = 0;
            } elsif(/^=head1\s+/) { 
              for my $reky (keys(%podr)) {
                if(/$podr{$reky}/) { 
                  $pkgd{'flag'}->{$reky}      = 1; 
                  $pkgd{'flag'}->{'namesect'} = 1 if($reky eq 'name');
                }
              }
            } elsif(/^=item(\s+.*?)pKGvERS  ptptIME/) { 
              $pkgd{'flag'}->{'chngsect'} = 1;
            }
          }
          $pkgd{'abst'} =~ s/^\s*(fULnAME|$pkgd{'fnam'})\s*-\s*//;
          $pkgd{'abst'} =~ s/'/\\'/g;
          if(exists $pkgd{'pver'} && $pkgd{'pver'} =~ /^\d+\.\d+\.[0-9A-Za-z._]{7}$/) {
            $pkgd{'fnem'} = $pkgd{'fnam'}; $pkgd{'fnem'} =~ s/::/-/g;  # build Package PaTH
            $pkgd{'fnim'} = $pkgd{'fnam'}; $pkgd{'fnim'} =~ s/::/\//g; # build Package PaTH w/ slashes
            $pkgd{'fnym'} = $pkgd{'fnim'}; $pkgd{'fnym'} =~ s/^.*\///; # isolate file name
            $pkgd{'ppth'} = $pkgd{'wpth'} . '/' . $pkgd{'fnem'} . '-' . $pkgd{'pver'};
            # update template module CHANGES section only! && only if chngdtext
            if($pkgd{'flag'}->{'chngtext'} && open(WIPM, '>', $pkgd{'wipm'})) {
              for(@{$pkgd{'pdat'}}) {
                s/^((my|our)\s+\$DBUG\s*=\s*)1;/${1}0;/i; # turn off DBUG for pkg
                print WIPM "$_\n";
                if(/^=item(\s+.*?)pKGvERS  ptptIME/) { # get dynamic CHANGES line
                  print WIPM "\n* \n\n=item$1$pkgd{'pver'}  $pkgd{'ptpt'}\n";
                }
              } close(WIPM);
            } else { die "!*EROR*! Please update the CHANGES text for: $pkgd{'wipm'}!\n"; }
            for(@{$pkgd{'pdat'}}) { # loop through .pm data again to perform all template substitutions
              s/pIPtIME/$pkgd{'ptim'}/g; s/fULnAME/$pkgd{'fnam'}/g; s/pKGnAME/$pkgd{'pnam'}/g;
              s/ptptIME/$pkgd{'ptpt'}/g; s/fULnEME/$pkgd{'fnem'}/g; s/pKGvERS/$pkgd{'pver'}/g;
            }
            if(exists($pkgd{'wopm'})) {
              for my $wopm (@{$pkgd{'wopm'}}) {
                open(WOPM, '<', $wopm); chomp(@{$pkgd{'wdat'}->{$wopm}} = <WOPM>); close(WOPM); # save 2ndary .PM data
                for(@{$pkgd{'wdat'}->{$wopm}}) { # scan for reqs && do substs
                  if     ($pkgd{'flag'}->{'chngsect'}) {
                    if(/^\s*\*\s*/) { $pkgd{'flag'}->{'chngsect'} = 0; delete($pkgd{'flag'}->{'chngsect'}) if(/^\s*\*\s*\S/); }
                          #  2) update .pm $VERSION line with pIPtIME in new sub copy of 2ndary
                  } elsif(/^\s*(my|our)\s+\$VERSION\s*=\s*['"]([^'"]+)['"]\s*;/    ) { $pkgd{'pver'} = $2; $pkgd{'pver'} =~ s/pIPtIME/$pkgd{'ptim'}/;
                  } elsif(/^\s*(require|use)\s+([^ ;]+)/                           ) { $pkgd{'reqs'}->{$2} = 0; # find reqs in 2ndary
                  } elsif(/^\s*(my|our)\s+\$\w+\s*=\s*eval\(\s*\"\s*use\s+([^ ;]+)/) { $pkgd{'reqs'}->{$2} = 0; # find optional uses in 2ndary
                  } elsif(/^=item(\s+.*?)pKGvERS  ptptIME/                         ) { $pkgd{'flag'}->{'chngsect'} = 1; }
                }
                if(exists $pkgd{'flag'}->{'chngsect'}) { die "!*EROR*! Please update the CHANGES text for: $wopm!\n"; }
                for(@{$pkgd{'wdat'}->{$wopm}}) { # loop through .pm data again to perform all template substitutions
                  s/pIPtIME/$pkgd{'ptim'}/g; s/fULnAME/$pkgd{'fnam'}/g; s/pKGnAME/$pkgd{'pnam'}/g;
                  s/ptptIME/$pkgd{'ptpt'}/g; s/fULnEME/$pkgd{'fnem'}/g; s/pKGvERS/$pkgd{'pver'}/g;
                }
              }
            }
            chdir($pkgd{'wpth'});
  #  3) create a subdir with $pKGnAME-$VERSION
            mkdir($pkgd{'ppth'}, 0755) unless(-d $pkgd{'ppth'});
            if(-d $pkgd{'ppth'}) {
  #  4) copy everything in MANIFEST (except in .SKIP) into new sub
              for(@{$pkgd{'mdat'}}) { # copy MANIFEST files (handle .SKIP?)
                mkdir("$pkgd{'ppth'}/lib", 0755) unless(-d "$pkgd{'ppth'}/lib" || $_ !~ /^lib\//);
                mkdir("$pkgd{'ppth'}/bin", 0755) unless(-d "$pkgd{'ppth'}/bin" || $_ !~ /^bin\//);
                my $fpth = $pkgd{'ppth'} . '/' . $_;
                $fpth =~ s/^(.*)\/[^\/]*$/$1/; # isolate path
                mkdir($fpth, 0755) unless(-d $fpth);
                open(DSTF, ">$pkgd{'fnem'}-$pkgd{'pver'}/$_") or die "!*EROR*! Couldn't open(DSTF, $pkgd{'fnem'}-$pkgd{'pver'}/$_)!\n";
                if     ($pkgd{'wipm'} =~ /$_$/) { # handle .pm file from template
                  for my $line (@{$pkgd{'pdat'}}                            ) { print DSTF "$line\n"; }
                } elsif(exists($pkgd{'wdat'}) && exists($pkgd{'wdat'}->{$pkgd{'wpth'} . '/' . $_}) && @{$pkgd{'wdat'}->{$pkgd{'wpth'} . '/' . $_}}) {
                  for my $line (@{$pkgd{'wdat'}->{$pkgd{'wpth'} . '/' . $_}}) { print DSTF "$line\n"; }
                } elsif(open(SRCF, '<', $_)) {                                  print DSTF  $line while($line = <SRCF>);
                  if(/MANIFEST$/) {
                    print DSTF "t/00pod.t\n"; # always add simple Test::Pod test && expect ::Coverage to exist manually
                    print DSTF "t/00podc.t\n"     unless(exists($pkgd{'podc'}));
                    print DSTF "ex/synopsis.pl\n" unless(exists($pkgd{'xmpl'}));
                    print DSTF "MANIFEST.SKIP\n"  unless(-r     $pkgd{'wmsk'} );
                    print DSTF "README\n"         unless(exists($pkgd{'rdme'}));
                    print DSTF "CHANGES\n"        unless(exists($pkgd{'chgz'}));
                    print DSTF "META.yml\n"       unless(exists($pkgd{'meta'}));
                    print DSTF "Makefile.PL\n"    unless(exists($pkgd{'mkfl'}) || !$mkfl);
                    print DSTF "$bdfn\n"          unless(exists($pkgd{'bdfl'}) || !$bdfl);
                    if($pkgd{'fnam'} eq 'Pip::Utl') { # add Utl bin wrappers
                      for my $func (@EXPORT) { print DSTF "bin/$func\n"; }
                    }
                  }
                  close(SRCF);
                } else { print "!*EROR*! Couldn't open SourceFile: $_ for reading!\n"; }
                close(DSTF);
                if(-x $_) { chmod(0755, "$pkgd{'fnem'}-$pkgd{'pver'}/$_"); }
                else      { chmod(0644, "$pkgd{'fnem'}-$pkgd{'pver'}/$_"); }
              }
              if($pkgd{'fnam'} eq 'Pip::Utl') { # generate Utl bin wrappers
                mkdir("$pkgd{'fnem'}-$pkgd{'pver'}/bin", 0755) unless(-d "$pkgd{'fnem'}-$pkgd{'pver'}/bin");
                for(@EXPORT) { 
                  open(GENU, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/bin/$_");
                  print GENU "#!/usr/bin/perl -MPip::Utl -e $_(\@ARGV);\n";
                  close(GENU);
                }
              }
  #  5) warn if no test.pl script exists
              if(exists $pkgd{'test'}) {
  #  6) warn if pod doesn't exist, doesn't have NAME, VERSION, SYNOPSIS, 
  #    DESCRIPTION, LICENSE|COPYRIGHT, or AUTHOR.? headings
                for(@{$pkgd{'pdat'}}) { # verify POD exists in PM
                  if(/^=(head1|cut)/) { $pkgd{'pode'} = 1; last; }
                }
                if(exists $pkgd{'pode'}) { # ck for POD head1s
                  for my $reky (keys(%podr)) {
                    unless(exists $pkgd{'flag'}->{$reky}) {
                      print "!*EROR*! Expected POD heading: $reky missing!\n";
                    }
                  }
                  mkdir("$pkgd{'fnem'}-$pkgd{'pver'}/t", 0755) unless(-d "$pkgd{'fnem'}-$pkgd{'pver'}/t");
                  open(PTFL, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/t/00pod.t" ); print PTFL 'use Test::Pod; all_pod_files_ok();'; close(PTFL);
                  unless(exists $pkgd{'podc'}) { # generate t/00podc.t
                    print ":*WARN*: No t/\\d*podc.t found.  Auto-adding t/00podc.t.\n";
                    open(PCFL, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/t/00podc.t" );
                    print PCFL "use Test::Pod::Coverage 'tests' => '1'; pod_coverage_ok('$pkgd{'fnam'}', 'POD Covered');"; close(PCFL);
                  }
  #  7a) generate MANIFEST.SKIP if it doesn't exist
                  unless(-r $pkgd{'wmsk'}) {
                    open(WMSK, ">$pkgd{'fnem'}-$pkgd{'pver'}/MANIFEST.SKIP");
                    print WMSK "\\bCVS\\b\n";
                    print WMSK "^Makefile\$\n";
                    print WMSK "^MANIFEST\\.bak\$\n";
                    print WMSK "^updt.*\$\n";
                    print WMSK "\\.bak\$\n";
                    print WMSK "\\.swp\$\n";
                    print WMSK "\\..*\\.swp\$\n";
                    print WMSK "\\b\\.xvpics\\b\n";
                    print WMSK "~\$\n";
                    close(WMSK);
                  }
  #  7b) generate README  from pod with pIPtIME && pKGnAME if necessary
                  unless(exists $pkgd{'rdme'}) { # generate README  from pod
                    my $podt = Pod::Text->new(); # Read POD from A && write B
                    if($pkgd{'wich'} =~ /\/lib\/$pkgd{'fnim'}/) {
                      $podt->parse_from_file("$pkgd{'fnem'}-$pkgd{'pver'}/lib/$pkgd{'fnim'}.pm", "$pkgd{'fnem'}-$pkgd{'pver'}/README");
                    } else {
                      $podt->parse_from_file("$pkgd{'fnem'}-$pkgd{'pver'}/$pkgd{'fnym'}.pm"    , "$pkgd{'fnem'}-$pkgd{'pver'}/README");
                    }
                  }
                  mkdir("$pkgd{'fnem'}-$pkgd{'pver'}/ex", 0755) unless(-d "$pkgd{'fnem'}-$pkgd{'pver'}/ex");
                  unless(exists($pkgd{'xmpl'})) { my $done = 0; # generate ex/synopsis.pl from README
                    open(RMFL, '<', "$pkgd{'fnem'}-$pkgd{'pver'}/README");
                    open(EXFL, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/ex/synopsis.pl");
                    while(    !$done && ($line = <RMFL>)) { if(uc($line) eq "SYNOPSIS\n") {
                        while(!$done && ($line = <RMFL>)) {
                          if($line =~ /^\w+/) { $done = 1;                        } else { $line =~ s/^ {6}//; print EXFL $line; } }
                    } } close(EXFL); close(RMFL);
                  }
  #  7c) generate CHANGES from README                      if necessary
                  unless(exists $pkgd{'chgz'}) { my $done = 0; # generate CHANGES from README
                    open(RMFL, '<',             "$pkgd{'fnem'}-$pkgd{'pver'}/README");
                    open(CHFL, '>',             "$pkgd{'fnem'}-$pkgd{'pver'}/CHANGES");
                    while(    !$done && ($line = <RMFL>)) { if(uc($line) eq "CHANGES\n") { print CHFL $line;
                        while(!$done && ($line = <RMFL>)) {
                          if($line =~ /^\w+/) { $done = 1;                        } else { print CHFL $line; } }
                    } } close(CHFL); close(RMFL);
                  }
  #  7d) gen META.yml if it doesn't exist
                  unless(exists($pkgd{'meta'})) {
                    open(MYFL, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/META.yml");
                    print MYFL
"--- #YAML:1.0
name: $pkgd{'fnem'}
abstract: $pkgd{'abst'}
version: $pkgd{'pver'}
author:
  - Pip Stuart <Pip\@CPAN.Org>
license: gpl
distribution_type: module
requires:"; # should probably also add provides: section && dynamic_config: 0 (except for Tk::AbstractCanvas?)
                    if(exists($pkgd{'reqs'})) {
                      for(sort {$a cmp $b} keys(%{$pkgd{'reqs'}})) {
                        unless(/^(strict|warnings|base|vars|constant|overload|Carp|Exporter|objs|fULnAME|.*pKGnAME)$/) {
                          my $wtpm = $_; my $inwo = 0; # flag for found in @wopm
                          $wtpm =~ s/::/\//g; $wtpm .= '.pm';
                          $inwo = 1 if($pkgd{'wipm'} =~ /$wtpm$/);
                          if(exists($pkgd{'wopm'}) && @{$pkgd{'wopm'}}) {
                            for my $tswo (@{$pkgd{'wopm'}}) {
                              $inwo = 1 if($tswo =~ /$wtpm$/);
                            }
                          }
                          printf MYFL "\n  $_: 0" unless($inwo);
                        }
                      }
                    }
                    print MYFL "
recommends:
build_requires:
  Test: 0
  Test::Pod: 0
  Test::Pod::Coverage: 0
urls:
  license: HTTP://FSF.Org/licensing/licenses/gpl.txt
meta-spec:
  version: 1.3
  url: HTTP://Module-Build.SourceForge.Net/META-spec-v1.3.html
generated_by: $name pkg v$vers\n"; # YAML files need last line to end in a newline!
                    close(MYFL);
                  }
  #  8) gen Makefile.PL && Build.PL if they don't exist
                  unless(exists($pkgd{'mkfl'}) || !$mkfl) {
                    open(MKFL, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/Makefile.PL");
                    print MKFL
"use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
#   the contents of the Makefile that is written.
WriteMakefile(
  'NAME'         => '$pkgd{'fnam'}',
  'VERSION'      => '$pkgd{'pver'}',
  'ABSTRACT'     => '$pkgd{'abst'}',
  'AUTHOR'       => 'Pip Stuart <Pip\@CPAN.Org>',
  'EXE_FILES'    => [ \n";
                    for(@{$pkgd{'binz'}}) { 
                      if(-f "$pkgd{'fnem'}-$pkgd{'pver'}/$_" &&
                         -x "$pkgd{'fnem'}-$pkgd{'pver'}/$_") {
                        print MKFL (' ' x 22) . "'$_',\n";
                      }
                    }
                    print MKFL (' ' x 20) . "],
  'PREREQ_PM'    => {";
                    if(exists($pkgd{'reqs'})) {
                      $pkgd{'reqs'}{'Test'               } = 0 unless(exists($pkgd{'reqs'}{'Test'               }));
                      $pkgd{'reqs'}{'Test::Pod'          } = 0 unless(exists($pkgd{'reqs'}{'Test::Pod'          }));
                      $pkgd{'reqs'}{'Test::Pod::Coverage'} = 0 unless(exists($pkgd{'reqs'}{'Test::Pod::Coverage'}));
                      for(sort {$a cmp $b} keys(%{$pkgd{'reqs'}})) {
                        unless(/^(strict|warnings|base|vars|constant|overload|fULnAME|Carp|Exporter|objs|.*pKGnAME)$/) {
                          my $wtpm = $_; my $inwo = 0; # flag for found in @wopm
                          $wtpm =~ s/::/\//g; $wtpm .= '.pm';
                          $inwo = 1 if($pkgd{'wipm'} =~ /$wtpm$/);
                          if(exists($pkgd{'wopm'}) && @{$pkgd{'wopm'}}) {
                            for my $tswo (@{$pkgd{'wopm'}}) {
                              $inwo = 1 if($tswo =~ /$wtpm$/);
                            }
                          }
                          printf MKFL "\n    %-32s => 0,", "'" . $_ . "'" unless($inwo);
                        }
                      }
                    }
                    print MKFL "
  }, # Module::Name => 1.1,
  'dist'         => { 'COMPRESS' => 'gzip', 'SUFFIX' => 'tgz' },
);";
                    close(MKFL);
                  }
                  unless(exists($pkgd{'bdfl'}) || !$bdfl) { # maybe instead, just /^require 'Makefile.PL';$/ to smooth start
                    open(BDFL, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/$bdfn");
                    print BDFL
"#!/usr/bin/perl
use Module::Build;
my \$mbld = Module::Build->new(
# 'module_name'                   => '$pkgd{'fnam'}',
  'dist_name'                     => '$pkgd{'fnem'}',
# 'dist_version_from'             => '$pkgd{'fnym'}.pm',
  'dist_version'                  => '$pkgd{'pver'}',
  'dist_abstract'                 => '$pkgd{'abst'}',
  'dist_author'                   => 'Pip Stuart <Pip\@CPAN.Org>',
# 'create_readme'                 => '1',
# 'create_makefile_pl'            => '1', # 'traditional',
  'license'                       => 'gpl',
  'script_files'                  => {\n";
                    for(@{$pkgd{'binz'}}) { 
                      if(-f "$pkgd{'fnem'}-$pkgd{'pver'}/$_" &&
                         -x "$pkgd{'fnem'}-$pkgd{'pver'}/$_") {
                        printf BDFL "    %-31s => '1',\n", "'$_'";
                      }
                    }
                    print BDFL "  },\n";
                    if(!-d 'lib') {
                      print BDFL
"  'pm_files'                      => {\n";
                      printf BDFL "    %-31s => 'lib/$pkgd{'fnim'}.pm',\n  },\n", "'$pkgd{'fnym'}.pm'";
                    }
                    print BDFL
"  'requires'                      => {\n";
                    if(exists($pkgd{'reqs'})) {
                      for(sort {$a cmp $b} keys(%{$pkgd{'reqs'}})) {
                        unless(/^(strict|warnings|base|vars|constant|overload|fULnAME|Carp|Exporter|objs)$/) {
                          my $wtpm = $_; my $inwo = 0; # flag for found in @wopm
                          $wtpm =~ s/::/\//g; $wtpm .= '.pm';
                          $inwo = 1 if($pkgd{'wipm'} =~ /$wtpm$/);
                          if(exists($pkgd{'wopm'}) && @{$pkgd{'wopm'}}) {
                            for my $tswo (@{$pkgd{'wopm'}}) {
                              $inwo = 1 if($tswo =~ /$wtpm$/);
                            }
                          }
                          printf BDFL "    %-31s => '0',\n", "'$_'" unless($inwo);
                        }
                      }
                    }
                    print BDFL "  },\n);\n\$mbld->create_build_script();";
                    close(BDFL);
                  }
                  mkdir('.bak', 0755) unless(-d '.bak'); # zp new dir into .bak/
  #  9) zp new dir into .bak/NAME.tgz then remove dir
                  system("tar czfp .bak/$pkgd{'fnem'}-$pkgd{'pver'}.tgz $pkgd{'fnem'}-$pkgd{'pver'}");
                  if(-r ".bak/$pkgd{'fnem'}-$pkgd{'pver'}.tgz") { 
                    # success so go ahead && recursively remove all old data
                    system("rm -rf $pkgd{'fnem'}-$pkgd{'pver'}/"); # rm all
                    $pkgd{'pver'} =~ s/\.(.)(.)(.)(.)(.)(.)(.)$/.\e[1;31m$1\e[0;33m$2\e[1;33m$3\e[1;32m$4\e[1;36m$5\e[1;34m$6\e[1;35m$7\e[1;32m/;
                    $pkgd{'pver'} =~ s/^(\d+)\.(\d+)\./\e[1;33m$1\e[1;37m.\e[1;36m$2\e[1;37m./;
                    print "Successfully Packaged: .bak/$pkgd{'fnem'}-$pkgd{'pver'}.tgz!\n"; 
                    $pkgd{'fail'} = 0; 
                  }
                } else {
                  print "!*EROR*! No POD found within package: $pkgd{'wipm'}!\n";
                  print "  Please define some Perl Documentation in your module.\n";
                }
              } else {
                print "!*EROR*! No test file detected in MANIFEST!  Please define either\n";
                print "  a test.pl file or t/TESTNAME.t && add it to MANIFEST.\n";
              }
            }
          } else {
            $pkgd{'pver'} = '' unless(exists $pkgd{'pver'});
            print "!*EROR*! Detected VERSION: $pkgd{'pver'} doesn't match expected\n";
            print "  format of \$MAJOR.\$MINOR.\$PIPTIME! (eg. 1.0.37SLNGN)\n";
          }
        }
      }
    }
    if($pkgd{'fail'}) {
      print "!*EROR*! \`e pkg\` couldn't locate a suitable MANIFEST file!\n";
      print "  Please run it again as \`e pkg /path/to/pkg/MANIFEST\`.\n";
      if($dbug) {
        print "\nPackage Hash:\n";
        print "$_:$pkgd{$_}\n" for(keys(%pkgd));
      }
    }
  } elsif($file eq 'ul') { # special 'ul' file case for completed pkgs
  # first ck if cwd is 2..4 deep from a /lib/
    if     (-d       '../../lib' && -d       '../../.bak' && !-d       '../../../../home') {
      chdir(         '../..');
    } elsif(-d    '../../../lib' && -d    '../../../.bak' && !-d    '../../../../../home') {
      chdir(      '../../..');
    } elsif(-d '../../../../lib' && -d '../../../../.bak' && !-d '../../../../../../home') {
      chdir(   '../../../..');
    }
  # then look in .bak for the newest x-pt.tgz file && run cpan-upload-http on it
    unless(-d '.bak') { 
      die "!*EROR*! Couldn't find '.bak' directory with .tgz file to cpan-upload-http!\n"; 
    }
    chdir('.bak');
    @pkgz =  reverse(sort(glob("*.???????.tgz")));
    unless(@pkgz) {
      die "!*EROR*! Couldn't find .tgz file!\n"; 
    }
    $_ =  $pkgz[0];
    $_ =~ s/\.(.)(.)(.)(.)(.)(.)(.)\.tgz$/.\e[1;31m$1\e[0;33m$2\e[1;33m$3\e[1;32m$4\e[1;36m$5\e[1;34m$6\e[1;35m$7\e[1;32m.tgz/;
    $_ =~ s/-(\d+)\.(\d+)\./-\e[1;33m$1\e[1;37m.\e[1;36m$2\e[1;37m./;
    print  "cpan-upload-http -verbose : $_...\n"; # `echo -n "Testing cpan-upload-http - please ignore this file." >please-ignore`;
    system("cpan-upload-http -verbose $pkgz[0]");
    chdir('..');
  } else { # regular file case
    for my $qrex (@srch) { # search for progressively easier LOCAL  matches
      unless(-r $file) {
        for(@ldat) {
          if(/$qrex/)  { $file = $_; last; } # should it ignore case?
        }
      }
    }
    for my $qrex (@srch) { # search for progressively easier GLOBAL matches
      unless(-r $file) {
        for(@gdat) {
          if(/$qrex/)  { $file = $_; last; } # should it ignore case?
        }
      }
    }
    if($verb) {
      die "!*EROR*! Can't edit directory: $file!" if(-d $file);
    }
    $file =~ s/^\.\//$cwdr\//;
    $file =~ s/^\~\//$home\//;
    $file = $cwdr . '/' . $file unless($file =~ /^\//);
    for(my $i = 0; $i < @ldat; $i++) {
      splice(@ldat, $i--, 1) if($file eq $ldat[$i]);
    }
    for(my $i = 0; $i < @gdat; $i++) {
      splice(@gdat, $i--, 1) if($file eq $gdat[$i]);
    }
    unshift(@ldat, $file);
    unshift(@gdat, $file);
    if(open(ERCL, ">$ercl")) {
      print ERCL "$_\n" for(@ldat);
      close(ERCL);
    } else { print("!*EROR*! Couldn't update Local  erc file: $ercl!\n"); }
    if(open(ERCG, ">$ercg")) {
      print ERCG "$_\n" for(@gdat);
      close(ERCG);
    } else { print("!*EROR*! Couldn't update Global erc file: $ercg!\n"); }
    system(qq($edit +\\'\\" $file));
  }
}
sub SyncFlac {
  my $path = shift || return;
  return unless(-d $path);
  $path =~ s/\/*$//;
  my $qual = -1; # encoded Ogg Vorbis quality level
  my $bitr = 96; # encoded Ogg Vorbis forced bit-rate min
  my $bitm =128; # encoded Ogg Vorbis forced bit-rate max
  my $fpth = $ENV{'HOME'} . "/muz/flac";
  my $opth = $ENV{'HOME'} . "/muz/ogg";
  my $coun = 0;
  for(glob($path . "/*.flac")) {
    my $oreg = $_;
    my $wreg = $_;
    s/([()&!])/\\$1/g;
    my $otmp = $_;
    $oreg =~ s/$fpth/$opth/;
    $wreg =~ s/$fpth/$opth/;
    $otmp =~ s/$fpth/$opth/;
    my $wtmp = $otmp;
    $oreg =~ s/\.flac$/.ogg/;
    $otmp =~ s/\.flac$/.ogg/;
    $wreg =~ s/\.flac$/.wav/;
    $wtmp =~ s/\.flac$/.wav/;
    unless(-e $oreg) {
      print("!-e oreg:$oreg\n");
#      print "flac   -d $_          -o $wtmp\n";
             `flac   -d $_          -o $wtmp`;
#      print "oggenc $wtmp -q $qual -o $otmp\n";
#            `oggenc $wtmp -q $qual -o $otmp`;
#      print "oggenc $wtmp --managed -m $bitr -M $bitm -o $otmp\n";
             `oggenc $wtmp --managed -m $bitr -M $bitm -o $otmp`;
    }
#    print("!-e otmp:$otmp\n") unless(-e $otmp);
    unlink($wreg) if(-e $wreg);
    print("-e wreg:$wreg\n") if(-e $wreg);
    if($coun) { exit unless(--$coun); }
  }
}
sub foggsync {
  # 43EN5kI - foggsync.pl created by Pip Stuart <Pip@CPAN.Org> to
  #   synchronize my flac && ogg music archives
  my $fpth = $ENV{'HOME'} . "/muz/flac";
  my $opth = $ENV{'HOME'} . "/muz/ogg";
  my $otmp; my $wtmp;
  my $oreg; my $wreg;
  mkdir($opth, 0755) unless(-d $opth);
  SyncFlac($fpth);
  for my $subd (glob($fpth . "/*")) {
    if(-d $subd) {
      $otmp = $subd;
      $otmp =~ s/$fpth/$opth/;
      mkdir($otmp, 0755) unless(-d $otmp);
      SyncFlac($subd);
      for my $ssbd (glob($subd . "/*")) {
        if(-d $ssbd) {
          $otmp = $ssbd;
          $otmp =~ s/$fpth/$opth/;
          mkdir($otmp, 0755) unless(-d $otmp);
          SyncFlac($ssbd);
        }
      }
    }
  }
}
sub forfiles {
  my($auth,$vers,$name)=('Pip@CPAN.Org','37VBdM8','forfiles');
  # 37VAwqP - forfiles    created by Pip to loop through a file list && 
  #   call some utility on each one.
  # ...ummm learn how to use for in the shell silly!!!
  # All source code should be free!  Code I have authority over is && shall be!
  # This code is licensed under the GNU GPL v2.
  #                                             -Pip@CPAN.Org
  my $func = '';# = pop || '-h'; 
  my $flnm = shift; my($newn,$oldt,$newt) = (); my @stat;
  if($func =~ /^-*[h?](elp)?$/i || $flnm =~ /^-*[h?](elp)?$/i) { # print help
    print "Usage: $name FILELIST FUNCTION
  Calls a FUNCTION on every file name in FILELIST.
    $name vers:$vers by auth:$auth
  "; exit;
  }
  #exit unless(-e $func);
  while(defined $flnm && -e $flnm) {
  #  system("$func $flnm");
    if($flnm =~ /m-([0-9A-Z][0-9A-Za-z])\.txt$/) {
      $newn = $flnm;
      $oldt = $1;
      @stat = split(/ /, scalar(localtime((stat($flnm))[9])));
      $newt = pt(@stat) . '0';
      $newn =~ s/$1/$newt/;
      print "$name fixing: $flnm to $newn\n";
      rename($flnm, $newn);
    }
    $flnm = shift;
  }
}
sub FixxName { # substitute characters && patterns to good media filenames
  my $name = shift; my  $fpth = shift;
  $name =~ s/\//-/g if(!$fpth);
  $name =~ s/['"*<>?\[\]]//g;
  $name =~ s/ /_/g;
  $name =~ s/:/-_/g;
  $name =~ s/(^|[^\\])([!&=+()])/$1\\$2/g;
  $name =~ s/___/_/g;
  return($name);
}
sub frip { # Flac RIPper
# 2do:
#   add optn to rip all at once && enc flacs / del wavs later
  my $edtf = 'edtf'; my %edat = ();
  my $cdat = `cdcd info`; $cdat = `cdcd tracks`; my $indx; my $numb; my $null;
  my %data = ('albm' => '', 'arti' => '', 'trax' => 0, 'leng' => 0,
              'tinf' => [], 'path' => '/usr/Gen_c/pip/muz/flac/');
  $data{'albm'} = FixxName($1) if($cdat =~ /^Album name:\s+(.*)\n/);
  $data{'arti'} = FixxName($1) if($cdat =~ /\nAlbum artist:\s+(.*)\n/);
  if($cdat =~ /\nTotal tracks:\s+(\d+)\s+Disc length:\s+(\d+:\d+)\n/) {
    $data{'trax'} = $1;
    $data{'leng'} = $2;
    for($indx = 0; $indx < $data{'trax'}; $indx++) {
      $numb = $indx + 1;# $numb = '0' . $numb if(length($numb) == 1);
      if($cdat =~ /\n\s?$numb:\s+(>\s+)?\[[\s\d]\d:\d\d\.\d\d\]\s+(.*)\s+\n/) {
        $data{'tinf'}[$indx] = FixxName($2);
      }
    }
  }
  my $cdpa = `cdparanoia -vsQ 2>&1`;
  open(EDTF, ">$edtf");
  print EDTF "# EDIT THIS FILE IF YOU WANT DIFFERENT NAMES!\n";
  print EDTF "#   arti/albm will be created as dirs in path && in filenames.\n";
  print EDTF "path:$data{'path'}\narti:$data{'arti'}\nalbm:$data{'albm'}\n";
  for($indx = 0; $indx < @{$data{'tinf'}}; $indx++) { 
    $numb = $indx + 1; $numb = '0' . $numb if(length($numb) == 1);
    print EDTF "$numb:", $data{'tinf'}[$indx], "\n";
  }
  close(EDTF);
  system($ENV{'EDITOR'} . " $edtf");
  open(EDTF, "<$edtf");
  while(<EDTF>) {
    if     (/^path:(.*)/) {
      $edat{'path'} = $1; $edat{'path'} =~ s/\/*$/\//;
    } elsif(/^arti:(.*)/) {
      $edat{'arti'} = FixxName($1);
    } elsif(/^albm:(.*)/) {
      $edat{'albm'} = FixxName($1);
    } elsif(/^(\d+):(.*)/) {
      $indx = ($1 - 1);
      $edat{'tinf'}[$indx] = FixxName($2);
    }
  }
  close(EDTF);
  unlink($edtf) if(-e $edtf);
  unless(exists($edat{'tinf'}) && defined($edat{'tinf'}) && @{$edat{'tinf'}}) {
  for(sort(keys(%data))) { print "keey:$_ => '" . $data{$_} . "'\n"; }
    die("!*EROR*! No tracks specified!  Quitting...\n");
  }
  $edat{'mpat'}  = $edat{'path'};
  $edat{'mpat'} .= $edat{'arti'} . '/' if(exists($edat{'arti'}));
  $edat{'spat'}  = $edat{'mpat'};
  $edat{'spat'}  =~ s/\\([^\\])/$1/g;
  unless(-d $edat{'spat'}) {
    mkdir($edat{'spat'}, 0755);
  }
  $edat{'mpat'} .= $edat{'albm'} . '/' if(exists($edat{'albm'}));
  $edat{'spat'}  = $edat{'mpat'};
  $edat{'spat'}  =~ s/\\([^\\])/$1/g;
  unless(-d $edat{'spat'}) {
    mkdir($edat{'spat'}, 0755);
  }
  for($indx = 0; $indx < @{$edat{'tinf'}}; $indx++) {
    if(defined($edat{'tinf'}[$indx])) {
      $numb = $indx + 1; $numb = '0' . $numb if(length($numb) == 1);
      my $fnam = $numb . '_' . $edat{'arti'} . '-' . $edat{'albm'} . '-';
      $fnam .= $edat{'tinf'}[$indx];
      my $snam = $fnam; $snam =~ s/\\([^\\])/$1/g;
      unless(-e "$snam.wav") {
        print "frip:$snam.wav...\n";
        $null = `cdparanoia -w $numb $fnam.wav 2>&1`;
      }
      unless(-e "$snam.flac") {
        print " -> :$snam.flac...\n";
        $null = `flac $fnam.wav 2>&1`;
      }
      if(-e "$snam.wav") { unlink("$snam.wav"); }
      else { print "EROR! Couldn't find: $snam.wav to unlink!\n"; }
      if(-e "$snam.flac") {
        print "mvto:$edat{'path'}...";
        $null = `mv $fnam.flac $edat{'mpat'} 2>&1`;
        print "done\n";
      } else { print "EROR! Couldn't find: $snam.flac to move!\n";
      }
    }
  }
}
sub readhead { # 1CKEIX0 - util to flexibly read binary file header info takes byte-based unpack pattern, filename, && optional file offset
               #   e.g., `perl readhead.pl V2x2v c:\gfx\SoulCal0.bmp 18` prints: 292 640 24 (.bmp width, height, bit-depth)
  my $ptrn = shift || return(); my $flnm = shift; my $ofst = shift || 0; my $temp = $ptrn; my $size = 0; my $type = ""; my $incr = 1; my @valz = ();
  return() unless(-e $flnm);
  while($temp =~ /^([a-z])(\d*)/i) { ($type, $incr)=($1, $2);
    $type = "z" if(!defined($type) || $type !~ /^[a-z]$/i);
    $incr =  1  if(!defined($incr) || $incr !~ /^\d+$/);
    if   ($type =~ /^[snv]$/ ) { $incr = 2; }
    elsif($type =~ /^[flNV]$/) { $incr = 4; }
    elsif($type =~ /^[d]$/   ) { $incr = 8; }
    $size += $incr; $temp =~ s/^[a-z]\d*//i;
  }
  open(FILE, '<', $flnm); binmode(FILE); read(FILE, $temp, $ofst); read(FILE, $temp, $size); close(FILE); #print "ptrn:$ptrn size:$size ofst:$ofst\n";
  #for(split //, $temp) { print ord($_), ", "; } print "\n";
  while($ptrn =~ /^([a-z])(\d*)/i) { ($type, $incr)=($1, $2);
    $type = "z" if(!defined($type) || $type !~ /^[a-z]$/i);
    $incr =  1  if(!defined($incr) || $incr !~ /^\d+$/);
    push(@valz, unpack("$type$incr", $temp)) if($type ne "x"); # not null
    if   ($type =~ /^[snv]$/)  { $incr = 2; }
    elsif($type =~ /^[flNV]$/) { $incr = 4; }
    elsif($type =~ /^[d]$/)    { $incr = 8; }
    $temp = substr($temp,$incr,(length($temp)-$incr)); $ptrn =~ s/^[a-z]\d*//i;
  } print "@valz\n";
}
sub timerun { # 46ANK5t - timeRun.pl created by Pip Stuart <Pip@CPAN.Org> to time execution of different executables.
  my $exec = shift() || die("!*EROR*! Please supply an executable to time!\n");
  my $runs = shift() || 1; my $ptb4; my $ptaf; my $tdif;
  $ptb4 = Time::PT->new(); printf("PTb4:$ptb4 expand:%s\n", $ptb4->expand()); for(1..$runs) { system($exec); }
  $ptaf = Time::PT->new(); printf("PTaf:$ptaf expand:%s\n", $ptaf->expand()); $tdif = $ptaf - $ptb4; # Time::Frame
  printf(" Dif:%s seconds:%s\n", $tdif->total_frames(), ($tdif->total_frames() / 60));
}
sub runbench { # 46CMTX9 - runBench.pl created by Pip Stuart <Pip@CPAN.Org> to compare test times.
  die "Please define: run0 as an enviroment var!" unless(exists($ENV{'run0'}));
  die "Please define: run1 as an enviroment var!" unless(exists($ENV{'run1'}));
  print   "Testing: $ENV{'run0'}...\n"; system("perl timeRun.pl $ENV{'run0'}");
  print "\nTesting: $ENV{'run1'}...\n"; system("perl timeRun.pl $ENV{'run1'}");
}
sub scal {
  # 29HHcl0 - scal : a quick Gimp_Perl script to scale images
  # Synt: `scal <ImageToScale> <NewWidth> <NewHeight> [OutFile] [saveAspectFlag]`
  # Note: Unfortunately, it seems you must be in X to use `scal`.
  # Need: Gimp modules =)
#  use Gimp ":auto"; 
#  use Gimp::Fu;
#  
#  sub scaleimg () {
#      my $inpi = shift || return; # must get an input image parameter
#      my $neww = shift || 32;
#      my $newh = shift || 32;
#      my $outi = shift || undef; 
#      my $aspf = shift || 0; my $temp = 0;
#      my $imag = gimp_file_load( RUN_NONINTERACTIVE, $inpi, $inpi );
#      my $widt = gimp_image_width(  $imag );
#      my $hite = gimp_image_height( $imag );
#      my $draw = gimp_image_active_drawable( $imag );
#  
#      unless ($neww =~ /^\d+$/) { $outi = $neww; $neww = 32; }
#      if ($aspf) {
#          if (($widt/$hite) >= ($neww/$newh)) {
#              $temp = $neww / $widt;
#              $newh = int($temp * $hite);
#          } else {
#              $temp = $newh / $hite;
#              $neww = int($temp * $widt);
#          }
#      }
#      unless (defined($outi)) {
#          $outi = $inpi;
#          $outi =~ s/\..*//;
#          $outi .= "_$neww" . "x$newh";
#      }
#      $outi .= ".png" unless $outi =~ /\.png$/;
#      if ($widt != $neww || $hite != $newh) {
#          gimp_image_scale( $imag, $neww, $newh );
#      }
#      gimp_file_save( RUN_NONINTERACTIVE, $imag, $draw, $outi, $outi );
#  #    save_image( $imag, "PNG-C7:$outi" );
#  # Gimp::Fu::save_image(imag, [(GIF|JPG|JPEG|PNM|PNG)[OPTIONS...]:]filespec)"
#  #  optn: all  +F     flatten the image (default depends on the image)
#  #        PNG  -Cn    use compression level n
#  #             -E     Do not skip ancillary chunks (default)
#  #             -I     do not save as interlaced (default) (works for GIF also)
#  #        GIF  -L     save as non-looping animation (default) (anims: use -F)
#  #             -Dn    default frame delay (default is 0)      (anims: use -F)
#  #             -Pn    frame disposal method: 0=don't care,1=combine,2=replace
#  #       JPEG  -Qn    use quality "n" to save file (JPEG only)
#  #             -S     do not smooth (default)
#  #  xmpl: test.jpg          save the image as a simple jpeg
#  #        JPG:test.jpg      same
#  #        JPG-Q70:test.jpg  same but force a quality of 70
#  #        GIF-I-F:test.jpg  save as GIF image(!) named test.jpg non-int non-flat
#  
#      gimp_image_delete ( $imag );
#      print "Scaled: $inpi (", 
#            ( ((1.0*$neww/$widt) + (1.0*$newh/$hite)) / 2.0 )*100, 
#            "%) from ", $widt, "x$hite to ", $neww, "x$newh\n",
#            "    as: $outi";
#      if ($aspf) { print " preserving"; }
#      else       { print " discarding"; }
#      print " aspect ratio.\n";
#  
#      return;
#  }
#  
#  register                                          
#      "scaleimg",                                   
#      "Scale an image",                             
#      "Used by MagicRainbowBattle",                 
#      "PipTigger",                                  
#      "Pip Stuart (c)",                             
#      "2002-06-07 [I7Muv]",                         
#      "<Toolbox>/Xtns/Perl-Fu/ScaleImg",            
#      "*",                                          
#      [                                             
#        [PF_STRING, "inpi",    "Input Image",   ""],
#        [PF_STRING, "neww",    "New Width",   "32"],
#        [PF_STRING, "newh",    "New Height",  "32"],
#        [PF_STRING, "outi",    "Output Image",  ""],
#        [PF_STRING, "aspf",    "Aspect Flag",  "0"],
#      ],                                            
#      \&scaleimg;
#  
#  exit main(); 
}
sub shot {
  # 26A9fB0 - shot created by Pip@CPAN.Org
  #  Desc: I wanted to wrap `scrot` in some common options =)
  #    I only want PNG files at compression level 7, usually want thumbnails, ...
  #  /-(s|w)/i          select window (uppercase shoots windowmanager border too)
  #  /-(c|d)(\d*)/i     countdown $1 secs before taking shot (uc hides count)
  #  /-(e)(\w+)/i       exec $1 on resulting screenshot file
  #  /-(m)/i            grab from multiple displays && join them
  #  /-(t)(\d*)(x|\%)?(\d*)/i   change thumbnail size dimensions or % (uc=!thum)
  #  Note: `shot` relies on `scal` to create the thumbnail instead of `scrot`
  #   unless you specify the thumb size as a percentage
  my %optz = ( 'file' => 'shot',    # unique part of filename
               'scrw' => 0,         # screen width  (loaded after looping)
               'scrh' => 0,         # screen height (loaded after looping)
               'whol' => 1,         # whole screen shot?
               'bord' => 0,         # grab window border too?
               'dela' => 3,         # delay seconds
               'coun' => 1,         # countdown?
               'exec' => '',        # execute on the resultant file
               'mult' => 0,         # multi-display shot?
               'thum' => 't',       # make a thumbnail?
               'thmw' => 128,        # thumbnail's width (pixels)
               'thmh' => 96,        # thumbnail's height (pixels)
               'thmm' => 'x', # thumbnail mode: x=w/h, %=use width as percentage
             );
  my $parm = ""; # parameters...
  ## PROCESS COMMAND LINE OPTIONS
  $_ = "";
  $_ .= join ' ', @ARGV;
  (/--?h/i || /--?\?/) and 
      print qq/ IA9fB - shot created by Pip\@CPAN.Org
    Desc: I wanted to wrap `scrot` in some common options =\)
      I only want PNG files at compression level 7, usually want thumbnails, ...
        usage: $0 
    -(s|w)i          select window (uppercase shoots windowmanager border too)
    -(c|d)(#)i       countdown X secs before taking shot (uc hides count)
    -(e)(X)i         exec X on resulting screenshot file
    -(m)i            grab from multiple displays && join them
    -(t)(#)(x|\%)?(#)i   change thumbnail size dimensions or % (uc=!thum)
  /;
  if (/-h/ || /-\?/) { exit; }
  /([^-]\w+)/i        and $optz{'file'}=$1;
  /--?(s|w)/i         and $optz{'whol'}=0 and ($1 ne lc($1)) and $optz{'bord'}=1;
  /--?(c|d)(\d+)/     and (defined($2))   and $optz{'dela'}=$2;
  /--?(C|D)/          and $optz{'coun'}=0;
  /--?(e)(\w+)/i      and (defined($2))   and $optz{'exec'}=$2;
  /--?(m)/i           and $optz{'mult'}=1;
  /--?(t)(\d*)(x|\%)?(\d*)/i and                   $optz{'thum'}=$1
                             and (defined($2)) and $optz{'thmw'}=$2
                             and (defined($3)) and $optz{'thmm'}=$3
                             and (defined($4)) and $optz{'thmh'}=$4;
  ## BUILDING PARAMETER STRING
  $optz{'file'} =~ s/\.png//i;
  $optz{'file'} .= "_\\\$wx\\\$h_" . `pt`;
  $optz{'ofil'}  = $optz{'file'} . "_thumb.png";
  $optz{'file'} .= ".png";
  $parm = $optz{'file'} . " -q 12 "; # quality 7/8
  unless ($optz{'whol'}) { $parm .= "-s "; }
  if     ($optz{'bord'}) { $parm .= "-b "; }
  if     ($optz{'dela'}) { $parm .= "-d " . $optz{'dela'} . " "; }
  if     ($optz{'coun'}) { $parm .= "-c "; }
  if     ($optz{'mult'}) { $parm .= "-m "; }
  if ($optz{'thum'} eq 't') {
      if ($optz{'thmm'} eq '\%') { # if %size, let scrot doit
          if ($optz{'exec'}) { $parm .= "-e " . $optz{'exec'} . " "; }
          $parm .= "-t " . $optz{'thmw'} . " "; 
      } else {
          $optz{'file'} =~ s/\\/\\\\/g;
          $optz{'ofil'} =~ s/\\/\\\\/g;
          $parm .= "-e 'scal " . $optz{'file'} . " " . $optz{'thmw'};
          $parm .= " " . $optz{'thmh'} . " " . $optz{'ofil'} . "' ";
      }
  }
  #print "scrot $parm\n";
  #print "topi:$_\n"; for(keys(%optz)) { print "$_ => ", $optz{$_}, ", "; }; print "\n";
  system("scrot $parm");
  #  -b, --border              When selecting a window, grab wm border too
  #  -c, --count               show a countdown before taking the shot
  #  -d, --delay NUM           wait NUM seconds before taking a shot
  #  -e, --exec APP            run APP on the resulting screenshot
  #  -q, --quality  12.5 = 7/8 ths
  #  -m, --multidisp           For multiple heads, grab shot from each
  #  -s, --select              interactively choose a window or rectnagle
  #  -t, --thumb %NUM   
  #'scrot \'yearmonthday_$wx$h_scrot.png\' -e \'mv $f ~/images/shots/\''
}
sub syncdate { # 24RNkce - syncdate created by Pip Stuart <Pip@CPAN.Org> to synchronize the system date/time with an authoritative web page.
  # 2do: print diff between times before && after setting, setup cron to sync daily?
  my $data; my $year; my $mont; my $dayo; my $hour; my $minu; my $seco; my %mons; my $moni = 1;
  $mons{$_} = sprintf("%02d", $moni++) for(Time::DayOfWeek::MonthNames());
  `wget -q   -O    /tmp/nowdate.html http://www.time.gov/timezone.cgi?Pacific/d/-8`; # read date site into local file
  open(DATE, '<', '/tmp/nowdate.html'); $data = join '', <DATE>; close(DATE); # Perl6::Slurp?
  if($data =~    /<b>(\d+):(\d+):(\d+)<br>/i) { $hour =       $1 ; $minu = $2; $seco = $3; } # parse file data for embedded date/time
  if($data =~ /day, (\w+) (\d+), (\d+)<br>/i) { $mont = $mons{$1}; $dayo = $2; $year = $3; } $dayo = "0$dayo" if(length($dayo) == 1); # 0-pad MM && DD
  print "$0 setting: date $mont$dayo$hour$minu$year.$seco\n";
  system(           "date $mont$dayo$hour$minu$year.$seco"); # call `date` with format: MMDDhhmmYYYY.ss
}
sub vollabel { # 465Fedf - vollabel to return GNU/Linux disc volume labels
  my $dvic = shift || '/dev/dvd'; $dvic =~ s[^(/dev)?/*][/dev/]; die "!*EROR*! Invalid device name:$dvic!\n" if($dvic =~ /[^0-9A-Za-z._\/]/); # sanity ck
  my $voll = `dd if=$dvic bs=1 skip=32808 count=32 2>/dev/null`; print "$voll\n";
}
sub shuf { # takes an arrayref or list of items to shuffle #return(Shuffle(@_)); # just use Games::Cards::Poker::Shuffle()?
  return(0) unless(@_); my $aflg = 0; $aflg = 1 if(ref($_[0]) eq 'ARRAY'); my $size = 0; my $aref; my @data = @_; # must have at least one parameter
  if($aflg) { $aref =  $_[0]; } else { $aref = \@data; } $size = @{$aref};
  for(my $indx = ($size-1); $indx; $indx--) { my $rand = int(rand($indx+1));
    ($aref->[$indx], $aref->[$rand])=($aref->[$rand], $aref->[$indx]) if($rand != $indx);
  } if($aflg) { return($aref); } else { return(@data); }
}
sub tiglet { # figlet chooser
  my $fntd = `figlet -I2`;           #this is 4linux
  #my $fntd = "/pip/4dos/fig/fonts";  #this is 4dos
     chomp($fntd);
     $fntd .= "/*.flf";
  my $text = "@ARGV";
  my $outf = "dfaltout.txt";
  my @fntz = glob("$fntd"); my $coun = 0; my $fcou = 0; my $lall = 0;
  my $poop; my $kaka;
  #my $favs = "19 20 24 32 36 37 64 67 69 70 75 76 77 78 80 84 85 90 93 100 102 ";
  my $favs = "14 15 19 22 24 25 32 36 37 64 65 67 70 76 78 81 84 85 87 88 90 94 100 102 ";
  #my $favs = ""; #Above are my 4dos&&Linux favs but I have more fonts than most.
  my $optn = ""; # Your mileage and font numbers may vary.
  my $inpt = "";
  my @favz = split(/\s+/, $favs);
  if($text =~ m/^\s*-a/i) { $text =~ s/^\s*-a//i; $lall = 1; }
  print "                       Tigger's Figlet Chooser v0.2\n";
  print "USAGE:  me\@myserver:\% perl tiglet.pl \"KakA NachoZ\"\n";
  print "Tiglet lets you interactively select the perfect figlet font \n";
  print " for your .sig or msg or title or... =) smiley!  \n";
  print "Specify -a on the command line to rotate through all available\n";
  print " fonts or just run normally to rotate only favorites\n"; 
  print "Please e-mail suggestions or constructive criticisms to Pip\@CPAN.Org\n";
  print "n or Enter - checks next font, p - checks previous font\n";
  print "  Any specific number jumps directly to that font\n";
  print "t - prompts for text change, e - prompts for filename to export to\n";
  print "Y - SAVES selected text to specified exportfile and quits\n";
  print "Q - QUITS without saving, ... the parameters are not case-sensitive\n";
  print "Toggles: s=squish, k=kern, o=overlap, c=center, l=left, r=right, f=favorite\n";
  if($text eq "") {
    $text = "KakA NachoZ";
    print "Please enter text to display [$text]: ";
    chomp($poop = <STDIN>); if($poop ne "") { $text = $poop; }
    print "Please enter a file to write selected text to [$outf]: ";
    chomp($poop = <STDIN>); if($poop ne "") { $outf = $poop; }
  }
  while($inpt !~ /q|x|y|d/i && (($lall && $coun < @fntz) || (!$lall && $fcou < @favz))) {
    @favz = split(/\s+/, $favs);
    if($lall) {
      $fntz[$coun] =~ s!.*/!!;
      $kaka = `figlet -f $fntz[$coun] $optn -- $text`;
      print "${kaka}Font\#$coun:$fntz[$coun],Text:$text,Optn:$optn,Favs:$favs,cmd[npYteskocq]: ";    
    } else {
      $fntz[$favz[$fcou]] =~ s!.*/!!;
      $kaka = `figlet -f $fntz[$favz[$fcou]] $optn -- $text`;
      print "${kaka}Font\#$favz[$fcou]:$fntz[$favz[$fcou]],Text:$text,Optn:$optn,Favs:$favs,cmd[npYteskocq]: ";
    }
    chomp($inpt = <STDIN>); $inpt =~ tr/A-Z/a-z/;
    if($inpt =~ /f/) { 
      if($favs =~ /$coun /) { if($lall) { $favs =~ s/$coun //; } else { $favs =~ s/$favz[$fcou] //; } }
      else                  { if($lall) { $favs .=  "$coun " ; } else { $favs .=  "$favz[$fcou] " ; } }
    }
    if($inpt eq "" || $inpt =~ /n/) { $coun++; $fcou++;
      if(($lall && $coun == @fntz) || (!$lall && $fcou == @favz)) { 
        print "Last Font Displayed!  Loop back to beginning? (y/n) ";
        $poop = <STDIN>; if($poop =~ /y/i) { $coun = $fcou = 0; }
      }
    }
    if($inpt =~  /p/  ) { $coun--; $fcou--; }
    if($inpt =~  /\d+/) { $coun =  $inpt;
      if($coun <     0) { $coun =      0; }
      if($coun > @fntz) { $coun = $#fntz; }
    }
    if($inpt =~ /y/ || $inpt =~ /d/) {
      print "Saving to $outf and Quitting!\n";
      open(OUTF, '>', $outf); print OUTF $kaka; close(OUTF);
    }
    if($inpt =~ /t/) { 
      print "New Text [$text]: "; chomp($poop = <STDIN>);
      if($poop ne "") { $text = $poop; }
    }
    if($inpt =~ /e/) { 
      print "Export File [$outf]: "; chomp($poop = <STDIN>);
      if($poop ne "") { $outf = $poop; }
    }
    if($inpt =~ /s/ || $inpt =~ /k/ || $inpt =~ /o/ ||
       $inpt =~ /c/ || $inpt =~ /l/ || $inpt =~ /r/) {
      if($optn =~ /-$inpt /i) { $optn =~ s/(-$inpt |$inpt)//gi; }
      else { $optn .= "-$inpt "; }
    }
    if($inpt =~ /q/ || $inpt =~ /x/) { print "Quitting Without Saving!\n"; }
  }
}
sub lspt { # utility to run `ls` with `pt` colors
  my $list = ''; my @ldat = `ls -l`;
  for(@ldat) {
    if($_ =~ /^(\S{10})\s.*\s(\d+)\s+(\w{3}\s+\d+\s+\d{2}:\d{2})/) {
      my $prmz = $1; my $cmpr = $prmz;
      my $fsiz = $2;
      my $stat = $3;
      my $b6fs = b64($fsiz); $b6fs = ' ' x (length($fsiz) - length($b6fs)) . $b6fs;
      # @s=split(/ /,scalar(localtime((stat(shift))[9])));print \"@s\";
      # use stat() instead of just appending '2004'
      my $ptim = Time::PT->new('verbose' => "$stat 2004");
      my $pcol = $ptim->color('ansi') . "\e[0;30m";
      if(length($pcol) < (8*5 + 7)) {
        $pcol .= '0' x (5 - int((length($pcol) - 7) / 8));
      }
      $pcol .= "\e[1;32m";
      $cmpr =~ s/r--/\e[1;34m4\e[1;32m/g;
      $cmpr =~ s/r-x/\e[1;35m5\e[1;32m/g;
      $cmpr =~ s/rw-/\e[1;36m6\e[1;32m/g;
      $cmpr =~ s/rwx/\e[1;31m7\e[1;32m/g;
      $cmpr =~ s/rws/\e[1;33m7\e[1;32m/g;
      s/^$prmz/$cmpr/;
      s/$fsiz/$b6fs/;
      s/$stat/$pcol/;
      $list .= $_;
    }
  }
  print $list;
}
sub fpt { # 37CFQAE - fpt created by Pip@CPAN.Org to format PipTime data like
#  `fmt` from "[{pt_descriptor}] Month {Day} {Hour:Minute:Second:60th} Year"
#   eg. '[OrigSent] ( Sat Jul 12 17:18:25:24 2003 ) ' or '[done] Jul 2003'
# Why:
#   This is mostly useful for my e-mail (`mutt`) reply attribution but 
#     might grow into other uses someday =).
  my @data = shift || <STDIN>; my $parm = '';
  my $ptst = 'http://Ax9.Org/pt?';
  for(@data) {
    chomp;
    if(/^\[[^\]]*\].*?((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\D+(\d+)\s*(\d*):?(\d*):?(\d*):?(\d*)\s*(\d*))/i) {
      $parm = $1;
      unless(/$ptst/) { 
        $_ .= ' ' unless(/ $/);
        $_ .= $ptst;
      } 
      $parm = Time::PT->new('verbose' => $parm);
      $_ .= "$parm";
    }
    print "$_\n";
  }
}
sub tolo { rename($_, lc($_)) for(@_); }
sub reso { my $optz = shift() || ''; # 598Bvas - reso created by Pip Stuart <Pip@CPAN.Org> to rank display resolutions by total pixels && aspect ratios.
  my @xdmz =( 7680, 3840, 3072, 2560, 2456, 2304, 2048, 1920, 1856, 1800, 1792, 1680, 1600, 1440, 1400, 1366, 1280,       1152,      1024,      800, 640     );
  my @ydmz =( 4320, 2400, 2304, 2048, 1920, 1600, 1536, 1440, 1392, 1350, 1344, 1280, 1200,             1024, 1050,  900,  864,  800, 768, 640, 600, 480, 400);
  push(@xdmz, 512, 480, 320      ); my @aspz =( (16/9) ,  (8/5) ,  (4/3) ,  (5/4)  ); map { $_ = sprintf("%-4.2f", $_) * 1.0 } @aspz;
  push(@ydmz, 384, 272, 240, 200 ); my @asps =( "16/9w", " 8/5w", " 4/3s", " 5/4s" ); my %rslt =();
  my %prcz =( '2560x1600' => [1444.15, 30, 'Dell 3007WFP'       ],
              '1920x1200' => [ 679.15, 24, 'Dell 2407WFP'       ],
              '1600x1200' => [ 359.20, 20, 'Dell 2007FP'        ],
#              '1680x1050' => [ 289.00, 20, 'Dell E207WFP'       ],
#              '1280x1024' => [ 159.20, 17, 'Dell E177FP'        ],
              '1680x1050' => [ 339.15, 20, 'Dell 2007WFP'       ],
              '1280x1024' => [ 247.20, 19, 'Dell 1907FP'        ],
              '1440x900'  => [ 189.99, 19, 'SCEPTRE X9WG-NagaV' ],
            );
  for my $xdim (@xdmz) {
    for my $ydim (@ydmz) {
      for(my $andx = 0; $andx < @aspz; $andx++) {
        if(abs($xdim - ($ydim * $aspz[$andx])) < 15) {
          $rslt{($xdim*$ydim)} = sprintf("%10s  %4sx%-4s  %5s(%-04s)  %3d/%-3d",
            coma($xdim*$ydim), $xdim, $ydim, $asps[$andx], $aspz[$andx], int($xdim/8), int($ydim/16));
          if(exists($prcz{$xdim . 'x' . $ydim})) {
            $rslt{($xdim*$ydim)} .= sprintf("     %8.2f   %8.2f     %8.2f         %s    %s",
              $prcz{$xdim . 'x' . $ydim}[0],
              $prcz{$xdim . 'x' . $ydim}[0] / (($xdim*$ydim) / 1000000),
              $prcz{$xdim . 'x' . $ydim}[0] / $prcz{$xdim . 'x' . $ydim}[1],
              $prcz{$xdim . 'x' . $ydim}[1],
              $prcz{$xdim . 'x' . $ydim}[2]);
          }
          $rslt{($xdim*$ydim)} .= "\n";
          last;
        }
  #      else { print "Fail: xdim:$xdim ydim:$ydim diff:" . ($xdim - ($ydim * $aspz[$andx])) . "\n"; }
      }
    }
  }
  print "  Pixels     Resoluti    Aspect    Chars(8x16)    Price    Price/MiPx    Price/Inch    Inches    Name\n";
  for(reverse(sort { $a <=> $b } keys(%rslt))) {
    if(length($optz)) { print $rslt{$_} if($rslt{$_} =~ /$optz/); }
    else              { print $rslt{$_}; }
  }
}
sub genbats { # generate Windows batch file wrappers for my perl utilities
  my $bind = shift(); my $batd;
  unless($^O eq 'MSWin32') {
    print "!*WARN*! Generating MSWin32 batch files on different platform!\n";
  }
  unless(-d $bind) { $bind = '/Pip/bin/'; }
  unless(-d $bind) { $bind = '/home/pip/bin/'; }
  unless(-d $bind) { die "!*EROR*! Couldn't find bin directory to generate batch files from!\n"; }
  $bind =~ s/\/*$/\//; $batd = $bind; $batd =~ s/^(.*)bin\//$1bat\//;
  for(glob($bind . '*')) {
    my $binf = $_;
    my $batf = $binf; $batf =~ s/^(.*)bin\//$1bat\//;
    open(BINF, '<', $binf);
    my $line = <BINF>;
    if($line =~ /^\#!.*perl/i) {
      mkdir($batd, 0755) unless(-d $batd);
      #print "Wrapping binf:$binf\n    with batf:$batf.bat\n";
      open(BATF, '>', "$batf.bat");
      print BATF "\@echo off\n\@perl $binf";
      for my $pndx (1..9) { print BATF " \%$pndx"; }
      print BATF "\n";
      close(BATF);
    }
    close(BINF);
  }
}
sub critarch { # create a new Critical files Archive
  my $arcf = $ENV{'HOME'};  $arcf =~ s/\\/\//g; $arcf =~ s/\/*$/\//;
       chdir($ENV{'HOME'}); $arcf .= 'dvl/utl/CritArch.ls';
  my $arzf = $arcf; $arzf =~ s/\.ls$/.tar/;
  if    (-e $arzf) { unlink($arzf); }
  unless(-r $arcf) { die "!*EROR*! Couldn't read CritArch.ls file!\n"; }
  open(ARCF, '<', $arcf);
  while(<ARCF>) { chomp();
    unless(/^\s*#/) { # skip comment lines
      if(s/\*$//) { # handle globs
        #printf("dir:%-43s at:%d\n", $_, -s $arzf);
        if(-w $arzf) {
          if(-s $arzf < 200000000) {                     system("tar  rf $arzf   $_   "); } # r == append to existing
        } else                     {                     system("tar  cf $arzf   $_   "); } # czvf is normal creation
      } else {
        if(-w $arzf)               {                     system("tar  rf $arzf   $_   "); } # r == append to existing
        else                       {                     system("tar  cf $arzf   $_   "); } # czvf is normal creation
      }
    }
  } close(ARCF);
  if(-w $arzf) { $arcf = $arzf; $arcf =~ s/\.tar$/.tgz/; system("gzip -c $arzf > $arcf"); unlink($arzf); } # zip it up
  chdir('dvl/utl'); $arcf =~ s/^.*dvl\/utl\///; bak($arcf); unlink($arcf);
}
sub bcho { # BigInt port of Math::BaseCnv::choo($ennn, $emmm)  (i.e., huge n choose m == (n! / (m! * (n - m)!)))
  my $ennn = shift(); my $emmm = shift(); return(0) unless(defined($ennn) && defined($emmm) && "$ennn" && "$emmm" && "$ennn" ne "$emmm");
  my $nbio = Math::BigInt->new("$ennn"); my $mbio = Math::BigInt->new("$emmm"); ($nbio, $mbio) = ($mbio, $nbio) if($nbio->bcmp($mbio) < 0); # mk sure n > m
  my $diff = $nbio->copy()->bsub($mbio); my $answ = $nbio->copy()->bfac(); my $mfct = $mbio->copy()->bfac(); my $dfct = $diff->copy()->bfac();
  $mfct->bmul($dfct);                    return(0) if($mfct->is_zero());   $answ->bdiv($mfct);               return($answ->bstr());
}
sub curs { # console cursor changing utility learned from TLDP.Org # NormBlinkU:echo-e'\033[?2c'BlinkBlk:echo-e'\033[?6c'RedNonBlinkBlk:echo-e'\033[?17;0;64c'
  # 2do: ch IF to resemble Simp's color spec
  my $csiz = shift || 0; my $ctms = shift || 0; my $csms = shift || 0; my($auth,$vers,$name)=('Pip@CPAN.Org','692Dt6U','curs');
  if($csiz) {
    if     (                 $csiz =~ /^-*[h?]/i) { # help
      print "Usage: $name <NewCursorValues>
  Change the console cursor by providing one to three decimal bytes for
    size, set-mask, and change-mask respectively.  They could also be
    joined bitwise in reverse order and provided as a single b64 number.
  Add 16 to the size for a software cursor.
  Add 32 to the size to always change the background color.
  Add 64 to the size to allow different foregrounds and backgrounds.
  Sizes less than one pick from pre-defined sets.
    *note* Highlights are ignored for the last two flags.

  Examples:
    `$name      `         # default blinking block
    `$name -1   `         # normal  blinking underline
    `$name  2   `         # normal  blinking underline
    `$name  6   `         #         blinking block
    `$name 17 64`         # red nonblinking block
  
    $name vers:$vers by auth:$auth

# The cursor appearance is controlled by a <ESC>[?1;2;3c escape sequence where 1, 2 and 3 are dec parmz described below. If you omit any of them, they dflt 0.
# 1 specz curs size (0=default, 1=invisible, 2=underline, ..., 8=full block)
#   + 16 if you want the software cursor to be applied
#   + 32 if you want to always change the background colour
#   + 64 if you dislike having the background the same as the foreground. Highlights are ignored for the last two flags.
# 2 pix char attz to ch (by XORing with val of param). standard VGA: high 4 bits spec bg and the low 4 fg. both: low 3 bits set colr (norm colr codz used by
#   console) and hi bit turns on hilite (or sometimes blinking--it depends on cfg of VGA).
# 3 is  char attz to set. set goes before togl, so you can simply clear bit by including in both set mask and toggle mask.\n"; exit();
    } elsif($csiz =~ /[^-0-9]/ || $csiz > 128) { # 4 b64 chrz -> b10, mask out 3 bytes in reverse order
      $csiz = b10($csiz); $csms = ($csiz & (255 << 16)) >> 16; $csiz &= 65535; $ctms = ($csiz & (255 << 8)) >> 8; $csiz &= 255;
    }
  }
  if   ($csiz >   0) { system("echo -ne '\\033[?$csiz;$ctms;$csms" . "c'"); } # parmd
  elsif($csiz ==  0) { system("echo -ne '\\033[?6c'                     "); } # BlinkBlock       # canned good settings
  elsif($csiz == -1) { system("echo -ne '\\033[?2c'                     "); } # NormBlinkU
  elsif($csiz == -2) { system("echo -ne '\\033[?17;0;64c'               "); } # RedNon-BlinkBlock
}
# with csiz:17 && varying csms
#   0: norm blink u
#   1: invis but  cyan? fg
#   2: invis but green? fg
#   3:            cyan?
#   4:           yellow
#   5:            white
#   6:           yellow
#   7:            white
#   8:            green
#   9:             cyan
#  10:            green
#  11:             cyan
#  12:           yellow
#  13:            white
#  14:           yellow
#  15:            white
#  16: drkblue?  bg, same fgz as above
#  32: drkgreen  bg, same fgz
#  48: drkcyan   bg
#  64: drkred    bg
#  80: drkpurple bg
#  96: orange    bg
# 112: drkwhite  bg
# 128: black     bg
# 144: blue      bg
# 160: green     bg
# 178: cyan      bg
# 192: red       bg
# 208: purple    bg
# 224: yellow    bg
# 240: white     bg
# with csiz:17 && varying ctms
#   0: green     fg normal blinking u
#   1: cyan      fg invis
#   2: black     fg
#   3: blue      fg
#   4: yellow    fg
#   5: white     fg
#   6: red       fg
#   7: purple    fg
#   8: drkgreen  fg
#   9: drkcyan   fg
#  10: totally invis, drkblack fg on drkblack bg
#  11: drkblue   fg
#  12: orange    fg
#  13: drkwhite  fg
#  14: drkred    fg
#  15: drkpurple fg
#  16: drkblack? bg w/ green? fg
#  32: drkgreen  bg
#  48: drkcyan   bg
#  64: drkred    bg
#  80: drkpurple bg
#  96: orange    bg
# 112: drkcyan   bg
# 128: drkgreen  bg
# 144: blue      bg
# 160: green     bg
# 176: cyan      bg
# 192: red       bg
# 208: purple    bg
# 224: yellow    bg
# 240: white     bg

127;

=head1 NAME

Pip::Utl - Pip's Utilities

=head1 VERSION

This documentation refers to version pKGvERS of fULnAME, which was released on ptptIME.

=head1 SYNOPSIS

  use fULnAME;

  # coma
  # shuf
  # left
  # rght
  # asci
  # dum2umd
  # syncdate
  # etc.

=head1 DESCRIPTION

pKGnAME is a package that contains most of my Perl utilities.
Whatever common functions or objects I want to have access to
anywhere, I intend to keep here.

=head1 2DO

=over 2

=item - write pod

=item - write tests

=item -    What else does pKGnAME need?

=back

=head1 USAGE

4NT Variable Functions Ported to Perl:

=head2 coma($string, [$sep_char[, $group_count]])

Insert commas (or other separator characters) into a parameter string.
The first parameter is the string you want separated.  The optional
second parameter is the character you'd like to insert instead of the
default comma.  The third optional parameter is the number of
characters you'd like to keep grouped together instead of the default 3.

=head2 tild($filename)

Expands a tilde character at the beginning of a filename into the likely
/home/ directory on a Unix filesystem.

=head2 left($char_count, $string)

Return the  left-most x characters of a string.  The first parameter is
the number of characters to select.  The second parameter is the string.

=head2 rght($char_count, $string)

Return the right-most x characters of a string.  The first parameter is
the number of characters to select.  The second parameter is the string.

=head1 CHANGES

Revision history for Perl extension fULnAME:

=over 4

=item - pKGvERS  ptptIME

* added kwalitee to 2do of e()

* added lspt, fpt, tolo, && genbats

* added bin wrapper generation for e('pkg') of Pip::Utl

* added Build.PL generation to e('pkg')

* original version

=back

=head1 INSTALL

Please run:

  `perl -MCPAN -e "install fULnAME"`

or uncompress the package && run the standard:

  `perl Makefile.PL;       make;       make test;       make install`
    or if you don't have  `make` but Module::Build is installed
  `perl    Build.PL; perl Build; perl Build test; perl Build install`

=head1 LICENSE

Most source code should be Free!  Code I have lawful authority over is && shall be!
Copyright: (c) 2004-2007, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License (version 2).  Please consult the Free Software Foundation (HTTP://FSF.Org)
  for important information about your freedom.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
