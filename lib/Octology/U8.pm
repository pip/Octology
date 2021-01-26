# F4IMHtuH: Octology::U8.pm crE8d by PipStuart <Pip@CPAN.Org> to have effective Ultim8 Utiliz8ion of U "You" tUbe and Useful methodz and Octoformz of upd8ing;
#   U2b8() Blongz hEre in nw U8.pm 4"Utiliz8ion" module wi Utlz4UniT of U thEm wi U2b && upd8 (as smRt nw port of Utl:updt Using upd8z 4 Octology 4 future),
# 2du:add2 U2b8 Dtection4 -F bSt sepR8 aud&&vid avail && thN try2 dnld both && post-join wi `ffmpeg -i $1 -i $2 -acodec copy -vcodec copy out.mp4` B4 U2b4 nAm,
#   mABadd U2b8 optn2auto rebild all mvz 2HD,add2 upd8 th@ if HHst eq Aku && fromHome path is in dvl/t8/Octl/Octology/ to also copy there for next `git add..`,
#   bild U2bd autOm8dtStmOde4 U2b8 2CrEsult ofruning evry dnlOded fIle thru U2b4&&shO discrepanCz Btwn NE loc8abl fIl wi sAm IdNt fEld2knO wher cOd lackz,
#   port Utl:bak e ?,gNralIzXpct,U2b8:rEplAc `yt-dl` wi Xpct2shOprogrS,rEwrIt die8 here2Dflt b64 wi many more optnz(as "Urol" or "dieU" or othr betr name?),
#   Xtract the qregex keyz && reuse them in sn() for less redundancy && use ($xp->matchlist)[\d] 4better Unific8ion (altho staging simple B4 complex good2),
#   stRt generalizing all code for wrapping more commandz && maybe alias all the interfacez to ReadKey && Expect to maybe subclass them as new U8 cmd stuff,
#   4m@ && colr Uupd8 wget && maybe wrap with testz 4 -d && -w /tmp or $TE?MP(DIR|PREFIX)? or ~/.dl or $XDG_CONFIG_HOME/user-dirs.dirs 4 XDG_DOWNLOAD_DIR;
package    Octology::U8;
use strict;use warnings;use utf8;use v5.10;
use        Octology::a8;#se Octology::c8;
use        Octology::b8;use Octology::d8;#se Unicode::UCD 'charprop'; # K3KM9999:most recent version "0.72" is part of perl-5.30.2 distribution so nEdz pmfi;
use            Expect  ;use     Math::BigFloat;
require        Exporter;use     Term::ReadKey ; # rEmMbr2 ReadMode 0 to rEstor TTY setingz aftr Ech Xpct obj finishz (since can't just do Only once@ END{})
use    base qw(Exporter); # mainly exporting global Utility functions
our @EXPORT=qw(Upd8 U2b8 U2b2 U2b3 U2b4 UTF8 Udl8); # autom8d U2bdl-upd8 Utl, YouTube 8 4main dnldtool4moviez, 2 cnv2audio, 3 2audio mp3,
#END{      ReadMode 0;} # good practice to auto-restore orig TTY read settingz at END
#          ReadMode 3;  # setup 4 raw mode or 3 cbreak mode where Ctrl-C workz since signalz are enabled
#$ENV{'TERM'}='linux';  # this is needed for arrow cursor keyz to get interpreted properly (vt100 does not do it)
our $VERSION='0.0';my $d8VS='L1PLGREE';my $Dbug= 0; #   4 4name 4matting, UTF-8 (or ASCII) tables, U2b-DownLoad altern8 Xpect version;
sub Upd8{my $Ud='youtube-dl';my $home='/home/pip';$home='/home/' . $ENV{'USER'} if(exists($ENV{'USER'}));$home=$ENV{'HOME'} if(exists($ENV{'HOME'}));
  $_=`cd /tmp;wget https://$Ud.org/downloads/latest/$Ud;mv $Ud $home/bin/U2bdl;cd $home/bin;chmod 755 U2bdl;bak U2bdl`;return($_);} # bAsic YouTube-DL upd8r
  # Upd8 very similar to .zshrc aliasez but oper8z on my own local ~pip/bin/ version instead of my system-wide /usr/local/bin/ version with alias:
  # Upc8='sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl;sudo chmod a+rx /usr/local/bin/youtube-dl;rmSS'; # also Upi8
  # Upw8='sudo wget    https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl;sudo chmod a+rx /usr/local/bin/youtube-dl;rmSS'; # with pip;
