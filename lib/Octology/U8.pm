# F4IMHtuH: Octology::U8.pm crE8d by PipStuart <Pip@CPAN.Org> to have effective Ultim8 Utiliz8ion of U "You" tUbe and Useful methodz and Octoformz of upd8ing;
#   U2b8() Blongz hEre in nw U8.pm 4"Utiliz8ion" module wi Utlz4UniT of U thEm wi U2b && upd8 (as smRt nw port of Utl:updt Using upd8z 4 Octology 4 future),
# 2du:add2 U2b8 Dtection4 -F bSt sepR8 aud&&vid avail && thN try2 dnld both && post-join wi `ffmpeg -i $1 -i $2 -acodec copy -vcodec copy out.mp4` B4 U2b4 nAm,
#   mABadd U2b8 optn2auto rebild all mvz 2HD,add2 upd8 th@ if HHst eq Aku && fromHome path is in dvl/t8/Octl/Octology/ to also copy there for next `git add..`,
#   bild U2bd autOm8dtStmOde4 U2b8 2CrEsult ofruning evry dnlOded fIle thru U2b4&&shO discrepanCz Btwn NE loc8abl fIl wi sAm IdNt fEld2knO wher cOd lackz,
#   port Utl:bak e ?,gNralIzXpct,U2b8:rEplAc `yt-dl` wi Xpct2shOprogrS,rEwrIt die8 here2Dflt b64 wi many more optnz(as "Urol" or "dieU" or othr betr name?),
#   Xtract the qregex keyz && reuse them in sn() for less redundancy && use ($xp->matchlist)[\d] 4better Unific8ion (altho staging simple B4 complex good2),
#   stRt generalizing all code for wrapping more commandz && maybe alias all the interfacez to ReadKey && Expect to maybe subclass them as new U8 cmd stuff;
package     Octology::U8;
use strict; use warnings;use utf8;use v5.10;
use         Octology::a8;
use         Octology::b8;
use         Octology::d8;
#se          Unicode::UCD 'charprop'; # needz v5.24 to install
use             Math::BigFloat;
use             Term::ReadKey ; # rEmMbr2 ReadMode 0 to rEstor TTY setingz aftr Ech Xpct obj finishz (since can't just do Only once@ END{})
use             Expect  ;
require         Exporter;
use    base  qw(Exporter); # mainly exporting global Utility functions
our @EXPORT= qw(upd8 U2b8 U2b2 U2b3 U2b4 UTF8); # autom8d code upd8 Utl, YouTube 8 4main dnldtool4moviez, 2 cnv2audio, 3 2audio mp3, 4 4name 4matting
our $VERSION='0.0';my $d8VS='IAIMFFMP';my $Dbug=0; #  UTF-8 (or ASCII) tables;
#ReadMode 3; # setup 4 raw mode or 3 cbreak mode where Ctrl-C workz since signalz are enabled
#$ENV{'TERM'}='linux'; # this is needed for arrow cursor keyz to get interpreted properly (vt100 does not do it)
my $cm='gst123';my $to= 2;my $so=0.4;my $tS=0;$tS=1 if(-t STDIN); # CoMand strng, TimeOutsecz, SelOutflsecz, ttySTDIN?
my %kr=('u'=>"\e[A" ,'d'=>"\e[B" ,'r'=>"\e[C",'l'=>"\e[D", # arOkEz working,Yay! `man 5 terminfo`UDRL=>cuu1,cud1,cuf1,cub1`v=$(tput cuu1)` `printf '%q\n' "$v"`
        'z'=>"\e[6~",'a'=>"\e[5~",'w'=>'+','s'=>'-','>'=>'n','h'=>'?','p'=>' ',chr(127)=>'m',"\n"=>'f','v'=>'1','x'=>'q'); # KeyzRemap  # BlO shift paramz4cmd
my $xp=Expect->new();my @pr;my $si='';my $cs ='';my $lt ='';#f(@ARGV){@pr=@ARGV;@ARGV=();} #eXPectobj,PaRamz,StndrdIn,CodecStrng 2ck4dupz,LastTime 2padCodecz
#push(@pr,';echo','8_eNNd_8');$cm.=' '.join(' ',@pr); # Expect seemz2B %20%3B like URL escaping my @pr with spacez && semiz so joining 4just sclr
my $ht ="==================== gst123 keyboard commands ======================= => ========================= g3 kybd cmdz ============================
  l/r or cursor left/right  -  seek 10 seconds  backwards/forwards    ;    p or     space       -  toggle pause
  d/u or cursor down/up     -  seek 1  minute   backwards/forwards    ;    m or backspace       -  toggle mute/unmute
  z/a or page   down/up     -  seek 10 minutes  backwards/forwards    ;    f or     enter       -  toggle fullscreen  (only for videos)
  w/s or +/-                -  increase/decrease     volume by 10%    ;    1 or v               -  normal video size  (only for videos)
  n   or >                  -  play next file                         ;
  h   or ?                  -  this help                              ;    q or x               -  quit (exit) g3
