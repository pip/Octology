# 4BRJ6kpc:Pip::Utl.pm crE8d by PipStuart <Pip@CPAN.Org> to centralize && generalize calling my personal utility programs;
# 2du:reEvalU8 criterion for inclusion in Utl generally (aiming for guidance on what to localize to ~/bin rather than here or other modules),
#   Is the only cohesion to Utl that it's a dumping ground for whatever's not already in existing dvl|CLI|filz|GNULin|4NT|muz|img|time|math|dom|othrUtlz?
#   wrap ~/bin like below for all that belong here in Utl,loop thru evald uses2flag succ|fail,genb(in|at) like:
##!/bin/sh # I don't think this #! is needed to specify default sh, but #!perl below is bkup, both requiring shell bin/ command name to totally match sub here;
#           perl -MPip::Utl -e "$( echo $0 | sed 's/.*\///' )(   qw($*   ) )"
##!/usr/bin/perl
#     use          Pip::Utl ;        $_=$0;       s/.*\///;eval("$_(@ARGV)");
  package          Pip::Utl ;
      use strict;  use utf8 ;#use warnings;
  require          Exporter ;
      use base    'Exporter';
      use     Octology::a8                    ;
      use     Octology::b8                    ;
      use     Octology::d8                    ; # load the following modules if available
eval('use         File::Copy         qw(cp mv);');
eval('use          Pod::Text                  ;');
eval('use         Math::BigInt                ;');
eval('use         Math::BigFloat              ;');
#val('use         Math::BaseCnv      qw(:all );');
eval('use        Games::Cards::Poker qw(:all );');
eval('use         Time::DayOfWeek    qw(:all );');
eval('use         Time::PT                    ;');
eval('use       Curses::Simp                  ;');
eval('use          XML::Tidy                  ;');
eval('use          XML::Merge                 ;');
our @EXPORT=qw(e bak updt tild qolm syncdate vollabel forfiles longlinz tiglet genbats left rght cfdd locd fpt lspt xprp rdhd
  foggsync timerun runbench domserch critarch); # port to U8?:e bak  f8:tiglet
my $VERSION='0.0';my $d8VS='H5QM7xJd';our $Dbug=0; # Gl0balDbugFlag  # used to have @Dayz && @Monz here, but reloc8d to a8.pm instead
sub tild{ # translating fylnm tildes(~)(also fromPerlFAQ5) # use <> (glob()) wi shell that groks ~ or try Glob::KGlob||File::HomeDir nstd ofPurePerl belo:
  my $filn = shift; $filn =~ s/^~([^\/]*)/$1 ? (getpwnam($1))[7] : ( $ENV{'HOME'} || $ENV{'LOGDIR'} )/ex;  return($filn); } # Eval replacement && Xtra spaces
sub left{my $coun = shift;my $strn = shift;if(defined($strn) && defined($coun) && $coun =~ /^\d+$/){ return(substr($strn,     0,$coun)); }else{ return(''); }}
sub rght{my $coun = shift;my $strn = shift;if(defined($strn) && defined($coun) && $coun =~ /^\d+$/){ return(substr($strn,-$coun,$coun)); }else{ return(''); }}
sub longlinz{ # 823IsVV: utl2read $ENV{PipzWidt}&&prnt longlyn Nfo; 2du:aceptSTDIN,
  my $llfl = shift || $ENV{'EDTF'    } || $ENV{'EDITFILE'};return unless(defined($llfl) && -r $llfl);my @llfd; # belo =~ s/.*/Perl6::Slurp/
  my $widt = shift || $ENV{'PipzWidt'} || $ENV{'COLUMNS' } || 80;my $pwid = $widt - 15;my $b64f = shift || 0;open(LLFL,'<',$llfl);@llfd = <LLFL>;close(LLFL);
  for(0..$#llfd){my $llen = length($llfd[$_]);if($llen>$widt){if($b64f){printf("%2s:%2s:%s...\n",b64($_+1),b64($llen),left($pwid,$llfd[$_]))}
                                                              else     {printf("%4d:%4d:%s...\n",    $_+1 ,    $llen ,left($pwid,$llfd[$_]))}}}}
                                                                    #printf("lin%2s:%4d-len%2s:%4d:%s...\n",b64($_),$_,b64($llen),$llen,left($pwid,$llfd[$_]));