#y $U2ff=' -o "%(title)s-tItL-%(uploader)s-uldr-%(extractor)s-Xtrc-%(id)s-IdNt-%(epoch)s-epch-%(upload_date)s-uldt-%(autonumber)s-otnm.%(ext)s" '; # FullFieldz
#y $U224=' -x --audio-format=best ';my $U2rf=' --restrict-filenames ';my $U2mf=' --merge-output-format=mp4 '; # Dfalt merged .mkv (MatrosKaVid?)4m@ lackz audio
#y $U234=' -x --audio-format=mp3  ';my $U2aq=' --audio-quality=0    ';my $U2fd=' --format=18 '; # was 22 hd720p mp4 Form@Dfltnow 18 360p (pass -F 2Caltrn8optz)
my $U2ff='--output="%(title)s-tItL-%(uploader)s-uldr-%(extractor)s-Xtrc-%(id)s-IdNt-%(epoch)s-epch-%(upload_date)s-uldt-%(autonumber)s-otnm.%(ext)s"';
my $U2aq='--audio-quality=0'  ;my $U2xa='--extract-audio'; # apparently pRameter optionz for Xpect can't have any surrounding white-space! weird!  =(
my $U224='--audio-format=best';my $U2rf='--restrict-filenames';my $U2mf='--merge-output-format=mp4'; # Dfalt mergd .mkv 4m@ lackz audio
my $U234='--audio-format=mp3' ;my $U2fd='--format="bestvideo[ext=mp4][height<=?720]+bestaudio[ext=m4a]/best[ext=mp4]/best"'; # was 22 hd720p mp4 Form@ B4 bestz
sub Udmp{open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 duplic8 handle for U2bDnldMatchPrnt
  my $cxpc=shift;my $cb4m=$cxpc->before();my $cmtc=$cxpc->match();my $caft=$cxpc->after();my($U2id,$U2ic)=('','');my $resl=0;my $pads='';
  if($cmtc=~  /(^|\s*)(\[)( you)(tube)(\] \s+)         ([^:]{11})(:)/ix){$U2id=$6;d8cs('U2b8');$U2ic=b8c($U2id);d8cs();}
  $cmtc   =~ s/(^|\s*)(\[)( you)(tube)(\] \s+)         ([^:]{11})(:)/$1$Y$2$B $3$R$4$Y$5$U2ic$W$7$z/ix;
  $cmtc   =~ s/  (\s+)    (Down)(load)(ing\s+)         (  web)(page)/$1$O$2$C$3$B$4     $O$5$G$6$z/ix;
  $cmtc   =~ s/  (\s+)    (Down)(load)(ing\s+)(MPD \s+)( mani)(fest)/$1$O$2$C$3$B$4$R$5$z$6$M$7$z/ix;
  if($cmtc=~  /(^|\s*)(\[)(info)      (\] \s+)(Avail    able )(\s+for  mats)(\s+for\s+)([^:]{11})(:)/ix){$U2id=$8;d8cs('U2b8');$U2ic=b8c($U2id);d8cs();}
  $cmtc   =~ s/(^|\s*)(\[)(info)      (\] \s+)(Avail  )(able )(\s+for)(mats)/$1$Y$2$B$3${c}rm8n$Y$4$g$5$p$6$r$7$M$8/ix;
  $cmtc   =~ s/(^|\s*)(.*                                              mats)(\s+for\s+)([^:]{11})(:)/$1$2$R$3$U2ic$W$5$z/ix;
  $cmtc   =~ s/(^|\s*)    ( for)(mat )(   \s+)(code\s+)(exten)(sion)/$1$r$2$M$3$4$C$5$G$6$B$7/ix;
  $cmtc   =~ s/(^|\s*)(.*             sion\s+)(reso   )( lu  )(tion)/$1$2$o$3$G$4$c$5/ix;
  $cmtc   =~ s/(^|\s*)(.*             tion\s+)(note   )             /$1$2$m$3$z/ix;
  $cmtc   =~ s/(^|\s*)(\d+                \s+)                      /$1$R$2$z/x;
  $cmtc   =~ s/(, \s+)(   mp?4a?_dash     \s+)                      /$1 $2/x;                   # align with webm
  $cmtc   =~ s/(, \s+)(   opus            \s+)(\@     )             /$1$2    $3/x;              # align with mp4a.40.5@
  $cmtc   =~ s/(, \s+)(   vp9  )( ,       \s+)                      /$1 $2       $3/x;          # align with avc1.4d400b
  if($cmtc=~  /(  \d+)(\s+)(\1p)(\d* )(   \s+)(\d+k\s,)             /x){$resl=length("$3$4");} if($resl > 4){$pads=' ' x (4 - ($resl - 4));}else{$pads=' 'x 4;}
  $cmtc   =~ s/(  \d+)(\s+)(\1p)(\d*      \s+)(\d+k\s,)             /$1$2$3$4$pads$5        /x; # align with DASH && then k column
  $cmtc   =~ s/       (   DASH )                                    /$g$1/gx; # thN colr: DASH && _dash, m4a && mp4, webm, opus, only, container, audio&&video,
  $cmtc   =~ s/(_    )(   dash )                                    /$B$1$G$2/gx; #   \d+k, \d+Hz, \d+fps, \d+x\d+ resoz, all () pRNz, dotz, commaz, && at-sIn;
  $cmtc   =~ s/       (   m4a  )                                    /$y$1/gx;
  $cmtc   =~ s/       (   mp4  )                                    /$M$1/gx;
  $cmtc   =~ s/       (   vp9  )                                    /$P$1/gx;
  $cmtc   =~ s/       (   avc1 )                                    /$p$1/gx;
  $cmtc   =~ s/       (   webm )                                    /$w$1/gx;
  $cmtc   =~ s/       (   opus )                                    /$o$1/gx;
  $cmtc   =~ s/       (   only )                                    /$O$1/gx;
  $cmtc   =~ s/       (   tiny )                                    /$c$1    /gx;
  $cmtc   =~ s/       (   best )                                    /$W$1/gx;
  $cmtc   =~ s/       (   cont )(ainer)                             /$c$1$K$2/gx;
  $cmtc   =~ s/       (   audio)                                    /$Y$1/gx;
  $cmtc   =~ s/       (   video)                                    /$M$1/gx;
  $cmtc   =~ s/(  \d+)(       k)                                    /$R$1$K$2/gx;
  $cmtc   =~ s/(  \d+)(      Hz)                                    /$o$1$r$2/gx;
  $cmtc   =~ s/(  \d+)(     fps)                                    /$y$1$R$2/gx;
  $cmtc   =~ s/(  \d+)(       x)(\d+ )                              /$M$1$B$2$C$3/gx;
  $cmtc   =~ s/       (\( |  \))                                    /$c$1/gx;
  $cmtc   =~ s/                 (\.  )                              /$G$1/gx;
  $cmtc   =~ s/                 ( ,  )                              /$W$1/gx;
  $cmtc   =~ s/                 (\@  )                              /$w$1/gx;
  print $out8 $cb4m,$cmtc;
  close          $out8             or die "Can't close duplic8 STDOUT handle: $!";} # MatchPrint