============================================================================================================================================"; # HelpText wi
$ht=~ s/(;)/$Y$1/g;$ht=~ s/ (-)/ $Y$1/g;$ht=~ s/ (10)/ $G$1/g;$ht=~ s/ (1) / $O$1 /g;$ht=~ s/(\%)/$P$1/;$ht=~ s/\+/$G+/;$ht=~ s/\/-/\/$R-/;    #   thorOcolrz
$ht=~s/(l)\/(r)/$Y$1\/$R$2/;$ht=~s/(d)\/(u)/$M$1\/$G$2/;$ht=~s/(z)\/(a)/$P$1\/$g$2/;$ht=~s/(w)\/(s)/$G$1\/$R$2/;$ht=~s/ (space) / $M$1 /;$ht=~s/(enter)/$C$1/g;
$ht=~ s/(==+            )/$r$1/gx;$ht=~ s/(up             )/$G$1/gx;$ht=~ s/(page           )/$P$1/gx;$ht=~ s/(toggle         )/$B$1/gx;$ht=~ s/ (n) / $M$1 /;
$ht=~ s/(=>             )/$Y$1/gx;$ht=~ s/(seek           )/$z$1/gx;$ht=~ s/(volume         )/$M$1/gx;$ht=~ s/(pause          )/$M$1/gx;$ht=~ s/ (m) / $R$1 /;
$ht=~ s/(g(st12)?3      )/$G$1/gx;$ht=~ s/(seconds?       )/$M$1/gx;$ht=~ s/(by             )/$r$1/gx;$ht=~ s/(unmute         )/$B$1/gx;$ht=~ s/ (f) / $C$1 /;
$ht=~ s/(ke?yb(oar)?d   )/$B$1/gx;$ht=~ s/(minutes?       )/$B$1/gx;$ht=~ s/(play           )/$O$1/gx;$ht=~ s/(  mute         )/$R$1/gx;$ht=~ s/ (q) / $W$1 /;
$ht=~ s/(co?m(man)?d[sz])/$C$1/gx;$ht=~ s/(wards          )/$c$1/gx;$ht=~ s/(next           )/$M$1/gx;$ht=~ s/(fullscreen     )/$C$1/gx;$ht=~ s/(\?)/$B$1/;
$ht=~ s/(cursor         )/$C$1/gx;$ht=~ s/(back           )/$O$1/gx;$ht=~ s/(file           )/$G$1/gx;$ht=~ s/(only           )/$r$1/gx;$ht=~ s/\//$W\//g;
$ht=~ s/(left           )/$Y$1/gx;$ht=~ s/(for            )/$G$1/gx;$ht=~ s/(this           )/$c$1/gx;$ht=~ s/(normal         )/$O$1/gx;$ht=~ s/([()])/$Y$1/g;
$ht=~ s/(right          )/$R$1/gx;$ht=~ s/(in)(crease) /$G$1$c$2/gx;$ht=~ s/(help           )/$B$1/gx;$ht=~ s/(videos?        )/$z$1/gx;$ht=~ s/(size)/$c$1/;
$ht=~ s/(down           )/$M$1/gx;$ht=~ s/(de)(crease) /$R$1$c$2/gx;$ht=~ s/(backspace      )/$R$1/gx;$ht=~ s/(quit           )/$W$1/gx;$ht=~s/ (or) / $w$1 /g;
$ht=~ s/ (>) / $M$1 /;$ht=~ s/ (h) / $B$1 /;$ht=~ s/ (v) / $O$1 /;$ht=~ s/ (p) / $M$1 /;              $ht=~ s/(exit           )/$W$1/gx;$ht=~ s/ (x) / $W$1 /;
$xp->debug(       0);$xp->raw_pty(     1); # raw_pty doez need 2B B4 spawn along wi proly mOst optnz
$xp->exp_internal(0);$xp->log_stdout(  0); # setup object BhAvior  # setng notrns(1) BlO wil!DlEt matchzfrom aQmUl8or,Dflt:0; 1 gOzwi (set|clear)_accum()
#xp->notransfer(  0);$xp->restart_timeout_upon_receive(1); # NAblng rEstRt_tImout_upon_rECv shudlet g3 plyr liveon aslong astImr upd8z continU2prnt
#xp->spawn($cm, @pr) or die "Cannot spawn $cm: $!\n";#xp->slave->stty(qw(sane));#raw -echo));#sane)); # mIt nEd2add custom Stty setngz4DsIrdBhAvior
sub sn{my $ns=shift||'';$ns=~ s/(\n|\n)+/\n/g;$ns=~ s/(AAC)/$P$1/gi;$ns=~ s/(MPEG)(-)?(4)?/$R$1$Y$2$G$3/gi; # StripNewlinez (&&retrnz&&othr spacez&&re4m@stuff)
          $ns=~ s/(\[)(MUTED)(\])/$Y$1$R$2$Y$3/gi;$ns=~ s/(\[)(PAUSED)(\])/$G$1$M$2$G$3/gi;$ns=~ s/(\()(audio)(\))/$O$1$C$2$O$3/gi;
  if    ( $ns=~  /(^|\s*)(Play)(ing )(file)(:)(\/\/)([^\n]+)(\n|$)/i){my $cf=c8fn($7);
          $ns=~ s/(^|\s*)(Play)(ing )(file)(:)(\/\/)([^\n]+)(\n|$)/$Y$2$B$3$G$4$W$5$P$6$cf\n/gi;}
  elsif ( $ns=~  /.*?(\s*)(Title)(\s*:)([^\n]+)(\n|$)/i){my $ts=$4;$ts=~ s/\s*(Artist  )(:)(.*?)(\s*)$/    $Y$1$W$2$z$3/gi; # split apart
          $ns=~ s/.*?(\s*)(Title)(\s*:)([^\n]+)(\n|$)/$G$2$W$3$R$ts\n/gi;}
  elsif ( $ns=~  /.*?(\s*)(Volume)(:\s*)(\d+)(\.)(\d+)(\%)(\n|$)/i){
          $ns=~ s/.*?(\s*)(Volume)(:\s*)(\d+)(\.)(\d+)(\%)(\n|$)/$M$2$W$3$G$4$Y$5$C$6$P$7/gi;}
  elsif ( $ns=~  /.*?(\n*)(Codec)(\s*:)([^\n]+)(\n|$)/i){my $tb=$4;$tb=~ s/\s*(Bit)(rate )(:)(.*?)( \w)(bit)(\/)(s).*/    $O$1$R$2$W$3$M$4$C$5$B$6$Y$7$M$8/gi;
    my $tc;#f($cs && $cs eq "$2$3$4$5"){$tc=$B."\nCodec$R"."Dup\n";}else{$cs="$2$3$4$5";$cs=~ s/\s*$/\n/;$cs=~ s/\s*Bitrate :.*/$tb/i;}
    if(defined($tc)){ # Codec   : MPEG-4 AAC (audio)  Bitrate : 195.6 kbit/s
          $ns=~ s/.*?(\n*)(Codec)(\s*:)([^\n]+)(\n|$).*/\n$tc/gi;} # try to skip out any surrounding Time: linez
    else {$ns=~ s/.*?(\n*)(Codec)(\s*:)([^\n]+)(\n|$).*/$B$2$W$3$tb$5/gi;}}
  elsif ( $ns=~  /==+\s+gst123\s+keyboard\s+commands\s+==+(\n)/i){ # detect help output
          $ns=~ s/==+\s+gst123\s+keyboard\s+commands\s+==+(\n)/\n$ht\n/i;}
  elsif ( $ns=~  /.*?(\n?)(Time)(:.*Time:\s*)(\d+:\d+:\d+\.\d+).*( of )(\d+:\d+:\d+\.\d+)\s*?(\n|$)/i){my $tn=$4;my $tt=$6; # break d8 fieldz
          $tn=~        s/(\d+)(:)(\d+)(:)(\d+)(\.)(\d+)/$C$1$W$2$B$3$W$4$M$5$Y$6$P$7/g;         my $Sc="\e[16G"; # mv2colm16,erase cursor2BoL&&mv2 1stcolumn
          $tt=~        s/(\d+)(:)(\d+)(:)(\d+)(\.)(\d+)/$C$1$W$2$B$3$W$4$M$5$Y$6$P$7/g;            $Sc.="\e[1K\e[1G";
          $ns=~ s/(^|\s*)(Time)(:.*Time:\s*)(\d+:\d+:\d+\.\d+).*( of )(\d+:\d+:\d+\.\d+)\s*?(\n|$)/$Sc$O$2$W: $tn$c$5$tt/gi;$lt="$Sc$O$2$W: $tn$c$5$tt";}
  return( $ns);} # StripNewlinez($NewlinezStripped) && alsO doez a bunch of rE4m@ing && colr8ion now2