sub bak{#H5JM2bMF:`bak`l8st major upd8; 267KBPZA:auto-backup a file into './.bak/' with a -`d8` appended before the extension, or at the end if none
  # 2du:aftr doing `ea` from ~/dvl/c8/simp/ I edited again with just `e` but vim 'B' key for calling `bak` made ~/.bak/-$d8.zshrc instead of normal .zshrc-$d8
  #     ... so I had to  `cd ~/.bak;rename 's/^(-........)(\..*)$/$2$1/' *` to fix those && several others that were much older so fix that in here,
  #   refactor ~/.erc searching code from bak&&e,add -optz lsb LiStBakz,bkd parm2tst isBkDup?,dif w/prev,re[sv] RE(Store|Vert2) prev,ifc 2onlyBakIfSrcCmpilz
  #   forget about $^O OS Type&&`fc.exe`4 MSWin,hndl flnmz =~ /\s/,mk ifc Dflt2not let bak cp unles`perl -c`,tst;
  my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); # at least assume 4NT shell
  my $ttyn = $ENV{'TTY'} || $ENV{'_SHELL'} || ''; $ttyn = shift || '' unless(length($ttyn));my $mulf=0;$mulf=1 if(@_ && $#_); # bakng multiple filez flag?
  my $srcf = shift ||  $ENV{'EDTF'} || $ENV{'EDITFILE'} || ''; my $dstf;my $home = $ENV{'HOME'} || '/home/pip';$home =~ s|/+$||;my $cwdr;
  if(length($ttyn)) {
    if   ($ttyn =~ /^(\/dev\/(tty|vc\/))/) { $ttyn =~ s/^$1//;  }
    elsif($ttyn =~ /^(\/dev\/pts\/)/     ) { $ttyn =~ s/^$1/x/; }
    elsif(!length($srcf))                  { $srcf = $ttyn;     } }
  unless(-d $home . '/.erc') {
    mkdir(  $home . '/.erc', 0700); }
  if(-d $home . '/.erc') {
    my $ercg = $home . '/.erc/eall';      # Global .erc/eall  filelist
    my $ercl = $home . '/.erc/e' . $ttyn; # Local  .erc/e$TTY filelist
    if($osty eq 'good') { $cwdr = `pwd`; }
    else                { $cwdr =  `cd`;
      if($srcf eq  '*') { unshift(@ARGV, $_) for(glob("*.*")); $srcf = shift; } }
    chomp($cwdr);
    my $extn; my @tsts; my $pass; my $pktm = `d8`;#Time::PT->new();
    if(!-r $srcf && -r $ercl && open(ERCL, '<', $ercl)) { chomp($srcf = <ERCL>); close(ERCL); }
    if(!-r $srcf && -r $ercg && open(ERCG, '<', $ercg)) { chomp($srcf = <ERCG>); close(ERCG); }
    die "!*EROR*! Please pass bak a filename to backup!\n" unless(-r $srcf);
    unless(-d '.bak') { mkdir('.bak') || die  "!*EROR*! Couldn't create '.bak' directory!\n"; }
    unless(-w '.bak') {                  die  "!*EROR*! Cannot write to '.bak' directory!\n"; }
    while ( $srcf   ) {
      if(-f $srcf && -r $srcf) { $dstf = $srcf; $extn = '';
        if($dstf =~ s/^(.+)(\..{1,5})$/$1/) { $extn  = $2;   # strip file extension !*Note*! Are there any extensions >5 chars worth supporting? Not so far.
          $extn  = ".tar" . $extn if($dstf =~ s/^\.tar$//);} # special-case to put -d8 before .tar.(gz|bz2|.*) also
        if($dstf =~ /\//) { $dstf =~ s/(.*)\//$1\/.bak\//; } else { $dstf =~ s/^/.bak\//; }
        unless($osty eq 'good') { $srcf =~ s/\//\\/g; $dstf =~ s/\//\\/g; } # kaka dir-separators?
        @tsts = reverse(sort(glob($dstf . "-????????" . $extn))); $pass = 1; # probably eventually better to employ d8-specific sorting
        if(@tsts) { @tsts = @tsts[0..7] if(@tsts > 8); # test last 8 backups for differences before proceeding (originally was just 3)
          for(@tsts) { 
            if($osty eq 'good') { $pass =  `diff --brief $_ $srcf`;
              unless($pass)     { $_    =~ s/^$cwdr[\\\/]//;$srcf =~ s/^$cwdr[\\\/]//;
#                  s/(.*)-(.)(.)(.)(.)(.)(.)(.)(.)/$1-$R$2$O$3$Y$4$G$5$C$6$B$7$M$8$P$9$G/; # better to pass to a8::d8colr
#               if( /(.*)-(.{8})/){my $clrd=d8colr($2);
#                  s/(.*)-(.{8})/$1-$clrd$z/;} # actually better to just c8fn whole name, but not so easy to do for srcf yet
                $_ = c8fn($_);
                printf("!*EROR*! File: '%-16s already bak'd up as '%s'!\n", $srcf . "'", $_); last;
              }}}}
        if($pass) { $dstf .= "-$pktm" . $extn;    cp($srcf,$dstf);
          if($osty eq 'good'){ $pass = `diff --brief $srcf $dstf`; if(length($pass)){$pass=0;}else{$pass=1;}}
          $srcf =~ s/^$cwdr[\\\/]//;$dstf =~ s/^$cwdr[\\\/]//;
          if(-e $dstf) {
            if( $pass) { $dstf = c8fn($dstf); # SUCCESS!  # maybe longstanding quotez around filez below were mainly only there for rare spaced out namez
                     printf("${B}bakd$C %-16s$M as %s$z"                , $srcf      , $dstf); print "\n" if($mulf); # trying to add a bit betr color8ion
            } else { printf("!*EROR*! File: '%-16s differs from '%s'!\n", $srcf . "'", $dstf); } # FAILED `diff`
          } else   { printf("!*EROR*! Couldn't bak up: '%-16s as '%s'\n", $srcf . "'", $dstf); } # FAILED output-file-creation or something else
        }
      } $srcf = shift; }
  } else           { print( "!*EROR*! Couldn't find ~/.erc/ at: '$home/.erc/'\n"); } }
#  `loc8 -r '\.xml$'|perl -ne 'chomp;if(-f "$_"){s/(^[^"])/"$1/;s/([^"]$)/$1"/;print "$_\n"}'|xargs du -sb|sort -n`A1M:wiBep(V&&Jak)ckng4lrgXML2tst`xbcmprs`on
sub locd{ # 81756aW: tk a file parm,loc othrz,sort by siz, eventually diff,show selected,filter out uninteresting,maybe show/sort PT,%dif,interactive...
  my $srcf = shift || exit; my %filz; my $size; my $widt = 1; my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); #assume4NT?
     $srcf = "\"/$srcf\$\"" unless($srcf =~ /([^\\][?|*]|\$$)/); print "LocD:$srcf...\n"; # e.g., `locd "\.\?\(LS\|DIR\|dir\)_\(COLORS\|colors\)"`
  for(split(/\s+/,`locate -r $srcf`)){ $size = -s; push(@{$filz{$size}},$_); $widt = length("$size") if($widt < length("$size")); }
  for(sort {$a <=> $b} keys(%filz)){ for my $file (@{$filz{$_}}){ printf("%${widt}d%5dM%5dA%5dC $file\n",$_,-M $file,-A $file,-C $file)}}}
sub cfdd{ # 776EPNb: tk a dir param containing subdirs of form .+-PipTime which should have all contents compared to Consolidate Files, Discarding Duplicates
  my $srcd = shift || './'; $srcd =~ s/[\\\/]+$/\//; my %filz; my %namz; my $pass; my $size; my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); #assume4NT
  die "!*ER0R*! Please pass $0 a directory name to consolidate files under!\n" unless(-d $srcd); $srcd =~ s/\//\\/g unless($osty eq 'good'); # kaka dir-separs?
  for(glob($srcd . '**/*')){ $pass = 1; $size = -s; #printf("TstF:size:%10d name:$_...\n", $size);
    if(exists($filz{$size})){ for my $file (keys(%{$filz{$size}})){ if($osty eq 'good'){ $pass = `diff --brief $_ $file`;
          if(!$pass                                    ){       printf("!*WARN*! Already found file:'$_'!\n");last}               }
                                                                    else               { $pass = `fc           $_ $file`; # force pass2 tru1 belo sinc fylzRdif
          if( $pass =~ /FC: no differences encountered/){       printf("!*WARN*! Already found file:'$_'!\n");last}else{$pass = 1}}}}
    if($pass){ if(/^\.\/pix-KRZR-(\w{7})\//){ my $pipt = '776DDNN'; # 776JVCL: custom KRZR pix matching for consolidation
        #my $ptim = $1; if($ptim ne $pipt){ my $srcf = $_; s/^(\.\/pix-KRZR-)$ptim\//$1$pipt\//; mv($srcf,$_); print "mv($srcf,$_);\n"}
      } $filz{$size}{$_} = 1; } } for(keys(%filz)){ for my $file (sort(keys(%{$filz{$_}}))){ $namz{$file} = 1; delete($filz{$_}{$file})}}
  print "\n\nUnique files:\n",join("\n",sort(keys(%namz))),"\n"; }
sub updt{ # 58LNk1v: update most recent .pm file into '~/lib/'; # 2du:might not want to cp all -x files to ~/bin since CygWin mkz .pmz +x
  my $osty = 'good'; $osty = 'kaka' if($^O eq 'MSWin32'); # at least assume 4NT shell
  my $ttyn = $ENV{'TTY'} || $ENV{'_SHELL'} || ''; $ttyn = shift || '' unless(length($ttyn));
  my $srcf = shift || $ENV{'EDTF'} || $ENV{'EDITFILE'} || ''; my $dstf;my $home = $ENV{'HOME'} || '/home/pip';
  $home = 'C:\\home\\pip' if($osty ne 'good' && $home eq '/home/pip'); $home =~ s/[\\\/]$//; my $cwdr;
  if(length($ttyn)){
    if   ($ttyn =~ /^(\/dev\/(tty|vc\/))/) { $ttyn =~ s/^$1//;  }
    elsif($ttyn =~ /^(\/dev\/pts\/)/     ) { $ttyn =~ s/^$1/x/; }
    elsif(!length($srcf))                  { $srcf = $ttyn;     } }
  unless(-d $home . '/.erc'){ mkdir($home . '/.erc', 0700); system("attrib /d +h $home/.erc") if(-d $home . '/.erc' && $osty ne 'good'); }
  if(-d $home . '/.erc'){
    my $ercg = $home . '/.erc/eall';      # Global .erc/eall  filelist
    my $ercl = $home . '/.erc/e' . $ttyn; # Local  .erc/e$TTY filelist
    if($osty eq 'good'){ $cwdr = `pwd`; }
    else               { $cwdr =  `cd`; if($srcf eq '*'){ unshift(@ARGV, $_) for(glob("*.pm")); $srcf = shift; } }
    chomp($cwdr); my $pktm = Time::PT->new(); chomp($pktm); my $extn; my @tsts; my $pass;
    if(!-r $srcf && -r $ercl && open(ERCL, '<', $ercl)){ chomp($srcf = <ERCL>); close(ERCL); }
    if(!-r $srcf && -r $ercg && open(ERCG, '<', $ercg)){ chomp($srcf = <ERCG>); close(ERCG); }
    while($srcf){
      die "!*ER0R*! Please pass updt filenames of readable .pm or +x files to install!\n" unless(-r $srcf &&(-x $srcf || $srcf =~ /\.pm$/));
      if(-x $srcf){ print "updt $srcf -> $home/bin/...\n";       cp($srcf,"$home/bin/"     ); }         # && cp  file
      else{ my $dirn; open(SRCF, '<', $srcf);                                  # read module package path && construct ~/lib dirs necessary
        while(<SRCF>){ if(/^\s*package\s+([^;]+);/i){ my $pkgn = $1; my $filn; $dirn = $pkgn; $dirn =~ s/::/\//g;if($dirn =~ s/\/([^\/]+)\/?$//){ $filn = $1; }
            if(defined($filn) && $srcf =~ /$filn\.pm$/){  system("mkdir -p $home/lib/$dirn"); last; } } } # `md -p`will create Parent dirz on any good 0pr8nSys
        close(SRCF); print "updt $srcf -> $home/lib/$dirn/...\n";cp($srcf,"$home/lib/$dirn");           # && cp  file but need2tst th@ propr $dirn found etc.
      } $srcf = shift; } }else{ print("!*ER0R*! Couldn't find ~/.erc/ at: '$home/.erc/'\n"); } }
sub domserch{ # find all short unused domains # Params: StringLengths2Test, #ofIncrementalTests, Start# : 34,1258,1294
  my $logf = shift||"freedomz.txt";my @tldz = ("Com", "Net", "Org");my @chrz=('0'..'9','a'..'z');
  my $dlim = shift || 3;
  my $limt = shift || scalar(@chrz)**$dlim; # 4
  my $strt = shift || 0;
  my $test = ""; my $rslt = ""; my $temp = ""; 
  my $digt = @chrz; $digt = $digt**$dlim;
  $strt %= $digt; if ($limt > ($digt - $strt)) { $limt = $digt - $strt; }
  print "Starting: $strt Ending: $limt...\n";
  while($strt < $limt){
    my $tstr = $strt; $test = "";
    for(my $l=1;$l<$dlim;$l++){
      if($tstr > $#chrz){
        $digt = $tstr - (int($tstr / ($#chrz+1)) * ($#chrz+1));
        $test = $chrz[$digt] . $test;
        $tstr /= ($#chrz+1)}}
    $test = $chrz[$tstr] . $test;
    while(length($test) < $dlim){$test = $chrz[0] . $test} #print "$test,"; 
    for(@tldz){ $rslt = `whois $test.$_`;
      if($rslt =~ /No match for "$test/i) { open(LOGF, '>>', $logf); print LOGF "$test.$_\n"; close(LOGF); }
    }$strt++; #print ".";
  }open(LOGF,'>>',$logf);print LOGF "Completed $limt!\n";close(LOGF)}
sub qolm{my   $dfil=shift||"freedmz3.txt";my $q0lm=shift||160;my $plre=shift||'';my $limt=shift||0;#prnt up2$4 joind fyl$1 lynz2B<$2qkc0lumnzl0ng aftREs/$3//g;
  open(DFIL,"<$dfil");my @fdat;if($limt--){push(@fdat,<DFIL>) for(0..$limt)}else{@fdat=<DFIL>}close(DFIL);$limt=$#fdat if($limt<1);my $clyn='';#(\.Org|\n)+//g;
  print("$0:Print up to:\$4 joined file:\$1 lines to be less than:\$2 columns long after running the Perl RegularExpression:s/\$3//g;\n",
    "\$1-file:$dfil; \$2-q0lm:$q0lm; \$3-plre:$plre; \$4-lyndx:0..$limt==limt-1;\nStripngPerLRegEx(ifNE)4EchOrigFylLyn(Up2Limt)B4joining2Bprntd<q0lmL0ng..\n");
  for(@fdat){s/$plre//g if($plre);if(length("$clyn$_ ")<$q0lm){$clyn.="$_ "}else{print "$clyn\n";$clyn=$_}}} #kinda lyk!fmt 4m@ngUtl2join sh0rt&&prntl0nglynz;
sub e{my($auth,$vers,$d8vs,$name)=('Pip@CPAN.Org','2.0','E4IM2Qjq','e'); # considering whether 8 alias && e shud B distinct for now to offer different options?
  # 398GX2X: e crE8d by             Pip@CPAN.Org to manage file Editing  # can't create merely sub 8{} in Perl here, but alias should wrap eventual vim clone
  # 2du:refactor ~/.erc/ searching code from e,bak,updt,cfdd with ~/.erc/* into ~/.e/ instead (/rc$/ being ResourceConfig text files rather than subdir names)
  #   mv .e/.erc .. && experiment with allowing perl with quotable d8a string hash maps when detected not mere sparsest split (which should also take comments)
  #   mv .e/ex* ex.b64(Xpan)
  #   add kwalitee:
  #    - has_proper_version: remove letters? yep, time to
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
             'rc'   => '~/.erc/.erc'         ,
             'a'    => '~/.zshrc'            ,
             'z'    => '~/.zshrc'            ,
             'v'    => '~/.vimrc'            ,
             'h'    => '~/.history'          ,
             'p'    => '~/dox/phonbook.txt'  ,
             't'    => '~/dox/2du/Taki.txt'  ,
             '2'    => '~/dox/2du/2du.txt'   ,
             '3'    => '~/dox/H3AR.Us/*.htm' ,
             '8'    => '~/dox/2du/8.txt'    );
  if(-r "$home/.erc/.erc"){open(ERCF,'<',"$home/.erc/.erc");
    while(<ERCF>){my @eflz=split;
      if(@eflz==2&& defined($eflz[0])&& length($eflz[0])&& $eflz[0]!~/^#/&&
                    defined($eflz[1])&& length($eflz[1])){ $pref{$eflz[0]}=$eflz[1]}}close(ERCF)}
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
  if(!length($file) || $file =~ /^(l+|g+)$/){
    if(@gdat && (!@ldat || $file =~ /^g+$/)){
      if   (        !length($file)) { $file = $gdat[ 0]}
      elsif(@gdat <= length($file)) { $file = $gdat[-1]}
      else { $file = splice(@gdat, length($file),    1)}
    } elsif(      @ldat                    ){
      if   (        !length($file)) { $file = $ldat[ 0]}
      elsif(@ldat <= length($file)) { $file = $ldat[-1]}
      else { $file = splice(@ldat, length($file),    1)}}}
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
            } else { die "!*ER0R*! Please update the CHANGES text for: $pkgd{'wipm'}!\n"; }
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
                if(exists $pkgd{'flag'}->{'chngsect'}) { die "!*ER0R*! Please update the CHANGES text for: $wopm!\n"; }
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
                open(DSTF, ">$pkgd{'fnem'}-$pkgd{'pver'}/$_") or die "!*ER0R*! Couldn't open(DSTF, $pkgd{'fnem'}-$pkgd{'pver'}/$_)!\n";
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
                } else { print "!*ER0R*! Couldn't open SourceFile: $_ for reading!\n"; }
                close(DSTF);
                if(-x $_){chmod(0755,"$pkgd{'fnem'}-$pkgd{'pver'}/$_")}
                else     {chmod(0644,"$pkgd{'fnem'}-$pkgd{'pver'}/$_")}
              }
              if($pkgd{'fnam'} eq 'Pip::Utl'){ # generate Utl bin wrappers
                mkdir(           "$pkgd{'fnem'}-$pkgd{'pver'}/bin", 0755) unless(-d "$pkgd{'fnem'}-$pkgd{'pver'}/bin");
                for(@EXPORT){
                  open( GENU,'>',"$pkgd{'fnem'}-$pkgd{'pver'}/bin/$_");
                  print GENU "#!/usr/bin/perl -MPip::Utl -e $_(\@ARGV);\n";
                  close(GENU);
                 #cp(.zshrc,"$pkgd{'fnem'}-$pkgd{'pver'}/bin/");
                 #cp(.vimrc,"$pkgd{'fnem'}-$pkgd{'pver'}/bin/");
                }
              }
  #  5) warn if no test.pl script exists
              if(exists $pkgd{'test'}){
  #  6) warn if pod doesn't exist, doesn't have NAME, VERSION, SYNOPSIS, 
  #    DESCRIPTION, LICENSE|COPYRIGHT, or AUTHOR.? headings
                for(@{$pkgd{'pdat'}}){if(/^=(head1|cut)/){$pkgd{'pode'}=1;last;}} # verify POD exists in PM
                if(exists $pkgd{'pode'}){ # ck for POD head1s
                  for my $reky (keys(%podr)){print "!*ER0R*! Expected POD heading: $reky missing!\n" unless(exists $pkgd{'flag'}->{$reky});}
                  mkdir("$pkgd{'fnem'}-$pkgd{'pver'}/t", 0755) unless(-d "$pkgd{'fnem'}-$pkgd{'pver'}/t");
                  open(   PTFL,'>', "$pkgd{'fnem'}-$pkgd{'pver'}/t/00pod.t" );print PTFL 'use Test::Pod; all_pod_files_ok();';close(PTFL);
                  unless(exists $pkgd{'podc'}){ print ":*WARN*: No t/\\d*podc.t found.  Auto-adding t/00podc.t.\n"; # generate t/00podc.t
                    open( PCFL,'>', "$pkgd{'fnem'}-$pkgd{'pver'}/t/00podc.t" );
                    print PCFL "use Test::Pod::Coverage 'tests' => '1'; pod_coverage_ok('$pkgd{'fnam'}', 'POD Covered');"   ;close(PCFL); }
  #  7a) generate MANIFEST.SKIP if it doesn't exist
                  unless(-r     $pkgd{'wmsk'}){
                    open( WMSK,'>', "$pkgd{'fnem'}-$pkgd{'pver'}/MANIFEST.SKIP");
                    print WMSK "\\bCVS\\b\n";
                    print WMSK "^Makefile\$\n";
                    print WMSK "^MANIFEST\\.bak\$\n";
                    print WMSK "^updt.*\$\n";
                    print WMSK "\\.bak\$\n";
                    print WMSK "\\.swp\$\n";
                    print WMSK "\\..*\\.swp\$\n";
                    print WMSK "\\b\\.xvpics\\b\n";
                    print WMSK "~\$\n";
                    close(WMSK);}
  #  7b) generate README  from pod with pIPtIME && pKGnAME if necessary
                  unless(exists $pkgd{'rdme'}){  # generate README  from pod
                    my $podt = Pod::Text->new(); # Read POD from A && write B
                    if($pkgd{'wich'} =~ /\/lib\/$pkgd{'fnim'}/){
                      $podt->parse_from_file("$pkgd{'fnem'}-$pkgd{'pver'}/lib/$pkgd{'fnim'}.pm", "$pkgd{'fnem'}-$pkgd{'pver'}/README");}
                    else                                       {
                      $podt->parse_from_file("$pkgd{'fnem'}-$pkgd{'pver'}/$pkgd{'fnym'}.pm"    , "$pkgd{'fnem'}-$pkgd{'pver'}/README");}}
                  mkdir("$pkgd{'fnem'}-$pkgd{'pver'}/ex", 0755) unless(-d "$pkgd{'fnem'}-$pkgd{'pver'}/ex");
                  unless(exists($pkgd{'xmpl'})){my $done = 0; # generate ex/synopsis.pl from README
                    open(RMFL, '<', "$pkgd{'fnem'}-$pkgd{'pver'}/README");
                    open(EXFL, '>', "$pkgd{'fnem'}-$pkgd{'pver'}/ex/synopsis.pl");
                    while(    !$done && ($line = <RMFL>)){ if(uc($line) eq "SYNOPSIS\n"){
                        while(!$done && ($line = <RMFL>)){
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
                }else{print "!*ER0R*! No POD found within package: $pkgd{'wipm'}!\n";
                      print "  Please define some Perl Documentation in your module.\n"}
              }  else{print "!*ER0R*! No test file detected in MANIFEST!  Please define either\n";
                      print "  a test.pl file or t/TESTNAME.t && add it to MANIFEST.\n"}}
          }      else{$pkgd{'pver'}='' unless(exists $pkgd{'pver'});
                      print "!*ER0R*! Detected VERSION: $pkgd{'pver'} doesn't match expected\n";
                      print "  format of \$MAJOR.\$MINOR.\$PIPTIME! (eg. 1.0.37SLNGN)\n"}}}}
    if($pkgd{'fail'}){print "!*ER0R*! \`e pkg\` couldn't locate a suitable MANIFEST file!\n";
                      print "  Please run it again as \`e pkg /path/to/pkg/MANIFEST\`.\n";
      if($Dbug      ){print "\nPackage Hash:\n"; print "$_:$pkgd{$_}\n" for(keys(%pkgd))}}
  }elsif($file eq'ul'){ # special 'ul' file case for completed pkgs; # first ck if cwd is 2..4 deep from a /lib/
    if   (-d       '../../lib' && -d       '../../.bak' && !-d       '../../../../home'){chdir(         '../..')}
    elsif(-d    '../../../lib' && -d    '../../../.bak' && !-d    '../../../../../home'){chdir(      '../../..')}
    elsif(-d '../../../../lib' && -d '../../../../.bak' && !-d '../../../../../../home'){chdir(   '../../../..')}
    unless(-d '.bak'){die "!*ER0R*! Couldn't find '.bak' directory with .tgz file to cpan-upload-http!\n"}
    chdir(    '.bak'); # then abov look in .bak for the  newest x-pt.tgz file && run cpan-upload-http on it
    @pkgz=reverse(sort(glob("*.???????.tgz")));
    unless(@pkgz    ){die "!*ER0R*! Couldn't find .tgz file!\n"}
    $_   = $pkgz[0];s/\.(.)(.)(.)(.)(.)(.)(.)\.tgz$/.\e[1;31m$1\e[0;33m$2\e[1;33m$3\e[1;32m$4\e[1;36m$5\e[1;34m$6\e[1;35m$7\e[1;32m.tgz/;
                    s/-(\d+)\.(\d+)\./-\e[1;33m$1\e[1;37m.\e[1;36m$2\e[1;37m./;
    print  "cpan-upload-http -verbose : $_...\n"; # `echo -n "Testing cpan-upload-http - please ignore this file." >please-ignore`;
    system("cpan-upload-http -verbose $pkgz[0]");chdir('..');
  }else{ # regular file case
    for my $qrex (@srch){unless(-r $file){for(@ldat){if(/$qrex/){$file=$_;last}}}} # search for progressively easier LOCAL  matches; # should it ignore case?
    for my $qrex (@srch){unless(-r $file){for(@gdat){if(/$qrex/){$file=$_;last}}}} # search for progressively easier GLOBAL matches; # should it ignore case?
    if($verb){die "!*ER0R*! Can't edit directory: $file!" if(-d $file)}
    $file =~ s/^\.\//$cwdr\//;
    $file =~ s/^\~\//$home\//;
    $file =$cwdr . '/' . $file unless($file =~ /^\//);
    for(my $i=0;$i<@ldat;$i++){splice(@ldat, $i--, 1) if($file eq $ldat[$i])}
    for(my $i=0;$i<@gdat;$i++){splice(@gdat, $i--, 1) if($file eq $gdat[$i])}
    unshift(@ldat, $file);
    unshift(@gdat, $file);
    if(open(ERCL, ">$ercl")){print ERCL "$_\n" for(@ldat);close(ERCL)}
    else                    {print("!*ER0R*! Couldn't update Local  erc file: $ercl!\n")}
    if(open(ERCG, ">$ercg")){print ERCG "$_\n" for(@gdat);close(ERCG)}
    else                    {print("!*ER0R*! Couldn't update Global erc file: $ercg!\n")}
    system(qq($edit +\\'\\" $file))}}
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
  for(glob($path . "/*.flac")){
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
    if($coun){exit unless(--$coun)}}}
sub foggsync{my($otmp,$wtmp,$oreg,$wreg); # 43EN5kI: foggsync.pl created by Pip Stuart <Pip@CPAN.Org> to synchronize my flac && ogg music archives
  my $fpth = $ENV{'HOME'} . "/muz/flac";
  my $opth = $ENV{'HOME'} . "/muz/ogg" ;mkdir($opth,0755) unless(-d $opth);SyncFlac($fpth);
  for     my $subd (glob($fpth . "/*")){if(-d $subd){$otmp=$subd;$otmp=~s/$fpth/$opth/;
                                        mkdir($otmp,0755) unless(-d $otmp);SyncFlac($subd);
      for my $ssbd (glob($subd . "/*")){if(-d $ssbd){$otmp=$ssbd;$otmp=~s/$fpth/$opth/;
                                        mkdir($otmp,0755) unless(-d $otmp);SyncFlac($ssbd)}}}}}
sub forfiles{
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
      rename($flnm,$newn)}
    $flnm=shift}}
sub FixxName{my $name=shift;my $fpth=shift; # substitute characters && patterns to good media filenames
       $name=~s/\//-/g if(!$fpth);
       $name=~s/['"*<>?\[\]]//g;
       $name=~s/ /_/g;
       $name=~s/:/-_/g;
       $name=~s/(^|[^\\])([!&=+()])/$1\\$2/g;
       $name=~s/___/_/g;return($name)}
sub timerun{ # 46ANK5t - timeRun.pl created by Pip Stuart <Pip@CPAN.Org> to time execution of different executables.
  my $exec = shift() || die("!*ER0R*! Please supply an executable to time!\n");
  my $runs = shift() || 1; my $ptb4; my $ptaf; my $tdif;
  $ptb4 = Time::PT->new(); printf("PTb4:$ptb4 expand:%s\n", $ptb4->expand()); for(1..$runs) { system($exec); }
  $ptaf = Time::PT->new(); printf("PTaf:$ptaf expand:%s\n", $ptaf->expand()); $tdif = $ptaf - $ptb4; # Time::Frame
  printf(" Dif:%s seconds:%s\n", $tdif->total_frames(), ($tdif->total_frames() / 60))}
sub runbench{ # 46CMTX9 - runBench.pl created by Pip Stuart <Pip@CPAN.Org> to compare test times.
  die "Please define: run0 as an enviroment var!" unless(exists($ENV{'run0'}));
  die "Please define: run1 as an enviroment var!" unless(exists($ENV{'run1'}));
  print   "Testing: $ENV{'run0'}...\n"; system("perl timeRun.pl $ENV{'run0'}");
  print "\nTesting: $ENV{'run1'}...\n"; system("perl timeRun.pl $ENV{'run1'}")}
sub syncdate{ # 24RNkce - syncdate created by Pip Stuart <Pip@CPAN.Org> to synchronize the system date/time with an authoritative web page.
  # 2du:print diff between times before && after setting, setup cron to sync daily?
  my $data; my $year; my $mont; my $dayo; my $hour; my $minu; my $seco; my %mons; my $moni = 1; $mons{$_} = sprintf("%02d",$moni++) for(@Monz);
  `wget -q   -O    /tmp/nowdate.html http://www.time.gov/timezone.cgi?Pacific/d/-8`; # read date site into local file
  open(DATE, '<', '/tmp/nowdate.html'); $data = join '', <DATE>; close(DATE); # Perl6::Slurp?
  if($data =~    /<b>(\d+):(\d+):(\d+)<br>/i) { $hour =       $1 ; $minu = $2; $seco = $3; } # parse file data for embedded date/time
  if($data =~ /day, (\w+) (\d+), (\d+)<br>/i) { $mont = $mons{$1}; $dayo = $2; $year = $3; } $dayo = "0$dayo" if(length($dayo) == 1); # 0-pad MM && DD
  print "$0 setting: date $mont$dayo$hour$minu$year.$seco\n"; # calling `date` with format: MMDDhhmmYYYY.ss
  system(           "date $mont$dayo$hour$minu$year.$seco"); }
sub vollabel{ # 465Fedf - vollabel to return GNU/Linux disc volume labels
  my $dvic = shift || '/dev/dvd'; $dvic =~ s[^(/dev)?/*][/dev/]; die "!*ER0R*! Invalid device name:$dvic!\n" if($dvic =~ /[^0-9A-Za-z._\/]/); # sanity ck
  my $voll = `dd if=$dvic bs=1 skip=32808 count=32 2>/dev/null`; print "$voll\n"; }
sub tiglet{ # figlet chooser
  my $fntd = `figlet -I2`;           #this is 4linux
 #my $fntd = "/pip/4dos/fig/fonts";  #this is 4dos
  my $text = "@ARGV"; chomp($fntd); $fntd .= "/*.flf"; my @fntz = glob("$fntd"); my $coun = 0; my $fcou = 0; my $lall = 0; my $poop; my $kaka;
  my $outf = "dfaltout.txt"; my $optn = ''; my $inpt = '';
 #my $favs = "19 20 24 32 36 37 64 67 69 70 75 76 77 78 80 84 85 90 93 100 102 "; # These are my 4(Dos|NT)&&belo GNULinux favs but I have lotz! ;)
 #my $favs = "14 15 19 22 24 25 32 36 37 64 65 67 70 76 78 81 84 85 87 88 90 94 100 102 "; # Your mileage and font numbers may vary.
  my $favs = ''; my @favz = split(/\s+/, $favs);
  if($text =~ m/^\s*-a/i){ $text =~ s/^\s*-a//i; $lall = 1; }
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
  if($text eq ''){ $text = "KakA NachoZ";
    print "Please enter text to display [$text]: ";                  chomp($poop = <STDIN>); $text = $poop if($poop ne '');
    print "Please enter a file to write selected text to [$outf]: "; chomp($poop = <STDIN>); $outf = $poop if($poop ne ''); }
  while($inpt !~ /q|x|y|d/i && (($lall && $coun < @fntz) || (!$lall && $fcou < @favz))){ @favz = split(/\s+/, $favs);
    if($lall){ $fntz[      $coun ] =~ s!.*/!!; $kaka = `figlet -f $fntz[$coun]        $optn -- $text`;
      print "${kaka}Font\#$coun:$fntz[$coun],Text:$text,Optn:$optn,Favs:$favs,cmd[npYteskocq]: "; }
    else     { $fntz[$favz[$fcou]] =~ s!.*/!!; $kaka = `figlet -f $fntz[$favz[$fcou]] $optn -- $text`;
      print "${kaka}Font\#$favz[$fcou]:$fntz[$favz[$fcou]],Text:$text,Optn:$optn,Favs:$favs,cmd[npYteskocq]: "; }
    chomp($inpt = <STDIN>); $inpt =~ tr/A-Z/a-z/;
    if($inpt =~ /f/){ if($favs =~ /$coun /){ if($lall){ $favs =~ s/$coun //; }else{ $favs =~ s/$favz[$fcou] //; } }
                      else                 { if($lall){ $favs .=  "$coun " ; }else{ $favs .=  "$favz[$fcou] " ; } } }
    if($inpt eq "" || $inpt =~ /n/){ $coun++; $fcou++; if(($lall && $coun == @fntz) || (!$lall && $fcou == @favz)){
                      print "Last Font Displayed!  Loop back to beginning? (y/n) "; $poop = <STDIN>; if($poop =~ /y/i){ $coun = $fcou = 0; } } }
    if($inpt =~  /p/  ){ $coun--; $fcou--; }
    if($inpt =~  /\d+/){ $coun =  $inpt; if($coun <     0){ $coun =      0; } if($coun > @fntz){ $coun = $#fntz; } }
    if($inpt =~ /y/ || $inpt =~ /d/){ print "Saving to $outf and Quitting!\n"; open(OUTF, '>', $outf); print OUTF $kaka; close(OUTF); }
    if($inpt =~ /t/){ print "New Text [$text]: "; chomp($poop = <STDIN>); if($poop ne ''){ $text = $poop; } }
    if($inpt =~ /e/){ print "Export File [$outf]: "; chomp($poop = <STDIN>); if($poop ne '') { $outf = $poop; } }
    if($inpt =~ /s/ || $inpt =~ /k/ || $inpt =~ /o/ || $inpt =~ /c/ || $inpt =~ /l/ || $inpt =~ /r/){
      if($optn =~ /-$inpt /i){ $optn =~ s/(-$inpt |$inpt)//gi; }else{ $optn .= "-$inpt "; } }
    if($inpt =~ /q/ || $inpt =~ /x/){ print "Quitting Without Saving!\n"; } }
} # lsptBl02du:stripXtraDblSpcK0lMzB4NCSKpk0lRk0dzhvbNad3d;mABpr0cS~/.lsrc wiXtra0ptz2betRgl0b&&PCREk0lRz4fyLtypzas$ENV{LsP8}?;
sub lspt{ #2du:f0ld$ENV{LsP8}n2`lspt`n2`ls`&&evN2LEUzCurzSFUCKnsteduvANSISKpk0dz;r3d0NCSKpk0dzazgl0bLFUCKnmz2mkbetREsc8NCRtSKR8;add $prmz optn2~/.lsrc;
  my @ldat=`ls -lF --full-time @_`;my $t0tl='0';my %lsp8;my %lspt;my($list,$prmz,$blsz,$pwnr,$grup,$fsiz,$dayt,$tyme,$tz0n,$fnam,$cmpr,$b6bs,$b6fs);
  for(split(':',$ENV{'LS_COLORS'})){my ($g2re,$fx2e);#drwxr-xr-x 48 pip users 4096 2009-10-24 22:28:17.180201607 -0700 dvl/
    if   (/^([^=]*[\*\+\?]+[^=]+)=0(.+)$/){($g2re,$fx2e)=($1,"$SKp8$2m");$g2re=~s/([.])/\\$1/g;$g2re=~s/(\?|(\*|\+))/.$2/g;$lsp8{qr/^.*\s*$g2re$/}=$fx2e}
    elsif(              /^([^=]+)=0(.+)$/){($g2re,$fx2e)=($1,"$SKp8$2m");                                                  $lspt{         $g2re  }=$fx2e}}
  for(@ldat){if(($prmz,$blsz,$pwnr,$grup,$fsiz,$dayt,$tyme,$tz0n,$fnam)= /^(\S{10})(\s+\d+)(\s+\S+)(\s+\S+\s+)(\d+)\s+(\S{10})\s+(\S+)\s+(\S+)\s+(.*)$/){
    $b6bs=b64($blsz);$b6bs=' 'x(length($blsz)-length($b6bs)).$b6bs;
    my $b6tt=$tz0n;my $b6tz;$b6tt=~s/^\s+//;$b6tt=~s/\d\d$//;
    if   ($b6tt=~s/^-0?//  ){$b6tz=$G.b64(27-$b6tt)}
    elsif($b6tt=~s/^\+00/0/){$b6tz=$G.b64(   $b6tt)}
    $b6fs=b64($fsiz);$b6fs=' 'x(length($fsiz)-length($b6fs)).$b6fs;
    #2du:should rename $link->arrow && $kolumn_x below to not collide with 8 color escape variables;
    my($lar0,$k0lx,$l,$k);$l=0;my $ttim;
    $cmpr=$prmz;my @fldz=split(/-/,$dayt);$fldz[1]=~s/^0//;$fldz[1]--;my $stat="$Mon[$fldz[1]] $fldz[2] $tyme $fldz[0]"; @fldz=split(/\./,$tyme);my $tnam;
    $cmpr=~s/^(d)/$B$1/;$fldz[2]= '0.'.$fldz[1];$fldz[2]*=60;$fldz[2]=int($fldz[2]);$stat=~s/\.$fldz[1]/:$fldz[2]/;my $ptim=Time::PT->new('verbose'=>$stat);
    $cmpr=~s/^(-)/$W$1/;$ttim= $ptim->color('ansi').$k;$ttim.='0'x(7-int((length($ttim)-7)/8)) if(length($ttim)<(8*7 +7));
    $cmpr=~s/rwx/${R}7/g;$cmpr=~s/-wx/${b}3/g;$cmpr=~s/rws/${Y}7/g;$cmpr=~s/rwt/${m}7/g;
    $cmpr=~s/rw-/${C}6/g;$cmpr=~s/-w-/${O}2/g; # stil wnt2Uz ~/.lsrc 2mABNcod prmz asumngPXX(400,644,755..[azB64?])2ovrIdfylk0lrzby.X10shn
    $cmpr=~s/r-x/${M}5/g;$cmpr=~s/--x/${g}1/g;$cmpr=~s/r-s/${O}5/g;$cmpr=~s/r-t/${m}5/g; #Uzr&&Grp?
    $cmpr=~s/r--/${B}4/g;$cmpr=~s/---/${G}0/g  ;$grup=~s/\s$//; #?prmzRblszYpwnrCgrupPfsiz?dayt?tymeGtz0n?fnam..
    for my $shgl (sort keys(%lsp8)){$tnam=$fnam;if($tnam=~/$shgl/){    $k= $lsp8{$shgl};$tnam= $k.$tnam;                                                  #Gl0b
         $tnam=~s/^(.*?)(\s+|\e\[[^m]+m|\s(->)\s)*(.+?)((\.)([^.]+))?$/$k$1$W$3$k$4$W$6$k$7/;#$k=~s/\e\[/\\e\\[/g;
         $tnam=~s/(([-._*>])+|\s+(->)\s+)/$W$2$3$k/g;$tnam=~s/([-])+/$Y$1$k/g;$tnam=~s/([_])+/$C$1$k/g;                                         last}}
    for my $svgl (keys(%lspt)){$k=$k0lx=$lspt{$svgl};my( $bgin,$fsnm )=('', $fnam);#elsif($svgl..=~/^(\e\[[^m]+m)?(.+->.+)$/)&& -l $fsnm)){s/../$k$fsnm} #Typz
     if   ($svgl eq'ex'&& (($bgin,$fsnm)= $fnam=~/^(.*?)(.+?)\*+$/   )&& -x $fsnm){if(!-d $fsnm){  $fsnm=~s/\*//g;
           $list.="\n:$svgl=e\$SKp8[$lspt{$svgl}:$fsnm:e\$W:*:..G:\n" if($Dbug);
           $tnam=~s/^(.*?)($fsnm)(\*)*$/$1$k$2$W/;}}
     elsif($svgl eq'di'&& (($bgin,$fsnm)= $fnam=~/^(.*?)(.+?)\/*$/   )&& -d $fsnm){$tnam=~s/^(.*?)($fsnm)(\/)*$/$1$k$2$Y$3/ }}#$tnam.=$G;
    my($cpwn,$cgrp)=($pwnr,$grup);#$cpwn=~s/\s//;$cgrp=~s/\s//;#$b6fs=~s/\s//;
    if($b6tz=~s/(.*)(-\d)/$g$2$1/){my $negz=$2;my $nb6z=b64(eval("27$negz"));$b6tz=~s/$negz/$nb6z/;}
    s/^$prmz$blsz$pwnr$grup\s(.*?)$fsiz\s$dayt\s+$tyme\s(.*?)$tz0n(.*?)$fnam(.*)$/$cmpr$R$b6bs$Y$cpwn$C$cgrp$M$b6fs $b6tz$ttim$2$3$G$tnam$4/;
    if(/^.*([0-9A-Za-z._][1-9A-C][1-9A-V][0-9A-Za-x]{4})\e\[[^m]*m(\.|$)*/){my $ptvr=$1;$ptim=undef;$ptim = Time::PT->new($ptvr);
      $ttim=$ptim->color('ansi').$G;$ttim.='0'x(7-int((length($ttim)-7)/8)) if(length($ttim)<(8*7 +7));s/$ptvr/$ttim/}}
  elsif(/^total\s+(\d+)/){$t0tl=b64($1);$_=''}$list.=$_ if /\S/}@ldat=split(/\n/,$list);$list="${O}t${Y}0${O}tl$W:$B$t0tl${G}K\n";
  $list.=join("\n",@ldat)."\n";print $list}
sub fpt{ # 37CKFQAE:fpt created by Pip@CPAN.Org to format PipTime data like:`fmt`from"[{pt_descriptor}] Month {Day} {Hour:Minute:Second:60th} Year"
  my  @data= shift||<STDIN>;my $parm='';my $ptst ='http://Ax9.Org/pt?'; # belo shud proly qr// on a join('|',@Mon)
  for(@data){chomp;if(/^\[[^\]]*\].*?((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\D+(\d+)\s*(\d*):?(\d*):?(\d*):?(\d*)\s*(\d*))/i){ $parm = $1;
    unless(/$ptst/){   $_ .= ' ' unless(/ $/);$_.= $ptst } # Y?:IUzd thiz4my old`mutt`EMlreply attribUtion but myt gr0 it sumday2BfanCer; =)
    $parm = Time::PT->new('verbose' => $parm);$_.="$parm"}print "$_\n"}} # eg, '[OrigSent] ( Sat Jul 12 17:18:25:24 2003 ) ' or '[done] Jul 2003';
sub genbats {my $bind = shift();my $batd;my $desc = "$0: Gener8 MSWindowsBatch-fyl(.bat)wraprz4PerlUtlz";$bind =      '/Pip/bin/' unless(-d $bind);
  print "!*WARN*! Generating MSWin32 batch files on different platform: $^O!\n" unless($^O eq 'MSWin32');$bind = '/home/pip/bin/' unless(-d $bind);
  die   "!*ER0R*! Could not find bin directory to generate batch files from!\n"                                                   unless(-d $bind);
  $bind =~ s/\/*$/\//;                     $batd = $bind;$batd =~ s/^(.*)bin\//$1bat\//;
  for(glob($bind . '*')){ my $binf = $_;my $batf = $binf;$batf =~ s/^(.*)bin\//$1bat\//;open(BINF,'<',$binf);my $line = <BINF>;
    if($line =~ /^\#!.*perl/i){ mkdir($batd,0755) unless(-d $batd); #print "Wrapping binf:$binf\n    with batf:$batf.bat\n";
      open(BATF,'>',"$batf.bat");print BATF "\@echo off\n\@perl $binf";for my $pndx (1..9){print BATF " \%$pndx";}print BATF "\n";close(BATF);}close(BINF);}}
sub critarch{my $arcf = $ENV{'HOME'};chdir($arcf);$arcf =~ s/\\/\//g;$arcf =~ s/\/*$/\/dvl\/utl\/CritArch.ls/; # cre8 new CriticalArchive of important fylz
             my $arzf = $arcf;$arzf =~ s/\.ls$/.tar/;unlink($arzf) if(-e $arzf);die "!*ER0R*! Could not read CritArch.ls file!\n" unless(-r $arcf);
  open(ARCF,'<',$arcf);while(<ARCF>){chomp();unless(/^\s*#/){ # skip cmnt(#) lynz then hndl globz
    if(s/\*$//){ #printf("dir:%-43s at:%d\n", $_, -s $arzf);
      if(-w $arzf){ if(-s $arzf < 200000000){            system("tar  rf $arzf   $_   "); } } # r == append to existing
      else        {                                      system("tar  cf $arzf   $_   "); } } # czvf is normal creation
    else       {
      if(-w $arzf){                                      system("tar  rf $arzf   $_   "); }   # r == append to existing
      else        {                                      system("tar  cf $arzf   $_   "); } } # czvf is normal creation
  } } close(ARCF);
  if(    -w $arzf){$arcf = $arzf;$arcf =~ s/\.tar$/.tgz/;system("gzip -c $arzf > $arcf");unlink($arzf); } # zip it up
  chdir('dvl/utl');              $arcf =~ s/^.*dvl\/utl\///;                 bak($arcf );unlink($arcf); }
sub xprp{print "!yet implemented xprop wrapr utl4Compiz\n";}
# 9A11f8g: xprp from HTTP://Forum.Compiz.Org/showthread.php?t=1768 wher phaedOne postd utl2help set Compiz WindowMatchingRules; #!/bin/sh
#case "$1" in
#  -type   )  xprop |  grep     WINDOW_TYPE                | cut -d  _  -f 10;;
#  -role   )  xprop |  grep "WM_WINDOW_ROLE(STRING)"       | cut -d \"  -f  2;;
#  -name   )  xprop |  grep  WM_CLASS                      | cut -d \"  -f  2;;
#  -class  )  xprop |  grep  WM_CLASS                      | cut -d \"  -f  4;;
#  -title  )  xprop |  grep "WM_NAME(STRING)"              | cut -d \"  -f  2;;
#  -xid    )  xprop |  grep "WM_CLIENT_LEADER(WINDOW)"     | cut -d ' ' -f  5;;
#  -all    )  xprop >  tmp
#    echo -n "type :"; grep     WINDOW_TYPE            tmp | cut -d  _  -f 10
#    echo -n "role :"; grep "WM_WINDOW_ROLE(STRING)"   tmp | cut -d \"  -f  2
#    echo -n "name :"; grep  WM_CLASS                  tmp | cut -d \"  -f  2
#    echo -n "class:"; grep  WM_CLASS                  tmp | cut -d \"  -f  4
#    echo -n "title:"; grep "WM_NAME(STRING)"          tmp | cut -d \"  -f  2
#    echo -n "xid  :"; grep "WM_CLIENT_LEADER(WINDOW)" tmp | cut -d ' ' -f  5
#             rm       tmp ;;
#  * ) echo "Usag:xprp -[type|role|name|class|title|xid|all]" >&2;    exit  1;;
#esac # && bcuz   xprop outpt fmt may hv chngd sinc 2007 && I'd prefer2maintain utl in Perl, l8st outpt foloz:
#[pip@Ryu9A114eg~]xprop
#WM_STATE(WM_STATE):
#                window state: Normal
#                icon window: 0x0
#_NET_WM_DESKTOP(CARDINAL) = 0
#_NET_WM_STATE(ATOM) = 
#_MOTIF_WM_HINTS(_MOTIF_WM_HINTS) = 0x3, 0x0, 0x0, 0x0, 0x0
#_NET_FRAME_EXTENTS(CARDINAL) = 0, 0, 0, 0
#WM_NORMAL_HINTS(WM_SIZE_HINTS):
#                program specified location: 0, 0
#                program specified size: 960 by 600
#                program specified minimum size: 4 by 4
#                program specified minimum aspect ratio: 960/600
#                program specified maximum aspect ratio: 960/600
#                program specified base size: 0 by 0
#                window gravity: Static
#WM_ICON_NAME(STRING) = "MPlayer"
#_NET_WM_ALLOWED_ACTIONS(ATOM) = _NET_WM_ACTION_STICK, _NET_WM_ACTION_CHANGE_DESKTOP, _NET_WM_ACTION_ABOVE, _NET_WM_ACTION_BELOW
#WM_NAME(STRING) = "MPlayer"
#_NET_WM_PID(CARDINAL) = 22059
#WM_CLASS(STRING) = "gl", "MPlayer"
#WM_PROTOCOLS(ATOM): protocols  WM_DELETE_WINDOW
sub rdhd{ # H5OMAVTX:rdhd orig from 1CKJEIX0:readhead crE8d by PipStuart <Pip@CPAN.Org> to flexibly read binary file header inform8ion;
#   It takes a byte-based unpack pattern, filename of binary d8a, && optional file offset.  2du:do common while loop once (as sepR8 sub?),add -help,mk top ls;
#   e.g., rdhd('V2x2v','/home/pip/gfx/fyt/Haoh/soulca21.bmp',18) returns 640 480 0 (.bmp width, height, bit-depth zero why? was 24 before)
# Should be for Windows BITMAPCOREHEADER from HTTPS://En.Wikipedia.Org/wiki/BMP_file_format#Bitmap_file_header ;
  my $ptrn=shift || die "!*EROR*! No unpack pattern given!\n";my $flnm=shift;my $ofst=shift || 0;my $temp=$ptrn;my $size=0;my $type='';my $incr=1;my @valz=();
                    die "!*EROR*! No file found by name:$flnm!\n" unless(-e $flnm);
  while($temp =~ /^([a-z])(\d*)/i){($type,$incr)=($1,$2);
    if(!defined($type) || $type !~ /^[a-z]$/i){$type = 'z';}
    if(!defined($incr) || $incr !~ /^\d+$/   ){$incr =  1 ;}
    if    (               $type =~ /^[snv]$/ ){$incr =  2 ;}
    elsif (               $type =~ /^[flNV]$/){$incr =  4 ;}
    elsif (               $type =~ /^[d]$/   ){$incr =  8 ;}
    $size += $incr;       $temp =~s/^[a-z]\d*//i;}
  open my $binf,'<',$flnm or die "!*EROR*! Can't open  binary file:$flnm to read from! $!\n";binmode $binf;
  read    $binf,$temp,$ofst;
  read    $binf,$temp,$size;
  close   $binf           or die "!*EROR*! Can't close binary file:$flnm! $!\n";#say "ptrn:$ptrn size:$size ofst:$ofst";
                                                                                #for(split //,$temp){print ord($_),', ';} say '';
  while($ptrn =~ /^([a-z])(\d*)/i){($type,$incr)=($1,$2);
    if(!defined($type) || $type !~ /^[a-z]$/i){$type = 'z';}
    if(!defined($incr) || $incr !~ /^\d+$/   ){$incr =  1 ;}
    if($type ne 'x'){ # not null
      push(@valz, unpack("$type$incr",$temp));}
    if    (               $type =~ /^[snv]$/ ){$incr =  2 ;}
    elsif (               $type =~ /^[flNV]$/){$incr =  4 ;}
    elsif (               $type =~ /^[d]$/   ){$incr =  8 ;}
    $temp = substr($temp, $incr,(length($temp)-$incr));
                          $ptrn =~s/^[a-z]\d*//i;} return(@valz);}
8;

=encoding utf8

=head1 NAME

Pip::Utl - Pip's Utilities

=head1 VERSION

This documentation refers to version pKGvERS of Pip::Utl, which was released on ptptIME.

=head1 SYNOPSIS

  use Pip::Utl;

  # left
  # rght
  # syncdate
  # etc.

=head1 DESCRIPTION

Utl is a package that contains most of my Perl utilities. Whatever common functions or objects I want to have access to anywhere, I intend to keep here.

=head1 2du

=over 2

=item - write POD

=item - write tests

=back

=head1 USAGE

4NT Variable Functions Ported to Perl:

=head2 tild($filename)

Expands a tilde character at the beginning of a filename into the likely
/home/ directory on a Unix filesystem.

=head2 left($char_count, $string)

Return the  left-most x characters of a string.  The first parameter is
the number of characters to select.  The second parameter is the string.

=head2 rght($char_count, $string)

Return the right-most x characters of a string.  The first parameter is
the number of characters to select.  The second parameter is the string.

=head2 coma($string, [$sep_char[, $group_count]])

Insert commas (or other separator characters) into a parameter string.
The first parameter is the string you want separated. The optional
second parameter is the character you'd like to insert instead of the
default comma. The third optional parameter is the number of
characters you'd like to keep grouped together instead of the default 3.

Note: This early coma is no longer here && a different b64 by-4 kind is in Octology::a8 now.

=head1 CHANGES

Revision history for Perl extension fULnAME:

=over 2

=item - pKGvERS  ptptIME

* added kwalitee to 2du of e()

* added lspt, fpt, && genbats

* added bin wrapper generation for e('pkg') of Pip::Utl

* added Build.PL generation to e('pkg')

* original version

=back

=head1 INSTALL

Please run (assuming this ever gets released to the CPAN):

  `perl -MCPAN -e "install Pip::Utl"`

or uncompress the package && run the standard:

  `perl Makefile.PL;       make;       make test;       make install`
         # or if you don't have  `make` but Module::Build is installed
  `perl    Build.PL; perl Build; perl Build test; perl Build install`

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2004-2016, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License
  (version 3 or later). Please consult L<HTTP://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTP://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