sub Udl8{open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!";binmode $out8,':encoding(UTF-8)'; # crE8 duplic8 handle
  print $out8 $B."Udl8$O down$C"."load$G  URL2$M file$Y"."name$R  U2b4$K refo$W"."rmat\n"; # precede dl with slightly helpful text that needz colrz
  my($U2to,$U2fn,$U2an,$U2id)=( '','','',''); # Tick? Optionz, resulting output FileName, Avconv output fileName, either video IDentity or URL containing ID
  my($U2co,$U2fc,$U2ac,$U2ic)=( '','','','');my $U2fo=$U2fd; # Command Output, Colrd versionz; init local FormatOption with global FormatDefault
  if(@_){for(my $pndx=@_-1;$pndx>=0;$pndx--){#rint $B."U2b8$Y ckng$G"."pRam$W:$R$pndx$W:$C$_[$pndx]$W:\n";
                                             if   ($_[$pndx]=~ /^-+2$/){$U2fo=' ';$U2to="$U2xa $U224 $U2aq";splice(@_,$pndx,1);}  # accept Xtra 2audio paramz
                                             elsif($_[$pndx]=~ /^-+3$/){$U2fo=' ';$U2to="$U2xa $U234 $U2aq";splice(@_,$pndx,1);}  #   && get rid of thMB4spawn
                                             elsif($_[$pndx]=~ /^-+F$/){$U2fo='-F';                        }  #   && try2Dtect available  noFormatOptionz Flag
                                             elsif($_[$pndx]=~ /^-+fo/){$U2fo=$_[$pndx];splice(@_,$pndx,1);}} #   && try2Dtect overridden   FormatOption
  $U2to.=join(' ',@_) if(@_);if($U2to=~s/((https:\/\/)?(www\.)?youtu\.?be(\.com)?\/(watch\?v=)?)?([-0-9A-Z_]{11})($|\s|\S+)/$7/i){$U2id=$6;}} # srch4URL2X
  if  (length($U2id) && $U2id=~ /[-0-9A-Z_]{11}/i){ # only spawn if some param lookz like ID
    d8cs('U2b8');$U2ic=b8c($U2id);d8cs(); # ch ColrSequ 4U2bId Colr, then restore default 8bow aftr
    $U2to=~ s/(^|\s)-+F(\s|$)/$1/g if($U2fo=~ /^\s*-+F\s*$/);
    print $out8 "$B  you$R"."tube$W-$O"."d$C"."l$G -o \"%(title)s-tItL-%(uploader)s-uldrXtrc-IdNtepch-uldtotnm.%(ext)s\" $R$U2rf $B$U2fo $Y$U2to$U2ic$W;\n";
    my $Udpn='U2bdl'; #youtube-dl'; # proly STDERR putng out: 'WARNING: unable to extract uploader nickname' && UpLoadDaTes all coming back 'NA' l8ly too =(
    my @pRmz=($U2ff,$U2rf,$U2fo,$U2id);my $tmot=8; # probably can't splice @_ or join with spAcz in2 $U2to, sO mA nEd2just transfer pRamz2nwArA&&pass whol in;
    print $out8 "$Udpn @pRmz\n"; # Xtra prnt 2 figur out why `Udl8 MAPYcJ68_fU -F` ERORd with -o FileForm@ as invalid URL
    my $Xpct=Expect->new();
    $Xpct->debug(       0);$Xpct->raw_pty(     0);#Xpct->slave->stty(qw(raw)); # raw_pty doez need 2B B4 spawn along wi proly mOst optnz
    $Xpct->exp_internal(0);$Xpct->log_stdout(  0); # setup object BhAvior  # setng notrns(1) BlO wil!DlEt m@chzfrm aQmUl8or,Dflt:0; 1 gOzwi (set|clear)_accum()
    #Xpct->notransfer(  0);$Xpct->restart_timeout_upon_receive(1); # NAblng rEstRt_tImout_upon_rECv shudlet g3 plyr liveon aslong astImr upd8z continU2prnt
    $Xpct->spawn($Udpn,@pRmz)      or die "Can't spawn $Udpn: $!";#if($U2co=~/\n\[download\] Destination: (.+)/){$U2fn=$U2an=$1;} # sAv&&pRsFlNm
    $Xpct->expect($tmot, [qr/(^|\s*)\[youtube\]\s+[^:]{11}:\s+Down[^\n]+\n/     => sub {my $cxpc=shift;Udmp($cxpc);exp_continue;}],
                         [qr/(^|\s*)\[info\]\s+Available\s+formats[^\n]+\n/     => sub {my $cxpc=shift;Udmp($cxpc);exp_continue;}],
                         [qr/(^|\s*)[^\n]*\n/                                   => sub {my $cxpc=shift;Udmp($cxpc);exp_continue;}],
    ); # ($matchd_ptrn_positn,$eror,$match_strng,$be4_match,$aftr_match) is returned in array-context (wi positn 1-based)
  } close        $out8             or die "Can't close duplic8 STDOUT handle: $!";} # proly wil nEd2stuD g3 && callbakz2figure out how2bSt implMNt hEr