sub mp{my $cx=shift;my $cb=$cx->before();my $ct=$cx->match();my $ca=$cx->after();$cb=~ s/^\s+//;$ct=~ s/^\s+//;
  if($ct=~ s/((^|\n*)Codec[^\n]*)\n+/$1\n/i){if($cs && $cs eq $1){$ct="$lt$W:$c"."af$W:".":$B"."b4$W:".":$M"."mt$W:$B"."Codec$R"."Dup\n";}else{$cs=$1;}}
  if(defined($cb)){if($cb=~ /(==+\s+gst123\s+keyboard\s+commands\s+==+|.*?(before|cursor|seek|toggle|volume|normal|next|quit)[^\n]*|==+)\n/i){$cb='';}
                   if($ct=~ /(==+\s+gst123\s+keyboard\s+commands\s+==+|Title\s+:[^\n]*                                                )\n/ix){$cb='';}
    if($ct=~  /^(Title)/i){$cb=~s/(^\s*?\n|\s+$)//g;}
    if($ct=~ s/^\s*(Ti(m|tl)e:?|Playing|Codec)/$1/i){$cb='' if($ct=~ /^Playing/i);}else{print "$G";}}else{ $ct=~ s/^\s*(Time:)/$1/i;}$ca=~ s/^\s*(Time:)/$1/i;
    $cb=sn($cb);$cb=~ s/(\n|\r)+//g;$cb='' if($ct=~  /Codec/i);
  print($B."b4$W:$G".   $cb ."$W:") if(defined($cb));$ct=~ s/^(\s*(Time:[^\n]+?)\n.*Time:[^\n]+?\n)/$2\n/gi;$ca=~ s/\s*(Codec)/\n$1/gi;$ct=~ s/^\s+//;
  print "\e[0K" if($cb!~  /(PAUS|MUT)ED/i);
  print($M."mt$W:$C".sn($ct)."$W:") if(defined($ct));                                                       $ca=~ s/(^\s|\n|\r)+//g; $ca='';
  print($c."af$W:$C".sn($ca)."$W:") if(defined($ca));} # MatchPrint
sub cb{my $cx=shift;$si='';
  if(-t STDIN){$si=ReadKey($so);if(defined($si) && $si eq "\e"){$si.=ReadKey(-1);if($si eq "\e["){$si.=ReadKey(-1);if($si=~  /\e\[[56]/){$si.=ReadKey(-1);}}}}
                                           $si='' unless(defined($si));mp($cx);my $zi=$si;$zi=~ s/\e/SKp/g; # should also send Ctrl-C break SIGINT thru
       if( length($si) && $si=~ /^([q m?f1n]|\e\[[ABCDFH56]~?)$/i){               #rint $G."Dflt$K"."Keyz$W:$Y$zi$W;\n" if($zi=~  /SKp/);
                                                 $cx->send(    $si );} # regUlRpassthru keyz
       elsif  (length($si) &&  exists($kr{$si})){my $zr=$kr{$si};$zr=~ s/\e/SKp/g;#rint $O."Remp$C"."Keyz$W:$Y$zi$W:$R$zr$W;\n";
                                                 $cx->send($kr{$si});} # try2rEmap arOw keyz  # any Othr unDtectd keyz shud prnt out 4l8r altern8 mapz
       elsif  (length($si) &&     ord($si) == 3){                                 #rint $M."Ord3$G"."Keyz$W:$Y$zi$W;\n";
                                                 $cx->send(    $si );} # try2pass Ctrl-C break thru
       elsif  (length($si)                     ){                                 #rint $B."Othr$K"."Keyz$W:$Y$zi$W;\n";
                                                                     }                                           exp_continue;}
sub xx{ $xp->expect($to, [qr/(^|\s*)Playing\s+file:\/\/\/[^\n]+\n/i                 => sub {my $cx=shift;mp($cx);exp_continue;}],
                         [qr/(^|\s*)Title\s*:[^\n]+\n/i                             => sub {my $cx=shift;mp($cx);exp_continue;}],
                         [qr/(^|\s*)Volume:[^\n]+\n/i                               => sub {my $cx=shift;mp($cx);exp_continue;}],
                         [qr/(^|\n*)Codec\s*:[^\n]+\n/i                             => sub {my $cx=shift;mp($cx);exp_continue;}],
                         [qr/==+\s+gst123\s+keyboard\s+commands\s+==+\n/i           => sub {my $cx=shift;mp($cx);exp_continue;}],
                         [qr/(^|\s*)Time:.*Time:\s*[:0-9.]+ of [:0-9.]+\s*/i        => \&cb]);}#xx(); # ref2 CallBack()  ,@cp @CbParamz (old)
#xp->soft_close(); # close hndl (soft w8z 15secz);  # 2du:below for upd8 enable detection of other non-perl shebang linez to omit -c test && report syntax OK;
#   upd8 isa rEwrItof Utl:updt 2rEUseoracceptwichfIl,tSt typ2Dtrmin dStin8ion,ckifalredEtherwi nO dif,ckif pasez`perl -c`,prnt,cp,if bin{chmod if nw;mABXeQt?}
sub upd8{my($upfl,$ubfl,$upxt)=('','',''); $upfl=shift(@_) if @_;$upfl=$ENV{'Hv8f'} if(exists($ENV{'Hv8f'}) && !-r "$upfl"); # 2du:loop @_ 4multipl fIlz2upd8
  if  (-r  "$upfl"){my($Hpth,$Hsub); $ubfl=$upfl;$Hsub='bin';$Hpth='';$ubfl=~ s/(^.*\/)//;$upxt=$1 if($ubfl=~s/\.([^.]+)$//); my $udif='1';my $udfl;
    if(     $upfl=~ /([^\/]+)\.pm$/){$ubfl=$1   ;$Hsub='lib';$Hpth=`grep -m 1 '^ *package ' $upfl`;chomp($Hpth);
                                                             $Hpth=~ s/(^\s*package\s+)//;$Hpth=~ s/::$ubfl.*//;} # this will fail if same pm name used twice
    if(length($Hpth) && $Hpth=~/[^:\/]/){$Hpth=~s/::/\//g;$Hpth="/$Hpth" unless($Hpth=~/^\//);my @psbz= split(/\//,$Hpth); # need to crE8 destin8ion subdirz?
      my $tpth="$ENV{'HOME'}/$Hsub";shift(@psbz);for my $oned (@psbz){$tpth .= "/$oned";if(!-d "$tpth"){mkdir("$tpth",0755);}}} # shud loop mkng Temp PaTH SuBZ
    open my $out8, '>&', STDOUT or die "Can't duplic8 STDOUT: $!";binmode $out8,':encoding(UTF-8)'; # crE8 local dup of global to lexically alter output enc
    $udfl=  "$ENV{'HOME'}/$Hsub$Hpth/$ubfl";$udfl.=".$upxt" if(length($upxt));my $updc='';
    if  (-d "$ENV{'HOME'}/$Hsub$Hpth"){#print "upfl:$upfl: \nudfl:$udfl:\n";
      if(-r  $udfl              ){$udif=`diff       $upfl   $udfl`;chomp($udif);} # try distilling output below
      if   ($upxt=~  /^p[ml]$/i || `grep '^#!\\(/\\(usr/\\)\\?bin/\\)\\?perl' $upfl`){ # check syntax on modules or scripts starting with hashbang perl
                                  $updc=`perl -c    $upfl    2>&1`;chomp($updc);$updc=~s/\n\s*($upfl)/ $1/;$updc=~s/((a|of|in|at) )//g;} # mIt want else !perl
      elsif(                       `grep '^#!\\(/\\(usr/\\)\\?bin/\\)\\?sh'   $upfl`){$updc='syntax OK'; # !sure how2ck syntax on basic shL scrptz yet
        if ($upxt=~/^\d?pal8$/i || `grep '^ *pal8 ' $upfl`){$udfl=~ s/bin/lib\/Octology\/f8\/pal8/; # mAB wil catch shL scrptz that call`pal8`wiout Bing fIlz?
          if(!-d "$ENV{'HOME'}/lib"                 ){mkdir("$ENV{'HOME'}/lib"                 ,0750);}
          if(!-d "$ENV{'HOME'}/lib/Octology"        ){mkdir("$ENV{'HOME'}/lib/Octology"        ,0775);}
          if(!-d "$ENV{'HOME'}/lib/Octology/f8"     ){mkdir("$ENV{'HOME'}/lib/Octology/f8"     ,0755);}
          if(!-d "$ENV{'HOME'}/lib/Octology/f8/pal8"){mkdir("$ENV{'HOME'}/lib/Octology/f8/pal8",0755);}}} # mk sure proper lib pal8 dir exists
      if(length($udif) &&  length($updc) && $updc=~ /syntax OK/){  `cp $upfl  $udfl`;print $out8 $G.'upd8 '.c8fn($upfl).' '.c8fn($udfl);}
      else                                                      {die "!*ErOr*! upd8 cud not 'cp $upfl $udfl',no perl -c sntx ck:$updc:udif:$udif:\n";}
      if(    $Hsub eq 'bin' || -x $upfl){      chmod(0755,"$udfl");}print $out8 `$udfl` if(-x $udfl &&0);} # mOst bin cOd nEdz pRamz2tSt sO autOcall proly!good
    close $out8 or die "Can't close out8 duplic8d STDOUT handle: $!";}} # better to call known t/*.t to valid8 expected behavior more thoroughly
  # maybe .Hrc can whitelist bin code filez && desired parameterz that should get auto-called at the end of upd8 to autom8 some basic testing also
my $U2ff=' -o "%(title)s-tItL-%(uploader)s-uldr-%(extractor)s-Xtrc-%(id)s-IdNt-%(epoch)s-epch-%(upload_date)s-uldt-%(autonumber)s-otnm.%(ext)s"'; # FullFieldz
my $U224=' -x --audio-format=best';my $U2rf='  --restrict-filenames';my $U2mf=' --merge-output-format=mp4 '; # Dfalt merged .mkv (MatrosKaVid?) 4m@ lackz audio
my $U234=' -x --audio-format=mp3 ';my $U2aq='  --audio-quality=0   ';my $U2fo=' --format=22 '; # should be hd720 mp4 as FormatOption (pass -F 2C altern8 optz)
sub U2b8{print $B."U2b8$O down$C"."load$G  URL2$M file$Y"."name$R  U2b4$K refo$W"."rmat\n"; # precede dl with slightly helpful text that needz colrz
  my($U2to,$U2fn,$U2an,$U2id)=('','','',''); # Tick? Optionz, resulting output FileName, Avconv output fileName, either video IDentity or URL containing ID
  my($U2co,$U2fc,$U2ac,$U2ic)=('','','',''); # Command Output, Colrd versionz
  if(@_){for(my $pndx=@_-1;$pndx>=0;$pndx--){#rint $B."U2b8$Y ckng$G"."pRam$W:$R$pndx$W:$C$_[$pndx]$W:\n";
                                             if   ($_[$pndx]=~ /^-+2$/){$U2fo='';$U2to=$U224.$U2aq;splice(@_,$pndx,1);}  # accept Xtra 2audio paramz
                                             elsif($_[$pndx]=~ /^-+3$/){$U2fo='';$U2to=$U234.$U2aq;splice(@_,$pndx,1);}  #   && get rid of them B4 bktix
                                             elsif($_[$pndx]=~ /^-+F$/){$U2fo='';                          }  #   && try2Dtect available  noFormatOptionz Flag
                                             elsif($_[$pndx]=~ /^-+fo/){$U2fo=$_[$pndx];splice(@_,$pndx,1);}} #   && try2Dtect overridden   FormatOption
  $U2to.=join(' ',@_) if(@_);if($U2to=~s/(https:\/\/www\.youtube\.com\/watch\?v=)([-0-9A-Z_]{11})($|\s|\S+)/ /i){ $U2id=$2;}} # srch4URL2X
  if  ((length($U2to)&& $U2to=~/([-0-9A-Z_]{11})/i) || (length($U2id)&& $U2id=~ /([-0-9A-Z_]{11})/i)){ # only baktick if some param lookz like ID
    if( length($U2id)){d8cs('U2b8');$U2ic=b8colr($U2id);d8cs();} # ch ColrSequ 4U2bId Colr, then restore default 8bow aftr
    print "$B  you$R"."tube$W-$O"."d$C"."l$G -o \"%(title)s-tItL-%(uploader)s-uldrXtrc-IdNtepch-uldtotnm.%(ext)s\"$R$U2rf$B$U2fo$Y$U2to$U2ic$W;\n";
    # probably STDERR putting out: 'WARNING: unable to extract uploader nickname' && UpLoadDaTes all coming back 'NA' l8ly too =(
    $U2co=`youtube-dl$U2ff $U2rf $U2fo $U2to $U2id`;if($U2co=~       /\n\[download\] Destination: (.+)/){$U2fn=$U2an=$1;} # save&&pRs FlNm from&&prnt CmdOutput
                                                    if($U2co=~/\n\[(avconv|ffmpeg)\] Destination: (.+)/){      $U2an=$2;} # save&&pRs Avconv|ffmpeg Nm sepR8ly
                                                       $U2co=~ s/(Downloading) (webpage)/$1            $2/; # mAB .webm Bcoming .opus 4 U2b2 can B Dtected?
    $U2fc=c8fn($U2fn) if(length($U2fn));               $U2co=~ s/(      Dest)(inat)(ion)(:)\s*($U2fn) /$G$1$B$2$R$3$W$4 $U2fc/ix if(length($U2fn));
    $U2ac=c8fn($U2an) if(length($U2an));               $U2co=~ s/(      Dest)(inat)(ion)(:)\s*($U2an) /$G$1$B$2$R$3$W$4 $U2ac/ix if(length($U2an));
    $U2co=~s/(Cor)(rect)(ing )(cont)(ainer )(in).*/$R$1$Y$2$B$3$M$4$O$5$c$6$G U2fn/gi;
    $U2co=~s/(Post)(-)(process )(file).*/$C$1$R$2$Y$3$M$4$G       U2fn$R exists$W,$Y skipping$W/gi;
    $U2co=~s/(\[)(down)(load)     (\]) /$B$1$O$2$C$3$B$4/gix;
    $U2co=~s/(\[)( you)(tube)     (\]) /$Y$1$B $2$R$3$Y$4/gix;
    $U2co=~s/(\[)(  ff)(mpeg)     (\]) /$G$1$Y  $2$M$3$G$4/gix;$U2co=~s/$U2id(:)/$U2ic$W$1/g if(length($U2id));
    $U2co=~s/(\[)(  av)(conv)     (\]) /$O$1$Y  $2$M$3$O$4/gix;$U2co=~s/$U2id   /$U2ic/gx    if(length($U2id));
    $U2co=~s/(Dele)(ting) (orig)(inal) (file).*/$R$1$B$2 $O$3$P$4 $M$5$G U2fn $W\(${M}pass$Y -k$c to$B keep$W\)/i; # Deleting orig* U2fn (pass -k to keep)
    $U2co=~s/(     web)(page)          /$O$1$G$2/gix;          $U2co=~s/(video )/$K$1/gix;$U2co=~s/( MPD )/ $R$1     /;
    $U2co=~s/(    mani)(fest)          /$z$1$M$2/gix;          $U2co=~s/(DASH  )/$R$1/gix;$U2co=~s/( info )/$B$1/i;
    $U2co=~s/(    info)(rmat)(ion)     /$B$1$Y$2$R$3/gix;      $U2co=~s/(\d+)(\D+) (of) (\d+)(\.)(\d+)([A-Z]i)?(B)/$R$1$P$2 $c$3 $G$4$W$5$O$6$M$7$B$8/;
    $U2co=~s/(     Ext)(ract)(ing)     /$M$1 $G$2$B$3/gix; # note /\d+\% of \d.*/ upd8ing progress in output with SKp cursor cOdez so Xamin 4m@
    $U2co=~s/(    Down)(load)(ing)     /$O$1$C$2$B$3/gix;      $U2co=~s/ (in) (\d+)(:)(\d+)/    $w$1 $B$2$W$3$M$4/;
    chomp($U2co);$U2co.="$W...$G"."call$Y"."ing$R U2b4\n" if(-e "$U2an"); # 2du:add f0ntz2outputz&&convert2 Xpect nstd of baktix so dnload progress can B seen
    print $U2co;if(-e "$U2an"){U2b4($U2an);}else{print $B."U2b8$R !*warn*!$G  did$R not$Y call$R U2b4$M since$B U2an$W:$C $U2an$R not$O found$R!\n";}}
  else                                          {print $B."U2b8$R !*warn*!$G  did$R not$Y call$c a$M shell$g with$r no$G ID"   .    "$O found$R!\n";}}
sub U2b2{U2b8('-2',@_);} #as U2ba='U2bm -x --audio-format=best --audio-quality=0'; # https://www.youtube.com/watch?v=  00vVP_TrU2M
sub U2b3{U2b8('-3',@_);} #as U2b3='U2bm -x --audio-format=mp3  --audio-quality=0'; #   00vVP_TrU2M  &index=173&list=PLA11538113C16891A
sub U2b4{my   $ogfn=shift(@_);my($psfn,$ocfn,$pcfn); # U2b4m@r (youtube-dl formatter ,wuz Utl:Uren 4rEnAm)  # OriG&&PipStyle FileNamez (&& c8 Colrd versionz)
  # shud loop through all passed in filenamez
  my $nwd8= Octology::d8->new()       ;my $logd="$ENV{'HOME'}/.log"; # N[eo]W D8 stamp4 log of Ech rename per4md (2reconstruct origz from IdNt if ever needed)
  mkdir($logd,0750) unless(-d "$logd");my $logf= $logd .'/U2b4.log'; # attempt to crE8 non-XistNt log-directory in User's ~
  my $twid=82; # tItL   WIDth (max so far maybe 90?), these widthz chosen to fit typical `lsd8` resultz within 160char linez
  my $awid=26; # Artist WIDth  # good for  'Cookie_Monsta_and_FuntCase'                 #_Lm:mgdctbTe=>MKPwKRCY=> DmS gLH Dbs cLS  tRP DNb Trn eLH;
  my $uwid=19; # uldr   WIDth (max 'Henrich*' but 'Metropolitandubstep' shudBgoodEnuf)  # /^[DGCTE][rlh]/ 4 mAin Xpanded genre nAmz
#U2b  -o "%(title)s-tItL-%(uploader)s-uldr-%(extractor)s-Xtrc-%(id)s-IdNt-%(epoch)s-epch-%(upload_date)s-uldt-%(autonumber)s-otnm.%(ext)s" --restrict-filenames
  if  (defined($ogfn) && length($ogfn)){my($tItL,$uldr,$Xtrc,$IdNt,$epch,$uldt,$otnm,$XtNs)= # match sub-fieldz
    $ogfn=~  /^(.*?)-tItL-(.*?)-uldr-(.*?)-Xtrc-([-0-9A-Za-z_]{11})-IdNt-(\d*)-epch-(\d{8}|NA)-uldt-(\d*)-otnm\.(.*)$/;
    if(defined($tItL) && length($tItL)){if($uldr=~ s/(Vital)_(EDM)/$1__$2/i){$tItL=~ s/(Electro_)House/$1/;$tItL=~ s/(Chillstep)_+(.*)/$2_$1/;}
      # proly want2minimally modify orig tItL mAnly just4Uni4m padng && Nd genre alInmNt
      $tItL=~ s/(Monstercat_)(EP|FREE|VIP)_(Release)/$2_$1$3_/i;$tItL=~ s/(Melodic|Glitch|Orchestral)_(Dubstep|House)/$2/; # try rEordr1st && strip Vital*Dubs
      $tItL=~ s/(Monstercat_                Release)/$1_/ix;$tItL=~ s/^(Glitch_Hop)_110BPM/$1/i; # rEordr&&prEpare4pOst-genrez  && rm redundant 110BPM
      $tItL=~ s/^(Dr?u[bm]step|DnB|Tra(p|nce)|Glitch_Hop|Electro)_-_(.*)$/$3___$1/i; # prE-rElOc8 Bgin $genre to Nd 4most Monstercat vidnAmz
      $tItL=~ s/^(Dr?u[bm]step|DnB|Tra(p|nce)|Glitch_Hop|Electro)_  (.*)$/$3_$1/ix if($uldr=~ /Vital/i); # try similar shift of genre to end for Vital
      $tItL=~ s/^((Progr)essive(_House)?)_-_(.*)$/$4___$2svH/i;$tItL=~ s/_DnB$/_DrumBass/i; # special genre && Xpansion2 all8 nAmB4padng since !handled BlO
      $tItL=~ s/^(House)_-_(.*)$/$2___Std$1/i;$tItL=~ s/_F(ea)?t\._*/_ft./i; # label Standard House &&  shrink Featurings
      if(length($tItL) < $twid){if($tItL=~  /^(.*?)_*-/){my$tpad= ''; # mAB mv any /f(ea)t\.[-_]?([^-_]+)/ft.$1/ 2TrackNd
                                                           $tpad= '_' x ($awid-length($1)) if(($awid-length($1)) > 0);
                                   $tItL=~ s/^(.*?)_*-_?/$1$tpad-/;}  # try to 1st pad likely Artist name lazy up to 1st dash, then pad whole tItL
        $tItL.='_' x ($twid-length($tItL));} # 4 consistNC mAB reordr Track-Artist for 'First_of_*-_Skrillex*'?
      $tItL=~ s/^(.*)([-_])Dubstep_(_+)$/$1$2Drubstep$3/i ;$tItL=~ s/^(.*)(Dubstyle )(_+)$/$1Drubstyl$3/ix;$tItL=~ s/^(.*)(Hardstyl)e(_+)$/$1_$2$3/ix;
      $tItL=~ s/^(.*)(Drum_Bass   )(_+)$/$1DrumBass_$3/ix ;$tItL=~ s/^(.*)(Chillstep)(_+)$/$1Chilstep_$3/i;
      $tItL=~ s/^(.*)(Glitch_Hop  )(_+)$/$1GlitcHop__$3/ix;$tItL=~ s/^(.*)(Electro_ )(_+)$/$1ElectroH$3/ix;
                                                           $tItL=~ s/^(.*)(Electro_House)(_+)$/$1ElectroH_____$3/i; # also all8 4 Vital *House
      $tItL=~ s/^(.*)(Trap____    )(_+)$/$1TrapBass$3/ix  ;$tItL=~ s/^(.*)(Trance__ )(_+)$/$1Trannnce$3/ix; # mAB LYRICS shud alIn wi Remix,not genre?
      $tItL=~ s/^(.*)(Dubstep_Remix_)(_+)$/$1$3Remix_Drubstep/i; # reordr $genre_Remix like from 'Meg_Dia_-_Monster_DotEXE_Dubstep_Remix*'
      $tItL=~ s/^(.*)(Remix_HQ______)(_+)$/$1$3$2/i;             # alIn HQ with genrez like from 'Nacked_-_First_Date*'  # BlOflag genre @Nd
      $tItL=~ s/^(.*)((Chil|Dru[bm]|Tra[pn]|Hard)(nnce|st(ep|yl)|Bass)|GlitcHop|(Electro|Progrsv)H|StdHouse|LYRICS__)(_+)$/$1$7$2/i;
                                                                                my $gflg='';$gflg=$2 if(defined($2)); # probably shud B $2 && $2, not 2 && 7
      $tItL=~ s/^(.*?)([-_][^-_]+[-_](Re-?)?[mf]ix_)(_+)($gflg)?$/$1$4$2$gflg/i;my $rflg='';$rflg=$2 if(defined($2));
      # abov try to stick Artist over with Remix  # BlO shft Remix B4 no genre  # not sure why abov *mix also appended duplic8 uldr (maybe within gflg?)
      $tItL=~ s/^(.*)(_{8})(.*$rflg)/$1$3$2/i if($rflg && !$gflg); # alIn any /([^_]*step_Mega_|Vocal_)?(Re-?)?[fm]ix/i B4posibl tail 8wId genre
      $tItL=~ s/((EP_|FREE_|VIP_)?Monstercat_Release_)(_*)/$3$1/i; # slide to Nd of underscore padding to hopefully just B4 genre
     #$tItL=~ s/UKF_Dubstep/Drubstep/; # for some reason, uldr UKF is getting appended to Remix titles without genre with wrong padding length,shud B fixd now?
      # uldr just paded,skip Xtrc unless!U2b,dash IdNt,b64 epch,cnv uldt 2 uld8 [0-9A-Za-z._]{3},skip uniform 00001 otnm, && last append .XtNs
      if(length($uldr) < $uwid){$uldr.='_' x ($uwid-length($uldr));} $epch=b64($epch); # b64 epch probably will not need any further padng to remain aligned
      if($uldt=~  /^20(\d\d)(\d\d)(\d\d)$/){$uldt=b64($1).b64($2).b64($3);}elsif($uldt eq 'NA'){$uldt.='_';} # pad NA to 3 charz like most known d8 YMD
      if($tItL!~  /((Dru[bm]|Tra[pn]|Hard)(nnce|st(ep|yl)|Bass)|GlitcHop|(Electro|Progrsv)H|StdHouse|LYRICS__)$/){
        if   ($uldr=~ /UKF   /ix){$tItL=~ s/_{1,8}$/Drubstep/;} # could add other default genres expected for common uploaders here
        elsif($uldr=~ /Trap  /ix){$tItL=~ s/_{1,8}$/TrapBass/;} # might also need to alter these to slurp 8 underscores from before whatever remix stuff nstd
        elsif($uldr=~ /Pulse8/i ){$tItL=~ s/_{1,8}$/Chilstep/;}}
      $psfn="$tItL-$uldr";$psfn.="-Xtrc$Xtrc" if($Xtrc ne 'youtube');$psfn.="-$IdNt-$epch-$uldt.$XtNs"; # ck4 webm as ogg or opus container to shed BlO
      if($XtNs eq 'webm'){my $tofn=$ogfn;$tofn=~ s/$XtNs$/ogg/;if  (-e $tofn){$ogfn=$tofn;$psfn=~ s/$XtNs$/ogg/ ;}else{$tofn=~ s/ogg$/opus/;
                                                                 if(-e $tofn){$ogfn=$tofn;$psfn=~ s/$XtNs$/opus/;}}}   $ocfn=c8fn($ogfn);$pcfn=c8fn($psfn);
      if($ogfn ne   $psfn){if(-d "$logd" && $logf=~ /^$logd.+\.log$/){ # xtra tst of logd&&logf here sinc mkdir&&assignment already shud have set fine above
          if (!-e  "$logf"){ # try to make new log file with 644 permissionz, or just append to existing
            open(my $lgfh,'>' ,$logf)                                                  || die "Could not crE8      log file: $logf! $!";
            print   $lgfh "# $nwd8:~/.log/U2b4.log originally gener8d from `U2b4`  VERSION:$VERSION  d8VS:$d8VS; Each time U2b4 is called to re4mat a particular filename parameter
#   (presumably of the recently downloaded result of calling U2b8 or U2b2), it appends to this log-file the current d8-stamp, a colon ':', a space, && the
#   original filename, followed by a sepR8 line containing an 8-space aligned colon, another space, then the destin8ion filename the original was moved to;\n";
            print   $lgfh  $nwd8 .  ": $ogfn\n" . ' ' x 8 .   ": $psfn\n";close($lgfh) || die "Could not close     log file! $!";chmod(0644,"$logf");}
          else{ # also if U2b8 filenamez l8r become unrestricted, all of these filehandlez && printz will need to set binmode UTF-8
            open(my $lgfh,'>>',$logf)                                                  || die "Could not append to log file: $logf! $!";
            print   $lgfh  $nwd8 .  ": $ogfn\n" . ' ' x 8 .   ": $psfn\n";close($lgfh) || die "Could not close     log file! $!";                    }}
        print       d8colr($nwd8)."$W: $ocfn\n" . ' ' x 8 . "$W: $pcfn\n"; # if U2b8 filenamez l8r become unrestricted, might have to quote or SKp namez B4 mv
        system( "mv                    $ogfn                     $psfn") if(-r "$ogfn");} # resultz sEm good so attempt 2 mv
      else{print    d8colr($nwd8)."$W: $ocfn\n  $R..above original filename did not match expected U2b8 output format, so no rename (mv) performed;\n";}}}}
#ub U2bd{} # eventually tSt all log4differencez between U2b4 name output && manual movez matching U2b ID to learn what else might be useful to autom8 above
sub UTF8{my $optz=join(' ',@_);my $strt=0;my $uprb= 256; # 2BNJCDfo:asci utility to colorfully print most ASCII characterz (G7KMJqLF: ... now2 UTF8 < 256)
  open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!"; # crE8 local duplic8 of global
  my $widf=           0 ;$widf=         1   if(exists($ENV{'COLUMNS'}) && $ENV{'COLUMNS'} >= 153);my $outp; # fitz nicely in either 80 or 160 column termz
  my $trmt=      'xterm';$trmt=$ENV{'TERM'} if(exists($ENV{'TERM'   }));my $tsxf=0;$tsxf=1 if($trmt =~ /^(screen|xterm)/);
  my $lang='en_US.UTF-8';$lang=$ENV{'LANG'} if(exists($ENV{'LANG'   }));
  if($tsxf && $lang =~ /UTF-?8/i){binmode $out8,':encoding(UTF-8)';} # need to encode output if acceptable terminal && language environment settingz
  if  ($optz =~  /(^|\s)(-*h(elp)?)(\s|$)/){ # -h parameter design8z to just print help text as output && exit
    $outp = " UTF8  - print out 256 colorful UTF-8 or ASCII characters in order  Vers:$VERSION  d8VS:$d8VS  by Auth:$auth
   -p    skips over first 32 to start from the predominantly Printable characters  (since most of the 1st 32 are control chars)
   -c    disable printing of escape sequences which are used to Color the default output in 8bow and index columns
   -k    set start and end around Kana      (Nipponese Hiragana and Katakana need some special handling to restore alignment.) 12352-12543=192
   -r    set start and end around Radicals  (CJK Supplement     and Kangxi)                                                    11904-12255=352
   -h    display this Help text and exit                            (See HTTP://Unicode.Org/charts for more character blocks.)
  Note : If you pass a single parameter  of just digits, it will be treated as the new upper-bounds for UTF-8 instead of 256.
    If you pass in two separ8 parameters of just digits, they will be treated as the decimal values to use for start and end.
  2du  : Add some more letter options as shortcuts to set the start and end around majorly useful named blocks of characters.
         Keep progressively reformatting delimiters and indices to maintain rel8ively useful alignment for very high numbers.
         Study Unicode grapheme alloc8ion to most popular && interesting languages to learn how to best improve this utility.
         Maybe add typical Usage and Examples sections to this help inform8ion once there are more diverse options to convey.
         Figure out a decent set of 4096 characters that mostly align well with fixed widths for a new b8:b4k and b410 bases.
     Kana && Radicals are not so good for this since almost all charz appear double-width. Pretty though. b4k might not resemble the M8rix much.
     Should probably also replace slightly wide Chess && Cards since even slight overlapping makes distinguishment difficult.
     Also evalU8 actual stored byte-widths since saving more than 2 bytes per many or most employed chars somewhat defeats compression purpose.";
  }else{                                my $clrf= 1;
    if($optz =~ s/(^|\s)(-*c)(\s|$)/$1$3/){$clrf= 0;} # -c parameter design8z Colorless output (disabling the CoLoRFlag)
    if($optz =~ s/(^|\s)(-*p)(\s|$)/$1$3/){$strt=32;} # -p parameter design8z skipping to mainly Printable characterz
    if($optz =~ s/(^|\s)(-*k)(\s|$)/$1$3/){$strt=dec('3040');$uprb=dec('30FF');  # -k parameter design8z Kana (1st Hiragana then Katakana)
      if($optz=~s/(^|\s)(-*r)(\s|$)/$1$3/){$strt=dec('2E80');}                 } #   specially allow k && r rangez to be combined
    if($optz =~ s/(^|\s)(-*r)(\s|$)/$1$3/){$strt=dec('2E80');$uprb=dec('2FDF');} # -r parameter design8z Radicals (CJK Supplement && Kangxi)
    if($optz =~ s/(^|\s)(\d+)(\s|$)/$1$3/){$uprb=$2;} # allow single digit parameter to specify UPpeRBound && second digit param to design8 STaRT
    if($optz =~ s/(^|\s)(\d+)(\s|$)/$1$3/){$strt=$2;} ($uprb,$strt)=($strt,$uprb) if($strt > $uprb); # keep start && upperbound in increasng order
    $outp .= ' ' x (19*4) if($strt==  32 && $widf); # space align if skipping 1st unprintablez block
    for(my $indx = $strt;$indx < $uprb;$indx++){my $ib6c=b8colr(b64($indx)); # added colrz using a8::b8colr && b8::b64
      $ib6c= " $ib6c" if($indx <   64);         my $hexi=       HEX($indx) ; # pad top-row b64 indicez with a space to the left if they're just one char
      if($widf){$outp .= "$W:\n" if($indx &&  !($indx % 64) && defined($outp)                );} # hopefully adding defined tst here will stop empty : line
      else     {$outp .= "$W:\n" if($indx &&  !($indx % 32) && ($indx >   32 || $optz !~ /p/));}
      unless   ($indx % 8){
        if   ($indx <=  255){$outp .= sprintf("$W:$G%3d$W:$B%02s$W:%s$W:",$indx,$hexi,$ib6c);}
        elsif($indx <=  999){$outp .= sprintf("$W:$G%3d$B%03s$W:%s$W:"   ,$indx,$hexi,$ib6c);}
        elsif($indx <= 4095){$outp .= sprintf(   "$G%4d$B%03s$W:%s$W:"   ,$indx,$hexi,$ib6c);}
        else                {$outp .= sprintf(   "$G%4d$B%04s%s"         ,$indx,$hexi,$ib6c);}}
      if($tsxf){ # check Terminal Screen or Xterm Flag for which charz print acceptably
        if     ($indx ==   0 || $indx ==   5 || $indx ==   7 || $indx ==   8 || # maybe simpler to maintain just 7 <= $indx <= 15 (even tho 9 printz blank ok)
               ($indx >=  10 &&                 $indx <=  15)){ $outp .=  $Y  . b64($indx);} # regular xterm duz!prnt any <32 or 127<$indx<160 (but how2Dtect)
        elsif  ($indx ==   9 || $indx == 127 || $indx == 132 || $indx == 133 || $indx == 136 || $indx == 141 || $indx == 150 ||
                $indx == 151 || $indx == 154 || $indx == 156 ){ $outp .= "$o!"            ;} # try2stop erasing && cursor moving characterz
        else   {$outp .= S(substr($cmap{'8bow'},$indx % 8, 1 )) . chr($indx);}}
      else     { # 8trm can directly handle all characterz (Xcept chr(10) x0A \n) because it has no standard Ctrl-code interpret8ion yet
        if     ($indx ==  10                                 ){ $outp .= "$R!"            ;}
        else   {$outp .= S(substr($cmap{'8bow'},$indx % 8, 1 )) . chr($indx);}}
      if      (($indx >=   768 && $indx <   880) ||
               ($indx >=  1155 && $indx <  1162) ||
               ($indx >=  1425 && $indx <  1477)){ # also here add more spaces && some newlines for -radicals && -kana to also align
        $outp .= ' ';}} # try to space out what are presumably something like combin8ion code-points without whole grapheme clusterz
    $outp .= "$W:";$outp = sS($outp) unless($clrf);
  } say $out8 $outp;close $out8 or die "Can't close duplic8 STDOUT handle: $!";}
# : 64:40:10:@ABCDEFG: 72:48:18:HIJKLMNO: 80:50:1G:PQRSTUVW: 88:58:1O:XYZ[\]^_: 96:60:1W:`abcdefg:104:68:1e:hijklmno:112:70:1m:pqrstuvw:120:78:1u:xyz{|}~!:
  # !*NOTE*! Windows trEtzASCII26(CtrlZ)asEOF! Ctrl lynz BlO just vim tXtvershere2avoid th@prob
  # 000: 0:^@^A^B^C^D^E^F^G   008: 8:^H^I ^K^L^M^N^O   016:10:^P^Q^R^S^T^U^V^W   024:18:^X^Y^Z^[^\^]^^^_   #144:~P~Q~R~S~T~U~V~W ~X~Y~Z~[~\~]~^~_
  # 032:20: !"#$%&'   040:28:()*+,-./   048:30:01234567   056:38:89:;<=>?                                  #  !"#$%&' ()*+,-./ 01234567 89:;<=>?
  # 064:40:@ABCDEFG   072:48:HIJKLMNO   080:50:PQRSTUVW   088:58:XYZ[\]^_                                  # @ABCDEFG HIJKLMNO PQRSTUVW XYZ[\]^_
  # 096:60:`abcdefg   104:68:hijklmno   112:70:pqrstuvw   120:78:xyz{|}~^?                                 # `abcdefg hijklmno pqrstuvw xyz{|}~^?
  # 128:80:~@~A~B~C~D~E~F~G   136:88:~H~I~J~K~L~M~N~O   144:90:~P~Q~R~S~T~U~V~W   152:98:~X~Y~Z~[~\~]~^~_  # ~@~A~B~C~D~E~F~G ~H~I~J~K~L~M~N~O (cont.abov@lyn0)
  # 160:A0:| ¡¢£¤¥¦§   168:A8:¨©ª«¬­®¯   176:B0:°±²³´µ¶·   184:B8:¸¹º»¼½¾¿                                 # | ¡¢£¤¥¦§ ¨©ª«¬­®¯ °±²³´µ¶· ¸¹º»¼½¾¿
  # 192:C0:ÀÁÂÃÄÅÆÇ   200:C8:ÈÉÊËÌÍÎÏ   208:D0:ÐÑÒÓÔÕÖ×   216:D8:ØÙÚÛÜÝÞß                                  # ÀÁÂÃÄÅÆÇ ÈÉÊËÌÍÎÏ ÐÑÒÓÔÕÖ× ØÙÚÛÜÝÞß
  # 224:E0:àáâãäåæç   232:E8:èéêëìíîï   240:F0:ðñòóôõö÷   248:F8:øùúûüýþÿ                                  # àáâãäåæç èéêëìíîï ðñòóôõö÷ øùúûüýþÿ 
#   128:80:<80><81><82><83><84><85><86><87>   136:88:<88><89><8a><8b><8c><8d><8e><8f>   144:90:<90><91><92><93><94><95><96><97>   152:98:<98><99><9a><9b..f>
#   128:80:   136:88:   144:90:   152:98:...
8;

=encoding utf8

=head1 NAME

Octology::U8 - Octology Utiliz8ion and Upd8 functionality

=head1 VERSION

This documentation refers to version 0.0 of Octology::U8 released on.

=head1 SYNOPSIS

  use Octology::U8;

  # show some example usage

=head1 DESCRIPTION

This module is mainly YouTube and update for now.

=head1 USAGE

=head2 upd8()

Rewrite of Pip::Utl::updt().

=head1 CHANGES

Revision history for Perl extension Octology::U8:

=over 2

=item - 0.0 

* started writing POD

* original version (derived from old Pip::Utl code)

=back

=head1 TODO

=over 2

=item - write tests

=back

=head1 INSTALL

From the command shell, please run:

  `perl -MCPAN -e "install Octology"`

or uncompress the package and run the standard:

  `perl Makefile.PL; make; make test; make install`

=head1 LICENSE

Most source code should be Free! Code I have lawful authority over is and shall be!
Copyright: (c) 2014-2016, Pip Stuart.
Copyleft :  This software is licensed under the GNU General Public License
  (version 3 or later). Please consult L<HTTP://GNU.Org/licenses/gpl-3.0.txt>
  for important information about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTP://FSF.Org> for further information.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