sub U2b8{print $B."U2b8$O down$C"."load$G  URL2$M file$Y"."name$R  U2b4$K refo$W"."rmat\n"; # precede dl with slightly helpful text that needz colrz
  my($U2to,$U2fn,$U2an,$U2id)=('','','',''); # Tick? Optionz, resulting output FileName, Avconv output fileName, either video IDentity or URL containing ID
  my($U2co,$U2fc,$U2ac,$U2ic)=('','','','');my $U2fo=$U2fd; # Command Output, Colrd versionz; init local FormatOption with global FormatDefault
  if(@_){for(my $pndx=@_-1;$pndx>=0;$pndx--){#rint $B."U2b8$Y ckng$G"."pRam$W:$R$pndx$W:$C$_[$pndx]$W:\n";
                                             if   ($_[$pndx]=~ /^-+2$/){$U2fo='';$U2to=$U224.$U2aq;splice(@_,$pndx,1);}  # accept Xtra 2audio paramz
                                             elsif($_[$pndx]=~ /^-+3$/){$U2fo='';$U2to=$U234.$U2aq;splice(@_,$pndx,1);}  #   && get rid of them B4 bktix
                                             elsif($_[$pndx]=~ /^-+F$/){$U2fo='';                          }  #   && try2Dtect available  noFormatOptionz Flag
                                             elsif($_[$pndx]=~ /^-+fo/){$U2fo=$_[$pndx];splice(@_,$pndx,1);}} #   && try2Dtect overridden   FormatOption
  $U2to.=join(' ',@_) if(@_);if($U2to=~s/(https:\/\/www\.youtube\.com\/watch\?v=)([-0-9A-Z_]{11})($|\s|\S+)/ /i){ $U2id=$2;}} # srch4URL2X
  if  ((length($U2to)&& $U2to=~/([-0-9A-Z_]{11})/i) || (length($U2id)&& $U2id=~ /([-0-9A-Z_]{11})/i)){ # only baktick if some param lookz like ID
    if( length($U2id)){d8cs('U2b8');$U2ic=b8c($U2id);d8cs();} # ch ColrSequ 4U2bId Colr, then restore default 8bow aftr
    print "$B  you$R"."tube$W-$O"."d$C"."l$G -o \"%(title)s-tItL-%(uploader)s-uldrXtrc-IdNtepch-uldtotnm.%(ext)s\"$R$U2rf$B$U2fo$Y$U2to$U2ic$W;\n";
    my $Udpn='U2bdl'; #youtube-dl'; # proly STDERR putng out: 'WARNING: unable to extract uploader nickname' && UpLoadDaTes all coming back 'NA' l8ly too =(
    print "$Udpn $U2ff $U2rf $U2fo $U2to $U2id\n";
    $U2co=`$Udpn $U2ff $U2rf $U2fo $U2to $U2id`;if($U2co=~       /\n\[download\] Destination: (.+)/){$U2fn=$U2an=$1;} # save&&pRs FlNm from&&prnt CmdOutput
#   my $Ufd8=Octology::d8->new();open my $Uofl,'>',"/tmp/Uofl-$Ufd8" or die "Can't open  /tmp/Uofl: $!";binmode $Uofl,':encoding(UTF-8)';print $Uofl $U2co;
#                                close   $Uofl                       or die "Can't close /tmp/Uofl-$Ufd8! $!"; # logz indic8 ^M^[[K prECdz progrS upd8 lInz
                                                if($U2co=~/\n\[(avconv|ffmpeg)\] Destination: (.+)/){      $U2an=$2;} # save&&pRs Avconv|ffmpeg Nm sepR8ly
                                                   $U2co=~ s/(Downloading) (webpage)/$1            $2/; # mAB .webm Bcoming .opus 4 U2b2 can B Dtected?
    $U2fc=c8fn($U2fn) if(length($U2fn));           $U2co=~ s/(      Dest)(inat)(ion)(:)\s*($U2fn) /$G$1$B$2$R$3$W$4 $U2fc/ix if(length($U2fn));
    $U2ac=c8fn($U2an) if(length($U2an));           $U2co=~ s/(      Dest)(inat)(ion)(:)\s*($U2an) /$G$1$B$2$R$3$W$4 $U2ac/ix if(length($U2an));
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
    print $U2co;if(-e "$U2an"){U2b4($U2an);}else{print $B."\nU2b8$R !*warn*!$G  did$R not$Y call$R U2b4$M since$B U2an$W:$C $U2an$R not$O found$R!\n";}}
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
      $tItL=~ s/^(.*)([-_])Dubstep_(_+)$/$1$2DrubStep$3/i ;$tItL=~ s/^(.*)(Dubstyle )(_+)$/$1DrubStyl$3/ix;$tItL=~ s/^(.*)(Hard)style(_+)$/$1_$2Styl$3/ix;
      $tItL=~ s/^(.*)(Drum_Bass   )(_+)$/$1DrumBass_$3/ix ;$tItL=~ s/^(.*)(Chillstep)(_+)$/$1ChilStep_$3/i;
      $tItL=~ s/^(.*)(Glitch_Hop  )(_+)$/$1GlitcHop__$3/ix;$tItL=~ s/^(.*)(Electro_ )(_+)$/$1ElectroH$3/ix;
                                                           $tItL=~ s/^(.*)(Electro_House)(_+)$/$1ElectroH_____$3/i; # also all8 4 Vital *House
      $tItL=~ s/^(.*)(Trap____    )(_+)$/$1TrapBass$3/ix  ;$tItL=~ s/^(.*)(Trance__ )(_+)$/$1Trannnce$3/ix; # mAB LYRICS shud alIn wi Remix,not genre?
      $tItL=~ s/^(.*)(Dubstep_Remix_)(_+)$/$1$3Remix_DrubStep/i; # reordr $genre_Remix like from 'Meg_Dia_-_Monster_DotEXE_Dubstep_Remix*'
      $tItL=~ s/^(.*)(Remix_HQ______)(_+)$/$1$3$2/i;             # alIn HQ with genrez like from 'Nacked_-_First_Date*'  # BlOflag genre @Nd
      $tItL=~ s/^(.*)((Chil|Dru[bm]|Tra[pn]|Hard)(nnce|st(ep|yl)|Bass)|GlitcHop|(Electro|Progrsv)H|StdHouse|LYRICS__)(_+)$/$1$7$2/i;
                                                                                my $gflg='';$gflg=$2 if(defined($2)); # probably shud B $2 && $2, not 2 && 7
      $tItL=~ s/^(.*?)([-_][^-_]+[-_](Re-?)?[mf]ix_)(_+)($gflg)?$/$1$4$2$gflg/i;my $rflg='';$rflg=$2 if(defined($2));
      # abov try to stick Artist over with Remix  # BlO shft Remix B4 no genre  # not sure why abov *mix also appended duplic8 uldr (maybe within gflg?)
      $tItL=~ s/^(.*)(_{8})(.*$rflg)/$1$3$2/i if($rflg && !$gflg); # alIn any /([^_]*step_Mega_|Vocal_)?(Re-?)?[fm]ix/i B4posibl tail 8wId genre
      $tItL=~ s/((EP_|FREE_|VIP_)?Monstercat_Release_)(_*)/$3$1/i; # slide to Nd of underscore padding to hopefully just B4 genre
     #$tItL=~ s/UKF_Dubstep/DrubStep/; # for some reason,uldr UKF is getting appended to Remix titles without genre with wrong padding length,shud B fixd now?
      # uldr just paded,skip Xtrc unless!U2b,dash IdNt,b64 epch,cnv uldt 2 uld8 [0-9A-Za-z._]{3},skip uniform 00001 otnm, && last append .XtNs
      if(length($uldr) < $uwid){$uldr.='_' x ($uwid-length($uldr));} $epch=b64($epch); # b64 epch probably will not need any further padng to remain aligned
      if($uldt=~  /^20(\d\d)(\d\d)(\d\d)$/){$uldt=b64($1).b64($2).b64($3);}elsif($uldt eq 'NA'){$uldt.='_';} # pad NA to 3 charz like most known d8 YMD
      if($tItL!~  /((Dru[bm]|Tra[pn]|Hard)(nnce|st(ep|yl)|Bass)|GlitcHop|(Electro|Progrsv)H|StdHouse|LYRICS__)$/){
        if   ($uldr=~ /UKF   /ix){$tItL=~ s/_{1,8}$/DrubStep/;} # could add other default genres expected for common uploaders here
        elsif($uldr=~ /Trap  /ix){$tItL=~ s/_{1,8}$/TrapBass/;} # might also need to alter these to slurp 8 underscores from before whatever remix stuff nstd
        elsif($uldr=~ /Pulse8/i ){$tItL=~ s/_{1,8}$/ChilStep/;}}
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
        print          d8c($nwd8)."$W: $ocfn\n" . ' ' x 8 . "$W: $pcfn\n"; # if U2b8 filenamez l8r become unrestricted, might have to quote or SKp namez B4 mv
        system( "mv                    $ogfn                     $psfn") if(-r "$ogfn");} # resultz sEm good so attempt 2 mv
      else{print       d8c($nwd8)."$W: $ocfn\n  $R..above original filename did not match expected U2b8 output format, so no rename (mv) performed;\n";}}}}
#ub U2bd{} # eventually tSt all log4differencez between U2b4 name output && manual movez matching U2b ID to learn what else might be useful to autom8 above
sub UTF8{my $optz=join(' ',@_);my $strt=0;my $uprb= 256; # 2BNJCDfo:asci utility to colorfully print most ASCII characterz (G7KMJqLF: ... now2 UTF8 < 256)
  open my $out8,'>&',STDOUT or die "Can't open  duplic8 STDOUT handle: $!"; # crE8 local duplic8 of global
  my $widf=           0 ;$widf=         1   if(exists($ENV{'COLUMNS'}) && $ENV{'COLUMNS'} >= 153);my $outp; # fitz nicely in either 80 or 160 column termz
  my $trmt=      'xterm';$trmt=$ENV{'TERM'} if(exists($ENV{'TERM'   }));my $tsxf=0;$tsxf=1 if($trmt =~ /^(screen|xterm|st-)/); # Eterm badly nEdz betr fontz1st
  my $trmp='gtm';$trmp=$ENV{'TERM_PROGRAM'} if(exists($ENV{'TERM_PROGRAM'})); # might need to test for special-cases on per-term-prog + font basis l8r
  my $lang='en_US.UTF-8';$lang=$ENV{'LANG'} if(exists($ENV{'LANG'   })); # abov try2test wich term typez shud group in with screen && xterm 4 BlO handling
  if($tsxf && $lang =~ /UTF-?8/i){binmode $out8,':encoding(UTF-8)';} # need to encode output if acceptable terminal && language environment settingz
  if  ($optz =~  /(^|\s)(-*h(elp)?)(\s|$)/){ # -h parameter design8z to just print help text as output && exit
    $outp = " UTF8  - print out 256 colorful UTF-8 or ASCII characters in order  Vers:$VERSION  d8VS:$d8VS  by Auth:$Auth
   -p    skips over first 32 to start from the predominantly Printable characters  (since most of the 1st 32 are control chars)
   -c    disable printing of escape sequences which are used to Color the default output in 8bow and index columns
   -C    set start and end around Cards and Chess 127136-127199 and 9812-9823
   -k    set start and end around Kana      (Nipponese Hiragana and Katakana need some special handling to restore alignment.) 12352-12543=192
   -r    set start and end around Radicals  (CJK Supplement     and Kangxi) (note terminals need to stretch to 225 chars wId.) 11904-12255=352
   -h    display this Help text and exit    (Greek 913-970= 67)     (See HTTP://Unicode.Org/charts for more character blocks.)
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
    if($optz =~ s/(^|\s)(-*C)(\s|$)/$1$3/){$strt=  127_136  ;$uprb=  127_200  ;} # -C parameter tries Cards 1st thN should reset uprb && indx 2loop Chess aftr
    if($optz =~ s/(^|\s)(-*k)(\s|$)/$1$3/){$strt=dec('3040');$uprb=dec('3100');  # -k parameter design8z Kana (1st Hiragana then Katakana); did uprb++ 4-k&&-r;
      if($optz=~s/(^|\s)(-*r)(\s|$)/$1$3/){$strt=dec('2E80');}                 } #   specially allow k && r rangez to be combined
    if($optz =~ s/(^|\s)(-*r)(\s|$)/$1$3/){$strt=dec('2E80');$uprb=dec('2FE0');} # -r parameter design8z Radicals (CJK Supplement && Kangxi)
    if($optz =~ s/(^|\s)(\d+)(\s|$)/$1$3/){$uprb=$2;} # allow single digit parameter to specify UPpeRBound && second digit param to design8 STaRT
    if($optz =~ s/(^|\s)(\d+)(\s|$)/$1$3/){$strt=$2;} ($uprb,$strt)=($strt,$uprb) if($strt > $uprb); # keep start && upperbound in increasng order
    $outp .= ' ' x (19*4) if($strt==  32 && $widf); # space align if skipping 1st unprintablez block
    for(my $indx = $strt;$indx < $uprb;$indx++){my $ib6c=b8c(b64($indx)); # added colrz using a8::b8c && b8::b64
      $ib6c= " $ib6c" if($indx <   64);         my $hexi=    HEX($indx) ; # pad top-row b64 indicez with a space to the left if they're just one char
      if  ($indx    <= 9999 || $indx != $strt){ # when starting on super-huge indices, don't need to preface with White colon && NewLine
        if($indx    < 11_904){
          if($widf){$outp .= "$W:\n" if($indx &&  !($indx % 64) && defined($outp)                );} # hopefully adding defined tst here will stop empty : line
          else     {$outp .= "$W:\n" if($indx &&  !($indx % 32) && ($indx >   32 || $optz !~ /p/));}
        } else     {
          if($widf){$outp .= "$W:\n" if($indx &&  !($indx % 32)                                  );} # try2 insert newlinez for wide-charz in high loopz too
          else     {$outp .= "$W:\n" if($indx &&  !($indx % 16)                                  );}}}
      unless ($indx %     8){
        if   ($indx <=  255){$outp .= sprintf("$W:$G%3d$W:$B%02s$W:%s$W:",$indx,$hexi,$ib6c);}
        elsif($indx <=  999){$outp .= sprintf("$W:$G%3d$B%03s$W:%s$W:"   ,$indx,$hexi,$ib6c);}
        elsif($indx <= 4095){$outp .= sprintf(   "$G%4d$B%03s$W:%s$W:"   ,$indx,$hexi,$ib6c);}
        else                {$outp .= sprintf(   "$G%4d$B%04s%s"         ,$indx,$hexi,$ib6c);}}
      if($tsxf){ # check Terminal Screen or Xterm Flag for which charz print acceptably
        if     ($indx >=   0 &&                 $indx <=  31 ){ $outp .=  $K  . b64($indx    );} # used2have many special cases, but now just trying big blox
        elsif  ($indx == 127                                 ){ $outp .= "$o$bb!$z"           ;} # still with special bang override
        elsif  ($indx >= 128 &&                 $indx <= 159 ){ $outp .=  $w  . b64($indx-128);}
        elsif  ($indx >= 888 &&                 $indx <= 889 && $trmp =~ /^[xgs](tm?|80|T)$/){$outp.="$M$bb!$z" ;} # special bang override just 4some TermProgz
        elsif  ($indx >= 896 &&                 $indx <= 899 && $trmp =~ /^[xgs](tm?|80|T)$/){$outp.="$p$bb!$z" ;} # had2add $bb bkgrnd-blue 2 a8.pm 4this2work
        elsif (($indx == 907 || $indx == 909 || $indx == 930)&& $trmp =~ /^[xgs](tm?|80|T)$/){$outp.="$R$bb!$z" ;} # wi this my gt,xt,st,sa alIn up2 1024 fIn
        elsif  ($indx ==12441|| $indx ==12442                                               ){$outp.="$M$bb!$z" ;} # try to put something for missing in -kana
        else   {$outp .= S(substr($cmap{'8bow'},$indx % 8, 1 )) . chr($indx);}}
      else     { # 8trm can directly handle all characterz (Xcept chr(10) x0A \n) because it has no standard Ctrl-code interpret8ion yet
        if     ($indx !=     10 && $indx <    256){$outp .= S(substr($cmap{'8bow'},$indx % 8, 1 )) . chr($indx);}
        else   {$outp .= "$R!$z";}} # shud B ckng Xplicitly 4 8trm in $trmp (once it sets it) so thN not trying to go abov 255 wher old .psf (&& .f0nt) stop
      if       ($indx ==127_151                                                             ){$outp.="$R$bb!$z" ;} # try to keep Cards aligned
      if       ($indx ==127_167 || $indx ==127_199                                          ){$outp.="$R$bb $z" ;} # try to align end white colons
      if      (($indx >=    768 && $indx <    880) || $indx == 12_352 ||
               ($indx >=  1_155 && $indx <  1_162) || $indx == 11_930 ||
               ($indx >=  1_425 && $indx <  1_477) ||
               ($indx >= 12_020 && $indx < 12_032) ||
               ($indx >= 12_246 && $indx < 12_256) ||
               ($indx >= 12_439 && $indx < 12_443) ||
               ($indx >=127_136 && $indx <127_200)){ # also here add more spaces && some newlines for -radicals && -kana to also align
        $outp .= ' ';} # try to space out what are presumably something like combin8ion code-points without whole grapheme clusterz
      if($indx == 127_199 && $strt == 127_136){$outp.="$W:\n";$uprb= 9_824;$indx= 9_811;$strt= 9_812; # atMpt2autO-jump from end of Cards dn2 Chess: 9812-9824
        $ib6c  =     b8c(b64($strt));$hexi= HEX($strt);$outp.= sprintf(   "$G%4d$B%04s%s"         ,$strt,$hexi,$ib6c);}
    }   $outp .= "$W:";$outp = sS($outp) unless($clrf);
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

Octology::U8 - Octology Utiliz8ion, Upd8, and UTF-8 functionality

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
CopyRight: (c) 2014-2020, Pip Stuart.
CopyLeft : This software is licensed under the GNU General Public License
  (version 3 or l8r). Please consult L<HTTPS://GNU.Org/licenses/gpl-3.0.txt>
  for important inform8ion about your freedom. This is Free Software: you
  are free to change and redistribute it. There is NO WARRANTY, to the
  extent permitted by law. See L<HTTPS://FSF.Org> for further inform8ion.

=head1 AUTHOR

Pip Stuart <Pip@CPAN.Org>

=cut
