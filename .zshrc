# 381KF3RN:~/.zshrc by PipStuart <Pip@CPAN.Org>; nOt:I originallythotitbetr2rElymoronstndalOnXecutablUtlz than aliases||shL-scrpt funczDfynd inany .rc Bcuz4mer
#   stAyavail2spwnd procSz wich hvOwn non-zsh sub-shL cfgz(eg,insrtngPerl2vim:r!q 127/7;b64 1023)sO I pland2port stufhEr2myOctology libz&&~/bin
#   butIhv rElIzd that c8.pm (inprep4 8sh)wilBAbl2pars .(ba|z)shrc fIlz2lOd thEz&&can mk thMavail2othr shLz bywrapng cmdz wiXpansionUtlz; lern LaunchPad/byobu,
# 2du:add perVC autostRt nwlOcl`scrn`if!alredy in1,lern`autoload -z`&&sepR8hist,get any othrUseful modulz lIk pcre,
#   bakon gN2:`em  scummvm`:2use nw"modern"theme4scummvm,add2[scummvm]sect of~/.scummvmrc(aftr runing scummvm once):themepath=/usr/share/games/scummvm/engines
#   nowon ubu:`agi scummvm`&&mAB -d8a shud wrk2plA around wi2D advN2rz AgN; If cmd cursr is by an alias Ctrl-x,a will _expand_alias&&mABcan disAblit4 wh pRam?
# nOt:`sz`in/etc/init.d c@chz lOcl sudo* bin daemon nstd of /usr/bin versN,prmpt similRly chOkz tryng`d8`within~/.inst/perl-5.8.8 sO mAB rEordr path2!hv probz?
#[[   -e /sw/bin/init.sh ]] && source /sw/bin/init.sh; # fink:FreeBSD special shL stufInEded2src4zsh on oldLBoxB4Keith rEvertd bak2 gN2; "${(L)OSTYPE}"== *bsd?
zmodload       zsh/pcre
  setopt                \
  auto_cd               \
  auto_name_dirs        \
  complete_in_word      \
  re_____match_____pcre \
  hist___________verify \
  hist__ignore_all_dups \
  pushd_ignore_____dups \
  pushd___________minus \
  prompt__________subst \
  magic___equal___subst  # man zshoptions explains all are case-insensitive && ignore underscores so I'm using them now for word sepR8ion && vertical alignment
unsetopt                \
  pushd_____to_____home \
  hist__save___by__copy \
  share_history         \
  bash_rematch          \
  prompt_cr              # nO CarriageReturn B4 Ech nw prmpt (sux th@ cmdln editng oftN getz skewd unlS nwlInz bracket evrythng); F1KL2nZE:mvd sharehist dn2un;
# hist__save___by__copy \# acordng2:HTTP://ZSh.Org/mla/workers/2006/msg00787.html setng this shudlet root sharemy .zsh_history or HIST_APPEND or SHARE_HISTORY?
# menu_complete         \# setng mkz 1st tab XplOd m@ch list;    # bash_rematch mAB mkz regX capturez use $BASH_REMATCH instead of default $match?
# auto_pushd            \# setng addz dirz 2 stack wN just normally chngng 2 thM (wich I du not normally lIk or want)
# ksh_arrays            \# rEmMbr wNwrItng scrptz[or funcz]2include'setopt [localoptions] ksharrays'sO arAzR 0-bAsed(but!glOblBcuzmOst scrptzRstndrdly 1-bAsed)
# re_____match_____pcre \# mA want2set for Z-SHell scripting RegularExpressions to utilize PerlCompatibility styles && mA insert 'zmodload zsh/(pc)?re(gex)?';
export vers='0.0';export d8VS='IA4M8sat';export auth='PipStuart <Pip@CPAN.Org>'; # not Xportng $b sinc cOlIdz wi sort{$a <=> $b} /defhijlnqstuvx/i + AZ 4golf;
if     [[       "$SHELL"    == "" ]]; then       export SHELL=`  which zsh`;fi # 8sh should parse this && OverId it    # shud `man zshall` /OSTYP 2lern4BlO
if     [[       "$HOSTNAME" == "" ]]; then       export HOSTNAME=`hostname`;fi #`hostname`retnz fsckd nwlInz\n4CygWinzRxvt... ||smthng els lame  =(
if     [[       "$HOST"     == "" ]]; then       export HOST="$HOSTNAME"   ;fi;export VERBOSE='1'; # set flag to print debug && status info from system utilz
export     HHst="$HOST";alias lc="tr 'A-Z' 'a-z'";alias uc="tr 'a-z' 'A-Z'"; # || mayb atMpt2dup $var thru: $(echo $var|tr 'A-Z' 'a-z') | "[:(upp|low)er:]"
export     HUsr="$USER";export HEdt=`which vim` ;export HWid="$COLUMNS";export HOSy="$OS"; # zsh's lc() 4varz2 m//i "${(L)HOSTNAME}"acordng2:
export     HShl='zsh'  ;export HPgr=`which most`;export HHit="$LINES";  export HOTy="$OSTYPE";export H3WF="1"; #HTTP://WWW.CS.Elte.Hu/zsh-manual/zsh_6.html
export  COLUMNS="$COLUMNS";export LINES="$LINES";export ROWS="$LINES"; # zsh setz thEse lOcally but must Xport thM 4 Perl scriptz 2 access
# Used2 if [[ "${(L)HHst}" == ax9* ]]; then export HHst='Ax9'; elif ... 2abbreV8&&capitalIz myhOst&&UzrnAmz fromold dvl&&work machinz especially4CygWindoze;
# XDG (Xorg baseDirzGuide)4:GTK2,Compiz,Uzbl,Arora,Audacious,TrollTech,etc. from: HTTP://Standards.FreeDesktop.Org/basedir-spec/basedir-spec-latest.html
export XConfHom="$HOME/.config";     export XConfDrz="/etc/xdg";                   export XDG_CONFIG_HOME="$XConfHom";export XDG_CONFIG_DIRS="$XConfDrz";
export XDataHom="$HOME/.local/share";export XDataDrz="/usr/local/share:/usr/share";export   XDG_DATA_HOME="$XDataHom";export   XDG_DATA_DIRS="$XDataDrz";
export XCachHom="$HOME/.cache";      export XSESSION='Gnome';                      export  XDG_CACHE_HOME="$XCachHom";export XDG_MENU_PREFIX='gnome-';
export bk="\e[40m"   ;export br="\e[41m"   ;export bo="\e[43m"   ;export by="\e[43m"   ;export bg="\e[42m"   ; # set shell col8 colr escape codez akin to a8.pm
export bc="\e[46m"   ;export bb="\e[44m"   ;export bm="\e[45m"   ;export bp="\e[45m"   ;export bw="\e[47m"   ; # first add bkgr colrz, then shorter fgrndclrz
export  k="\e[22;30m";export  r="\e[22;31m";export  o="\e[22;33m";export  y="\e[22;33m";export  g="\e[22;32m"; # set shell col8 colr escape codez akin to a8.pm
export  c="\e[22;36m";export  b="\e[22;34m";export  m="\e[22;35m";export  p="\e[22;35m";export  w="\e[22;37m";export SKpb="$b"; # like a8.pm altern8 cmp $b
export  K="\e[01;30m";export  R="\e[01;31m";export  O="\e[22;33m";export  Y="\e[01;33m";export  G="\e[01;32m";export    z="\e[00m"; # like a8 $SKp0 . 'm'
export  C="\e[01;36m";export  B="\e[01;34m";export  M="\e[01;35m";export  P="\e[22;35m";export  W="\e[01;37m"; # these then should become able to use in Uk etc
export hk="\e[100m"  ;export hr="\e[101m"  ;export ho="\e[103m"  ;export hy="\e[103m"  ;export hg="\e[102m"  ; # also setup High-intensity varE8ionz, which
export hc="\e[106m"  ;export hb="\e[104m"  ;export hm="\e[105m"  ;export hp="\e[105m"  ;export hw="\e[107m"  ; #   a8.pm doesn't even include to export yet
export HK="\e[90m"   ;export HR="\e[91m"   ;export HO="\e[93m"   ;export HY="\e[93m"   ;export HG="\e[92m"   ; # '_'=>'01;30'  '^'=>'00'
export HC="\e[96m"   ;export HB="\e[94m"   ;export HM="\e[95m"   ;export HP="\e[95m"   ;export HW="\e[97m"   ; # '.'=>'22;30'
# HCSL8BCz:note that all these new minimal variable names for color-codes have a good chance of colliding in minimal shell-script usages defined l8r below;
alias    clrz='echo -en "$z hk:$hk#$z; hr:$hr#$z; ho:$ho#$z; hy:$hy#$z; hg:$hg#$z; hc:$hc#$z; hb:$hb#$z; hm:$hm#$z; hp:$hp#$z; hw:$hw#$z; z:#; z lIk a8 ^;
 bk:$bk#$z; br:$br#$z; bo:$bo#$z; by:$by#$z; bg:$bg#$z; bc:$bc#$z; bb:$bb#$z; bm:$bm#$z; bp:$bp#$z; bw:$bw#$z;
  k:$k#$z;  r:$r#$z;  o:$o#$z;  y:$y#$z;  g:$g#$z;  c:$c#$z;  b:$b#$z;  m:$m#$z;  p:$p#$z;  w:$w#$z;
  K:$K#$z;  R:$R#$z;  O:$O#$z;  Y:$Y#$z;  G:$G#$z;  C:$C#$z;  B:$B#$z;  M:$M#$z;  P:$P#$z;  W:$W#$z;
 HK:$HK#$z; HR:$HR#$z; HO:$HO#$z; HY:$HY#$z; HG:$HG#$z; HC:$HC#$z; HB:$HB#$z; HM:$HM#$z; HP:$HP#$z; HW:$HW#$z;"'; # prnt tStset4 bSt mAjr colrcOdz2suport
# 99RJGN8g:from old gN2 root@Ryu`em xinit`:IfUUse`startx`nstd ofa login mngr like gdm/kdm,Ucan set XSESSION 2anythng in /etc/X11/Sessions/ or any executable.
#   wNU`startx`,itwilrunthis astheloginsession.Ucan set this ina filein /etc/env.d 4NtIrsys,orsetit perUser in ~/.bash_profile (or similR4othr shLz). Xamplof
#   setng4wholsys:`echo XSESSION="Gnome" > /etc/env.d/90xsession; env-update && source /etc/profile`; EBJLAkY8:AkuUbu14.10 nolongrhas thOsdirz sOprolyunUsed;
export JAVA_HOME='/usr/lib/jvm/java-7-openjdk-amd64';     # D7PM1TjA:upd8d4Ubu13.04&&ant4Android dvl 2add2pathBlO
ulimit  -c 65535; # 33,553,920-bytes # setz coredump size limit2 32MB (4Dbugng) wher #-param is *512-byte blox or 'unlimited' canBUsed
typeset -U path ; path=($HOME/bin $HOME/.local/bin /usr/local/sbin /usr/sbin /sbin . /usr/local/bin /usr/bin /bin /opt/bin $HOME/lib/perl5/bin $HOME/lib/Octology/f8/pal8 $HOME/dvl/t8/dmd/linux/bin $JAVA_HOME/bin $HOME/dvl/t8/ndrd/adt/sdk/tools $HOME/dvl/t8/node $HOME/.nodebrew/current/bin $path); # atmptd2nstl DMDv2.052 on Java7OpenJDK && GoogleAndroid-18 (4.2)
#          path=($path  $HOME/dvl/t8/node $HOME/.nodebrew/current/bin );export path; # I7CMBrew:got GitHub NodeBrew 4NodeJS; Not sure why src doesn't get this?
#          path=($path  $HOME/dvl/jobz/InnovationProtocol/Android/Android-Google-Linux_x86-SDK-1.6_r1-99GFQiD/tools); # old2009GoogleAndroid dvlpmnt-toolz path
#f   [[ -d             "$HOME/.rakudobrew/bin" ]]; then # examples prepended Rakudo's bin/ to $PATH but I'd rather append them for now (if bin/ dir is found)
#          path=($path  $HOME/.rakudobrew/bin $HOME/.rakudobrew/moar-nom/install/share/perl6/site/bin              ); # G1NLJQKA:try out RakudoBrew for Perl6
# eval               "$($HOME/.rakudobrew/bin/rakudobrew init -)"; fi; fi # this shud lOd RakudoBrew autOmaticly with new shells (Xample said add 2 .profile)
#          path=(       $HOME/lib/site/PerlBrew/bin   $HOME/lib/site/Perlbrew/perls/current/bin               $path); # CrAzY PerlBrew wanting2crE8 perl5 in~!
#xport                                 PERLBREW_ROOT="$HOME/lib/site/PerlBrew";                                       #   ... && 2prEpNd th@+/perlbrew/**/bin!
export PERL_LOCAL_LIB_ROOT="       $HOME/lib/perl5";
export PERL_MB_OPT="--install_base $HOME/lib/perl5";
export PERL_MM_OPT="  INSTALL_BASE=$HOME/lib/perl5";      # I know these && path below were slightly different on Ryu, && Aku hasn't even needed lib/perl5;
export CHROME_USER_DATA_DIR="$HOME/.chrome";              # G1NL5XYZ:Used2hv2vim /opt/google/chrome/google-chrome &&nsrt cd /tmp B4 last blok aftrEch upd8;
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"; # B52MDt4l:Added4Box2D
export PKG_CONFIG_PATH="/usr/lib/pkgconfig";              # E2LLATsm:Added4SrcHiLite
# consider replacing below with exportz like a8 fully escaped color variablez so that shell scriptz can echo them similarly (and add $f[0-9A-Za-z._] f0ntz too)
#echo -e "$k   k $r   r $o   o $y   y $g   g $c   c $b   b $m   m $p   p $w   w"  # used to have c8[fb]g.2ae map here but unnecessary
#echo -e "$bk bk $br br $bo bo $by by $bg bg $bc bc $bb bb $bm bm $bp bp $bw bw"
#echo -e "$K   K $R   R $O   O $Y   Y $G   G $C   C $B   B $M   M $P   P $W   W"  # when wanting to view %ENV in zsh, $IFS NUL requires `set | grep -a`
                                                 export TZ='America/Chicago'; # .. which is the same as my /etc/timezone file && maybe CDT -5 at D8FCQgn;
#xport DST='0'; watch=(notme);                  #export TZ='CST';     # DaylightSavingsTime?;                            | Coordinated Universal Time (UTC|GMT)
#f   [[ "${(L)HOTy}" ==         cygwin* ]]; then export TZ='PST'; fi; # United States of America / Los Angeles (PST|PDT) | Coordinated Universal Time (UTC|GMT)
#xport LANG='en_US.UTF-8';export LC_ALL="$LANG"; export LC_CTYPE="$LANG";export LANGUAGE="$LANG"; # orig mA hav nEded thEs lang setngz4 urxvt?
# 82DJ06ZE:instead of abov relying on exported ENV variablez it seemz betr2set /etc/(env.)?d(efault)?/(02)?locale or2use `localedef` probably4mostUsecases?;
#xport TERM='linux'; # find out when explicit TERM assignment has seemed necessary (maybe for vim colors but fixed by .vimrc "set background=dark"?)
export EDITOR="$HEdt" ;export PERL5LIB="$HOME/lib:$HOME/lib/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:$HOME/lib/perl5/lib/perl5:./lib"; # `which vim `; #dflt(&&preferred)way2load my *.pm (butTaki shud nstd get i386 path)
export  PAGER="$HPgr" ;export PERL_TEST_POD='1'   ; #`which most`||PAGER=`which less`||PAGER=`which more`;export PAGER; #a good practice for Perl Kwalitee
                       export PERL_TEST_CRITIC='1';export PMARSHOME='/usr/share/games/pmars/macros'; #fyn,letz get crit! ;) && pmars-sdl needz its macroz;
                       export SDL_VIDEO_CENTERED='center'; #xport SDL_VIDEO_WINDOW_POS='x,y'; try2cntrSDLapzfrom: HTTP://SDL.Beuc.Net/sdl.wiki/SDL_SetVideoMode
#                      export SDL_WINDOWPOS_CENTERED='1' ; # try2cntrSDLapzfrom: HTTP://Wiki.LibSDL.Org/moin.cgi/SDL_SetWindowPosition?highlight=%28\bCategoryVideo\b%29|%28CategoryEnum%29|%28CategoryStruct%29
#xport GTK_IM_MODULE='uim'; #2uze uim-skk:`em skk-jisyo`;4DfltInptMethd add2~/.uim:(define default-im-name 'skk|anthy|*');#2fyndIMz:`uim-im-switcher-[gq]tk?`;
#xport  QT_IM_MODULE='uim';export XMODIFIERS=@im=uim ; #export CD_ROOT="$HOME/gmz"; #Xportng CD_ROOT=~/gmz was tmp needed2`em quake3`(ioq3);mayb s/uim/scim/g;
export CVS_RSH=`which ssh`;export CVSROOT='/var/cvs';export LS_OPTIONS='--color=auto'; # LsOptz: --color=always|yes|force|never|no|none|auto|tty|if-tty
dircolors=`which dircolors`||dircolors=`which gdircolors`;export dircolors;alias drc='dircolors';export COLORFGBG='default;default'; # abov Dfalt CVSRootPath..
if   [[ "${(L)HOTy}" == *bsd ]]; then alias    ls='gls $LS_OPTIONS'     ;              # .. does not exist && is pretty obsOlEt now
else                                  alias    ls=' ls $LS_OPTIONS'     ; fi # load ls/dir color resources...
if   [[ -r   "$HOME/.lsrc"   ]]; then  eval $($dircolors -b $HOME/.lsrc);    # orig also ck'd 4 m/^~\/\.(ls|dir)_colors$/i beyond .lsrc but I don't think
else                                   eval $($dircolors -b            ); fi #   I'll need to further support any of those; just init sysdefaults if!.lsrc
# `ls` can h&l all kIndz of globz >than `dircolors` mkz but! [chrz]||dbl*, .lsrc can!hv[-_?], && Uz ~/.lrc && `lrc` 2help sync nw .XtNz with `dircolors -p`;
# nOt:ther hv been afew problMz wi thEse l8r apNded dFinitNz clobrng earlier .XtN defz sO I've mAde nOticd 1z mor specific but mAB should just Only prEpNd all?
         LS_COLORS="$LS_COLORS*-ignore=01;31:*-conf=01;33:*-magic=01;31:*-release=01;36:*-xsessions=01;35:*-=00;31:*_COLORS=01;33:*_vimrc=00;33:";
         LS_COLORS="$LS_COLORS*_completion=01;35:*_version=00;36:*_not_found=01;31:";                #/etc Xtra _XtNz (here)    && -(release|xsessions)? (abov)
         LS_COLORS="$LS_COLORS*_Dingbats=01;31:*_Symbol=01;33:*_Unicode=01;36:*_Wingdings=01;35:";   #/etc/alternatives/ghostscript-current/Resource/Decoding
         LS_COLORS="$LS_COLORS*-down=00;31:*-up=01;31:*-off=00;35:*-on=01;35:*-aticonfig=01;36:*-wireless=01;33:*-undock=00;36:*-cmos=00;33:"; #/e*/acpi/events
         LS_COLORS="$LS_COLORS*-Bold=01;31:*-BoldItal=00;33:*-Ital=01;33:*-Roma=00;36:*-BoldObli=01;36:*-Regu=01;35:*-ReguObli=00;35:*-Medi=00;31:";
         LS_COLORS="$LS_COLORS*-MediItal=01;31:*-ReguItal=00;33:*-BoldCond=01;33:*-BoldCondItal=00;36:*-ReguCond=01;36:*-ReguCondItal=01;35:*-DemiBold=00;35:";
         LS_COLORS="$LS_COLORS*-DemiBoldItal=00;31:*-Ligh=01;31:*-LighItal=00;33:*-Book=01;33:*-BookObli=00;36:*-Demi=01;36:*-DemiObli=01;35:";
         LS_COLORS="$LS_COLORS*-PCLPS2=01;33:"; #</etc/alternati*/ghostscript-current/Resource/Init #^/etc/alternatives/ghostscript-current/Resource/Font
         LS_COLORS="$LS_COLORS*-WMode=01;31:";                                                       #/etc/alternatives/ghostscript-current/Resource/SubstCID
         LS_COLORS="$LS_COLORS*-account=01;31:*-auth=00;33:*-password=01;33:*-session=01;36:*-noninteractive=01;35:*-daemon=01;31:*-screensaver=01;35:";
         LS_COLORS="$LS_COLORS*-autologin=00;35:*-greeter=01;36:*-freerdp=00;33:*-containers=01;36:";# (~8bow cycl) /etc/(apparmor|pam).d
         LS_COLORS="$LS_COLORS*-uccsconfigure=01;33:*-1=00;35:*-user=00;36:*-l=01;31:";              #   more       /etc/          pam .d
         LS_COLORS="$LS_COLORS*-common=01;31:*-client=00;33:*-accessibility=01;33:*-strict=00;36:*-integration=01;36:*-browser=01;35:*-kit=00;35:";
         LS_COLORS="$LS_COLORS*-files=00;31:*_certs=01;31:*_keys=00;33:*-repositories=01;33:*-clients=00;36:*-browsers=01;36:*-email=01;35:*-readers=00;35:";
         LS_COLORS="$LS_COLORS*-terminal=01;33:*-helpers=00;31:*-konsole=01;31:*-players=00;33:*-base=01;33:*-launcher=00;36:*-messaging=01;36:*-xterm=01;35:";
         LS_COLORS="$LS_COLORS*-download=00;35:*-mail=00;31:*-manpages=01;31:*-tmp=00;33:*-write=01;33:*-data=00;36:*-desktop=01;36:"; #/etc/ap*.d/abstractions
         LS_COLORS="$LS_COLORS*change_profile=01;35:*find_mountpoint=01;36:*is_enabled=01;33:";      #/etc/apparmor.d/abstractions/apparmor_api
         LS_COLORS="$LS_COLORS*-editors=01;33:*-xul=01;35:";                                         #/etc/apparmor.d/abstractions/ubuntu-browsers.d
         LS_COLORS="$LS_COLORS*-dirs=01;35:"; # all these /etc/** entries are mainly defined here in default `ls` order           #/etc/apparmor.d/tunables
         LS_COLORS="$LS_COLORS*-kernels=01;31:*-stamp=01;33:*-notifier=01;36:";                                                   #/etc/apt/apt.conf.d
         LS_COLORS="$LS_COLORS*-cache=01;31:*-validate=00;36:*-prompt=01;33:*-tools=01;36:*-highlight=01;36:*-completion=00;35:"; #/etc/bash_completion.d
         LS_COLORS="$LS_COLORS*-contest=01;36:";                                                                                  #/etc/cron.d
         LS_COLORS="$LS_COLORS*-settings=01;33:"; # care has been taken to attempt to distribute colors pretty evenly in dirz     #/etc/dconf/db/ibus.d
         LS_COLORS="$LS_COLORS*-support=01;35:*-setup=00;36:*-chrome=01;36:*-config=01;33:*-3g=01;35:*-dispatcher=00;35:";        #/etc/default
         LS_COLORS="$LS_COLORS*-tips=01;31:*-net=01;31:*-bridge=00;33:*-inetd=01;36:";                                            #/etc/default
         LS_COLORS="$LS_COLORS*-routes=01;35:";                                                                                   #*/dhcp/dhclient-exit-hooks.d
         LS_COLORS="$LS_COLORS*-default=00;31:*-english=01;33:";                                                                  #/etc/dictionaries-common
         LS_COLORS="$LS_COLORS*-whitelist=01;37:";                                                                                #/etc/gnome-app-install
         LS_COLORS="$LS_COLORS*skeleton=01;31:";                                                                                  #/etc/init.d
         LS_COLORS="$LS_COLORS*_map=01;31:*_dsfield=00;33:*_protos=01;33:*_realms=01;36:*_scopes=01;35:*_tables=00;35:";          #/etc/iproute2   (~8bow cycl)
         LS_COLORS="$LS_COLORS*-runtime=01;31:";                                                                                  #*/logcheck/ignore.d.paranoid
         LS_COLORS="$LS_COLORS*-service=01;35:*-paniclog=00;33:*-utils=01;36:*-syslog=01;31:";                                    #/etc/logrotate.d
         LS_COLORS="$LS_COLORS*-usernet=01;36:";                                                                                  #/etc/lxc
         LS_COLORS="$LS_COLORS*-palette=01;35:";                                                                                  #/etc/newt
         LS_COLORS="$LS_COLORS*-secrets=01;31:";                                                                                  #/etc/ppp
         LS_COLORS="$LS_COLORS*debian_config=01;33:";                                                                             #/etc/python*
         LS_COLORS="$LS_COLORS*README=01;37:";                                                                                    #/etc/(rc*|sysctl).d|terminfo
         LS_COLORS="$LS_COLORS*-order=01;35:";                                                                                    #/etc/resolvconf
         LS_COLORS="$LS_COLORS*ssh_config=01;33:*sshd_config=00;33:*sa_key=01;36:*_import_id=01;35:";                             #/etc/ssh
         LS_COLORS="$LS_COLORS*-paths=01;33:";                                                                                    #/etc/system-image
         LS_COLORS="$LS_COLORS*-server=01;36:";                                                                                   #/etc/ufw/applications.d
         LS_COLORS="$LS_COLORS*-upgrades=01;35:";                                                                                 #/etc/update-manager
         LS_COLORS="$LS_COLORS*-manager=01;35:*core=01;31:*.conf.01162014=00;31:"; #/etc/X11    can't double star *.conf.* or charclass for *.conf.[0-9]{8}
         LS_COLORS="$LS_COLORS*-color=01;36:*-nocase=01;33:*-chrtr=00;33:*-belgian=00;36:*-danish=01;35:*-fitaly=00;35:*-french=00;31:*-french2=01;31:";
         LS_COLORS="$LS_COLORS*-german=00;33:*-greek=01;33:*-hebrew=00;36:*-icelandic=01;36:*-italian=01;35:*-jisx6002=00;35:*-jisx6004=00;31:";
         LS_COLORS="$LS_COLORS*-korean=01;31:*-latin1=00;33:*-norwegian=01;33:*-portuguese=00;36:*-russian=01;36:*-slovene=01;35:*-small=00;35:";
         LS_COLORS="$LS_COLORS*-spanish=00;31:*-strip=01;31:*-swedish=00;33:*-swissgerman=01;33:*-turkish=00;36:*-uk=01;36:";     #/etc/X11/app-defaults (~8bO)
         LS_COLORS="$LS_COLORS*-args=00;31:*_xresources=01;31:*-local=00;33:*_xsessionrc=01;33:*_support=00;36:*-startup=01;36:*_gnomerc=01;35:";
         LS_COLORS="$LS_COLORS*_localhost=00;35:*_path=00;31:*-update=01;31:*_launch=00;33:*-launch=01;33:*-gtk3=00;36:*-scrollbar=01;36:";
         LS_COLORS="$LS_COLORS*-xim=01;35:*-gtk=01;33:";                                                                          #/etc/X11/xinit/xinput.d
         LS_COLORS="$LS_COLORS*-a11y=01;35:*-agent=00;35:*_start=01;31:*_stop=00;31:*-va-gl=01;35:*-adaptor=01;31:*-env=00;33:";  #/etc/X11/Xsession.d
         LS_COLORS="$LS_COLORS*-addresses=00;35:";                                                                                #/etc/email-addresses (exim)
         LS_COLORS="$LS_COLORS*machine-id=01;30:";                                                                                #/etc
         LS_COLORS="$LS_COLORS*-repository-8_xml=01;35:*-addons_list-2_xml=00;35:*-sys-img_xml=01;31:*-addon_xml=01;36:";         #~/.android/cache
         LS_COLORS="$LS_COLORS*meta-release-lts=01;35:"; # E95M5MJR:done adding Aku:/etc && ~/.*/* but stil nd2recurse furthr l8r #~/.cache/update-manager-core
         LS_COLORS="*done_upgrades=01;31:$LS_COLORS";                                                                             #~/.co*/compiz-1/compizconfig
         LS_COLORS="*bookmarks=00;33:$LS_COLORS";                                                                                 #~/.config/gtk-3.0
         LS_COLORS="$LS_COLORS*desktop-metadata=01;31:";                                                                          #~/.config/nautilus
         LS_COLORS="$LS_COLORS*hooks_seen=01;35:";                                                                                #~/.config/update-notifier
         LS_COLORS="$LS_COLORS*.converted-launchers=01;33:*-data-convert=01;36:*_migration-ubuntu=01;35:";                        #~/.local/share
         LS_COLORS="$LS_COLORS*-default-sink=01;33:*-default-source=01;36:";                                                      #~/.pulse
         LS_COLORS="*config=01;33:*config~=00;31:*known_hosts=01;31:*history=01;35:$LS_COLORS"; # prEpNdng thEse2!clobr l8r .XtNz #~/.(mplayer|schism|ssh|w3m)
         LS_COLORS="*Metadata=00;31:$LS_COLORS";                                                                                  #~/.cpan (binary file?)
         LS_COLORS="*Makefile=01;32:*INSTALL=01;36:*MANIFEST=01;33:*AUTHORS=01;36:*CHANGELOG=01;33:*LICENSE=01;37:$LS_COLORS";    #~/.inst/(youtube-dl|perl*)
         LS_COLORS="*makefile=01;35:*installhtml=01;35:*Artistic=01;37:*Changes=00;33:*Copying=01;37:$LS_COLORS"; #`lsd8`duz gout #~/.inst/perl-5.8.8
#xport   LS_COLORS="abi-3.*-generic=01;31:config-3.*-generic=00;33:initrd.img-3.*-generic=01;33:System.map-3.*-generic=01;32:vmlinuz-3.*-generic=01;36:$LS_COLORS"; # /boot spec from both endz is unparsable && just front end duz!wrk; ECKL6HM1:below the Linux kernel version numbers as p@rnzR ROYG CBMP newest to oldest;
#        LS_COLORS="*-3.16.0-29-generic=01;31:*-3.16.0-28-generic=00;33:*-3.16.0-25-generic=01;33:*-3.13.0-39-generic=01;32:$LS_COLORS";  # /boot altern8 versN
#        LS_COLORS="*-3.11.0-19-generic=01;36:*-3.8.0-33-generic=01;34:*-3.5.0-36-generic=01;35:*-3.2.0-35-generic=00;35:$LS_COLORS";     #   && oldrfrom ChunW # F1ELGnuL:ROYG CBMP => 1;3[1o32 645p] thEse lInz should evN2LE get gNR8d from `ls /boot`; I98M89I9:rEsortd2XplicitNtrEzB4quStnz sinc wrkin lsd8 but!nrml `ls`;
         LS_COLORS="$LS_COLORS*.png.=0;35;45:*.Hrc.=0;30:*.ls.=0;34;44:*.log.=0;32:*.kdb.=0;30;40:*.txt.=0;36:"; # somemainXtraz  # gNrl  # .?mkbgkc prvz m b k
         LS_COLORS="$LS_COLORS*-interface-security=01;31:*-shim-state=01;36:*.?.=0;36:*.??.=0;34:*.???.=0;30:*.????.=0;32:";      # /run  # .?. cbkg prvz
export   LS_COLORS="$LS_COLORS*.serverauth.???=00;32:*.serverauth.????=00;31:*.serverauth.?????=00;35:*.goutputstream-??????=00;31:"; #*.gout*-? duz!wrk4 `ls`;
export GREP_COLORS="mt=01;34"; bindkey -v; #`bindkey -e`setzEmacs-stylCmdLynEdtng; -v hazBn betRsofR4mE,butdu!4getEmaxAtaxBax; #rEmMbr"^foo^bar"subst prEv cmd;
alias  grp='  grep --color=auto'; # want grep --color=auto all za tym2(&&mayB`dircolrz ~/.gprc`?)&&2hv -nubTHZ?fulnSwi:Hedrfylnmz,lyNumZeroUnixTabalyndBytofstz
alias fgrep='fgrep --color=auto'; #   ...also fgrep ndz auto2,wud B cool 2 mk perl grep from grepp&&sarep 2 auto colr multiple m@chz difrNtly;
alias egrep='egrep --color=auto'; #   ...also egrep  # UbuTip:"Edit the command line with cut and paste: ctrl-k for cut, and ctrl-y for paste." prolyOnly4Emacs
alias  gpnt=' grp  -nubTH';alias gpnz='gpnt -Z'; # nd2tst4nmspc cOlIdz of`gpn?`&&stuD`(perl|xargs) -0`,`(sort|grep) -z`;
# from`man grep`:".*Uzd wiCmdz lyk:`find -print0`,`perl -0`,`sort -z`,&&`xargs -0` 2procRbitrarEfylnamz,EvNthoz contNngNwLnz(azNulTrmN8dCstylStrzNstdOvNwLn).";
if     [   -z  "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then   # set variable IdNtifyng the chroot U wrk in (Used in prmpt bElO)
  debian_chroot=$(cat                         /etc/debian_chroot) ;   fi
# OldeBashStylPrmt:   PS1='%{[1;33m%}[%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}%m%{[1;31m%}`pt`%{[1;34m%}%~%{[1;33m%}]%{[1;32m%}%(!.#.$) ';
# NewZshStlPmt:export PS1='%{[1;33m%}%[%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}%m%{[1;31m%}`pt`%{[1;34m%}%~%{[1;33m%}]%{[0;33m%}%(!.#.$)%{[1;32m%}';
#xport PS1='%{[1;33m%}%(!.<.[)%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}$HHst%{[1;31m%}`pt -cp`%{[1;34m%}%~%{[1;33m%}%(!.>.])%{[1;32m%}';
#xport PS1='[1;37m%(!.<.[)[1;33m%n[1;34m@[1;35m$HHst`d8 -a`[1;34m`c8fn $PWD`[1;37m%(!.>.])[1;32m'; # aparNtly -z && all %{ %} nEded4CLIwidtcalQl8
#xport PS1='%{[1;37m%}%(!.<.[)%{[1;33m%}%n%{[1;34m%}@%{[1;35m%}$HHst`d8 -z`%{[1;34m%}%~%{[1;37m%}%(!.>.])%{[1;32m%}'; # F1PLEswI:s/%~/c8fn/;
export PS1='%{[1;37m%}%(!.<.[)%{[1;32m%}%n%{[1;34m%}@%{[1;36m%}$HHst`d8 -z`%{[1;34m%}`c8fn -z $PWD`%{[1;37m%}%(!.>.])%{[1;32m%}';
alias np="export PS1='%{[1;33m%}%(!.<.[)%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}$HHst%{[1;31m%}\`d8 -z\`%{[1;34m%}%~%{[1;33m%}%(!.>.])%{[1;32m%}'";
alias dp="export PS1='%{[1;37m%}%(!.<.[)%{[1;32m%}%n%{[1;34m%}@%{[1;36m%}$HHst\`d8 -z\`%{[1;34m%}\`c8fn -z $PWD\`%{[1;37m%}%(!.>.])%{[1;32m%}'";
#case "$TERM" in xterm*|rxvt*) # if this is an xterm set the title to user@host:dir
#      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";; # also setz windO tItl2 Uzr@hOst:dir
#  *) ;; esac  # similR wA2du BlO is `p h p$PPID o cmd` prntz '/bin/login --' on console&& '/usr/lib/gnome-terminal/gnome-terminal-server' in an X.Org GnomTerm
# From HTTP://StackOverFlow.Com/questions/17814123/determining-the-type-of-terminal-classic-unix-terminal-vs-graphical-terminal it might be better to do:
#parent=$(ps --pid $(ps --pid $$ --no-headers --format ppid) --no-headers --format cmd); # might need2 s/cmd/comm/ 2ch 4m@ prOfIl for result to =~ /^login/
#if [[ $parent == login* ]]; then ... else ... fi to detect a full-screen console login rather than cking for graphical $TERM, although $TTY might be easier?
# I71M8PS1:2du mAB rewrite sp,np,dp 2B ps1 varE8ionz && basicz wi no Perl DpNdNCz to calm warnz,mAB try2zsh regX colr pwd&&gNr8 aprox colrd d8stampz2 4comp@;
export HISTFILE=~/.zsh_history;alias sp="export PS1='%(!.<.[)%n@$HHst:\`d8\`:%~%(!.>.])'"; #Prmptz:SimplPrmt||NormlPrmt Uzd2hvBigPrmt2but ch eq2Norm soIrmd;
export HISTSIZE=4096;export BdOn="tput smso";export Bond='BdOn';alias setfp='etfp -s'; #from`man tput`:BoldOn&&Off TermSeQNcz4:`echo "${BdOn}NtrNm:${BdOf}\c"`
export SAVEHIST=4096;export BdOf="tput rmso";export Bofd='BdOf';alias setf='setfp -f';alias setf0='setf -o';alias setp='setfp -p'; # mk .?ttyrc 2gN folOing
if       [[ "$HUsr"     !=  "root"  ]];                                  then #export PipzTmpC='~/lib/Octology/f8/f0nt/psf'; #fpal -x -l ~/dvl/f8/*/*/font';
  # hopefully just these 8 regexes will work the same instead of the tons of old if or from before; TIGS dRkz(red|cyn|mag) RbrItr than Tigz (4 vim st@usln?)
  # check for files being executable or existing before invoking; don't want normal pal8 details printed out at shell init so ENV flag 2B Quiet
  # 2du:put all pal8 && f0nt file basenames in variables && confirm executable or readable before invoking;
  export Hpal8dir="$HOME/lib/Octology/f8/pal8"         ;  export Hf0ntdir="$HOME/lib/Octology/f8/f0nt/psf"     ;
  export Hpal8ts1='TIGSfAVS';export Hpal8ts5='Decent'  ;  export Hf0ntts1='standrd0';export Hf0ntts5='cALLIGRA';
  export Hpal8ts2='sILLY'   ;export Hpal8ts6='Bepspurp';  export Hf0ntts2='tEKtItE' ;export Hf0ntts6='FUTURa-1';
  export Hpal8ts3='gOOFY'   ;export Hpal8ts7='bLUES'   ;  export Hf0ntts3='mED'     ;export Hf0ntts7='ANTIqUE' ;
  export Hpal8ts4='nICE'    ;export Hpal8ts8='yEL'     ;  export Hf0ntts4='rOMAN3'  ;export Hf0ntts8='Modern-2';
  if     [[  $TTY  =~ ^/dev/(tty|pts/)(1|9|17|25|33|41|49|57)$  ]] && [[ -x "$Hpal8dir/$Hpal8ts1.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts1.pal8;
  elif   [[  $TTY  =~ ^/dev/(tty|pts/)(2|10|18|26|34|42|50|58)$ ]] && [[ -x "$Hpal8dir/$Hpal8ts2.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts2.pal8;
  elif   [[  $TTY  =~ ^/dev/(tty|pts/)(3|11|19|27|35|43|51|59)$ ]] && [[ -x "$Hpal8dir/$Hpal8ts3.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts3.pal8;
  elif   [[  $TTY  =~ ^/dev/(tty|pts/)(4|12|20|28|36|44|52|60)$ ]] && [[ -x "$Hpal8dir/$Hpal8ts4.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts4.pal8;
  elif   [[  $TTY  =~ ^/dev/(tty|pts/)(5|13|21|29|37|45|53|61)$ ]] && [[ -x "$Hpal8dir/$Hpal8ts5.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts5.pal8;
  elif   [[  $TTY  =~ ^/dev/(tty|pts/)(6|14|22|30|38|46|54|62)$ ]] && [[ -x "$Hpal8dir/$Hpal8ts6.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts6.pal8;
  elif   [[  $TTY  =~ ^/dev/(tty|pts/)(7|15|23|31|39|47|55|63)$ ]] && [[ -x "$Hpal8dir/$Hpal8ts7.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts7.pal8;
  elif   [[  $TTY  =~ ^/dev/(tty|pts/)(8|16|24|32|40|48|56|64)$ ]] && [[ -x "$Hpal8dir/$Hpal8ts8.pal8" ]]; then Pal8Qiet='1' $Hpal8dir/$Hpal8ts8.pal8;
  fi; # 8unUsed pal8 fIlz aftr abov: cORRI DARKpRIM dARKZ deepRed Flipped r Tigzfavz t
  if     [[ "$DISPLAY" ==        "" ]] && [[ "$TERM" == "linux" ]]; then # orig had PipzGlobalf8Flag 2!redo but!DISPLAY also4ssh so $TERM "linux" 4console
    # no more old Gen /dev/vc/\d+ && curNtly only /dev/tty[1-24] (orig1-6) active anyway && old pts/ which was left in to align with above could match
    #   && fail the IO call when sshing from Chun console to Aku, so replaced it with "tty/", which is now aligned altern8ion which should never match
    # maybe setfont betr than setf etfp as proly able 2 handle more PSF varE8ionz l8r?                              setfont also should work fine below
    if   [[  $TTY  =~ ^/dev/(tty|tty/)(1|9|17|25|33|41|49|57)$  ]] && [[ -r "$Hf0ntdir/$Hf0ntts1.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts1.psf;
    elif [[  $TTY  =~ ^/dev/(tty|tty/)(2|10|18|26|34|42|50|58)$ ]] && [[ -r "$Hf0ntdir/$Hf0ntts2.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts2.psf;
    elif [[  $TTY  =~ ^/dev/(tty|tty/)(3|11|19|27|35|43|51|59)$ ]] && [[ -r "$Hf0ntdir/$Hf0ntts3.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts3.psf;
    elif [[  $TTY  =~ ^/dev/(tty|tty/)(4|12|20|28|36|44|52|60)$ ]] && [[ -r "$Hf0ntdir/$Hf0ntts4.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts4.psf;
    elif [[  $TTY  =~ ^/dev/(tty|tty/)(5|13|21|29|37|45|53|61)$ ]] && [[ -r "$Hf0ntdir/$Hf0ntts5.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts5.psf;
    elif [[  $TTY  =~ ^/dev/(tty|tty/)(6|14|22|30|38|46|54|62)$ ]] && [[ -r "$Hf0ntdir/$Hf0ntts6.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts6.psf;
    elif [[  $TTY  =~ ^/dev/(tty|tty/)(7|15|23|31|39|47|55|63)$ ]] && [[ -r "$Hf0ntdir/$Hf0ntts7.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts7.psf;
    elif [[  $TTY  =~ ^/dev/(tty|tty/)(8|16|24|32|40|48|56|64)$ ]] && [[ -r "$Hf0ntdir/$Hf0ntts8.psf"  ]]; then     setf     $Hf0ntdir/$Hf0ntts8.psf;
    fi; # maybe psf fonts should be set in /etc/init.d/consolechars through /etc/default/console-setup even sooner
    if   [[ `which curs` != '' ]]; then curs; fi; # need curs again down here for consoles not to have just default underline
  fi; # Ryu was Old until `pmei Curses` or fpal didn't require curses to wrap etfp; RyuOld && Gen used to use the following on /dev/(tty|vc/)\d+:
      #   3/15 HyLAS      6/18 mED          9/21 france9     12/24 futura-2    # 3/15 hylas also had etfp A172 F177; mkng 2 brItz dRk proly 4 lowcontrast prym
      #   4/16 FRESNo     7/19 cALLIGRA    10/22 ANTIqUE     13    CRAKRjAK    # orig filenames were all lowercase since it was prior to .Hrc renaming 4 keyz
      #   5/17 ZanZurf    8/20 rOMAN3      11/23 bROADWAY
fi; # ls.*? -1:OnlE1FyLynz($_\n);clasiFy(dir/,symlnk@,exefyl*,etc);QuotRsltnzFylNmz(2sealSpcz&&othrDynabiliTBhynd lit txt);Long(shoXact byte fylsizes);
alias lsQ=' ls -Q ';alias l1=' ls -1';alias  lQ1=' lQ -1 ';alias l1Q='  lQ1 ';alias lF1='lF -1';alias l1F='lF1';alias ls1='l1'; #Human readable approx fylsyz;
alias  lsF='ls -vF';alias lL=' ls -l';alias   lFl=' lF -l';alias  llF='  lFl';alias lQl='lQ -l';alias llQ='lQl';alias ll='lFl'; #!?"proly adng 1A|StekSauc"?!;
alias  lQF='  lsQF';alias  lFQ=' lQF';alias lsQF=' lQ  -F';alias lsFQ='lsQF ';alias lsgdf='ls --group-directories-first';alias lsv='ls -v';alias lv='lsv -l';
alias   lF='   lsF';alias lh=' ll -h';alias   lFh=' lh -F';alias lhF='   lFh';alias lfh='lFh';alias lhf='lhF'; #-v in base lsF natural sort of Version numbers
alias  lQ='   lsQ ';alias lr=' ls -r';alias  lQh=' lh -Q ';alias  lhQ=' lQh ';alias lqh='lQh';alias lhq='lhQ'; # rm lsrc BlO&&mk lsrc Utl2gN .lsrc from nw.lrc
alias ll='  ls -lF      ';alias lh='  ll -h       ';alias l='lsd8';alias lst='lft'; #clasiFy,Long(shoFylBytSyz),Human(rEdablSyz); l was =lh;
  alias lsd='echo "trail globz wi *(/) 4just dirz";lf-d  ';alias L='ls  -F'; # -CF -w $HWid'; # prepare to make L basic c8fn wrapper of normal ls
alias lFR=' lF -R       ';alias llR=' ll -R       ';alias lR=' l -R       ';alias lfR=' lFR ';alias lsR=' lfR '; #Recurs subdirz;Rmembr:zsh`**`auto-recursz
alias lFa=' lF -A       ';alias lla=' ll -A       ';alias la=' l -A       ';alias lfa=' lFa ';alias lsa=' lfa '; #Almostall (.*;!./||../)
alias lFb=' lF -B       ';alias llb=' ll -B       ';alias lb=' l -B       ';alias lfb=' lFb ';alias lsb=' lfb '; #omitBakupz(!*~)
alias lFrs='lF  -rS     ';alias llrs='ll -rS      ';alias lrs='l -rS      ';alias lfrs='lFrs';alias lsrs='lfrs'; #sortbyReversdSize
alias lFrx='lF  -rX     ';alias llrx='ll -rX      ';alias Lrx='l -rX      ';alias lfrx='lFrx';alias lsrx='lfrx'; #sortbyReversdXtension #D92MCBuZ:`md lrx`prob
alias lFrc='lF  -rct    ';alias llrc='ll -rct     ';alias Lrc='l -rct     ';alias lfrc='lFrc';alias Lsrc='lfrc'; #sortbyReversdChngdTime(frstmodtym)
alias lFc=' lF   -ct    ';alias llc=' ll  -ct     ';alias lct='l  -ct     ';alias lfc=' lFc ';alias lsc=' lfc '; #sortby       ChngdTime(lastmodtym)
alias lFx=' lF   -X     ';alias llx=' ll  -X      ';alias lx=' l  -X      ';alias lfx=' lFx ';alias lsx=' lfx '; #sortby       Xtension
alias lFs=' lF   -S     ';alias lls=' ll  -S      ';alias l-s='l  -S      ';alias lfs=' lFs ';alias lss=' lfs '; #sortby       Size
alias lF-d='lF  -d      ';alias ll-d='ll  -d      ';alias l-d='l  -d      ';alias lf-d='lF-d';alias ls-d='lf-d'; #Dirz; belo shud prolyBfuncz2tst4$1 B4pikng*
alias lFd=' lF-d    *(/)';alias lld=' ll-d    *(/)';alias lD=' l-d    *(/)';alias lfd=' lFd ';alias lsD=' lfd '; #       Dirz*(/) Beppu sez:"Do*NOT*alias
alias lFid='lF-d -I=*(/)';alias llid='ll-d -I=*(/)';alias lid='l-d -I=*(/)';alias lfid='lFid';alias lsid='lfid'; #Ignore Dirz(!/)   importnt linker`ld`!"
alias lFf=' lF      *(.)';alias llf=' ll      *(.)';alias lf=' l      *(.)';alias lff=' lFf ';alias lsf=' lff '; #normal fylz*(.) Note:symlynx(@)
alias lFif='lF   -I=*(.)';alias llif='ll   -I=*(.)';alias lif='l   -I=*(.)';alias lfif='lFif';alias lsif='lfif'; #Ignore fylz(!.)
      FTym=' --full-time';alias llft="ll $FTym    ";alias lft="l $FTym    ";alias ltym='lft ';alias lftym='lft';alias ltime='lft'; #shoFulTym stampz4LongLstz
# for some reason, old ea='e a' could shell out2`bak` from ~/dvl/Utl/.bak/ but can't create .bak/ EROR from ~/.arc/Aku_-arc-full-Ubu10.04-D1KD1KD/var/log/apt/
# mAB stRting ./ as root owned  (even if not that restrictive 755 permissions) can't find way to ~/ from there? Wrap p[uo] makes sense 2rElEtRgetfromNEwher
ea(){ if [[ `dirs` != '~' ]]; then pushd ~; fi;e a; # try to quell warning "popd: directory stack empty" && not found pu or po
      if [[ `dirs` != '~' ]]; then popd   ; fi}     # Orig: alias ea='pu ~;e a;po';
alias e='      e    $TTY';alias up='        upd8  ';alias e2='pu ~/dox/2du;e 2;po';alias e3='e 3     ';alias upd8-mime-d8bs='md8';alias larv='laff; ripv';
alias e4='     e    4   ';alias e5='     e 5      ';alias e6='             e 6   ';alias e7='e 7     ';alias   e8='pu ~/dox/2du;e 8;po';alias e9='e 9';
alias bak='    bak  $TTY';alias   ept='  echo `pt`';alias upd8-mdb=' md8       ';alias upd8-md8b='md8';alias update-mime-db='md8';alias lar8='larv; updb';
alias ud='     updb     ';alias    loc8='   locate';alias mdb-upd8=' md8       ';alias md8b-upd8='md8';alias mime-db-update='md8';alias mdb8='  mdb-upd8';
alias updb='   upd8db   ';alias upd8d8ab='  upd8db';alias   updtdb='updb       ';alias md8b='mdb-upd8';alias md8='update-mime-database -V';
alias rc8=' rc-upd8     ';alias rc-upd8='rc-update';alias etc-upd8='etc-update ';alias etc8='etc-upd8';alias env8='env-upd8';alias  env-upd8='env-update';
alias pl8=' pl-upd8     ';alias pl-upd8='plcl     ';alias plcl='pl-clnr     all';alias pl8c='pl8     ';alias pl8l='pl8     ';
alias lp8=' lp-upd8     ';alias lp-upd8='lpcl     ';alias lpcl='pl-clnr libperl';alias lp8c='lp8     ';alias lp8l='lp8     ';
alias pl8a='pl-clnr  all';alias pl-clnr='pl-clean ';alias pl-clean='pl-cleaner ';alias pl-cleaner='  perl-cleaner  ask     ';
alias py8=' py-upd8     ';alias py-upd8='py-upd8r ';alias py-upd8r='py-updater ';alias py-updater='python-updater -p -v -v '; # -pretend -VeryVerbose
alias laff='     lafilefixer --justfixit'; # UzflUtlz:glsa-ck -[pf](new|all);rvdp-rbld -ipv;pl-clnr(libperl|all)ask;py-upd8r -pv(-dm)?;lafilefixer --justfixit;
alias glck='     glsa-check   -v';alias gcpn='glck -p new';alias gcfn='glck -f  new';alias glsack='glck';alias  py8d='py8  -dm'; # -disable-manual CHECK flagz
alias rdrb='   revdep-rebuild -v';alias rri='rdrb -i';alias rripvv='rri -pv';alias ripv=' rrip  ';alias rrvv='rr -v'; # Ignor-cach,Pretnd-emrg,VeryVerbose?
alias rrip='     rri          -p';alias rrk='rdrb -k';alias rriv='  rri -v ';alias rripv='rri -p';alias rrivv='rrvv'; #   && handy ShrtCutz; Keep-cache(rrk)
alias rrkp='     rrk          -p';alias rrp='rdrb -p';alias rrkv='  rrk -v ';alias rrkpv='rrk -p';alias rrkvv='rrkv'; #ias rr='rri'; #       PretndEmrg(rrp)
# might want to install HTTPS://GitHub.Com/ggreer/the_silver_searcher with ag awk-grep replacement instead of relying on old familiar apt-get aliases here
alias ag='apt-get  ';alias agi='ag install';alias agu='ag update';alias aguu='agu;ag upgrade'; # Debian && Ubuntu apt shortcuts  # agdu BlO nEdz v sources.list
alias ac='apt-cache';alias acs='ac  search';alias agr='ag remove';alias agrm='agr';alias agar='ag autoremove';alias agdu='ag dist-upgrade'; # thN aguu B4hand
alias ai='apt                      install';alias au='apt update';alias  auu='au;apt upgrade';alias acsp=' ac showpkg'; # show package details
alias apts='apt search';alias asrch='apts';alias aar='apt autoremove'; # alreD /usr/bin/as GNU ASsembler,shud rEd wut Ls apt(itude)? do betr than ag 2add here
alias emrg='     echo "emrg justAbrvz: emerge Try em 4shrtDfltOptz"; emerge';alias em='   emu   '; # fav emrg dfaltz:--colmz -va --kp-go -Du (+-N 4sys|wrld)
alias emcol='emerge --columns -v';alias eM='em     -v' # --columns vert-alinz pkg-name,vers,use-flagz       (-v == --verbose      )
alias emrga='    emcol  -a';alias emrge='   emrga  -e' # --ask                                              (-e == --emptytree    ) (eg,wrld4UsrModeLnux)
alias emrgk='emrga  --keep-going';alias eN='em     -N' # --ask --keep-going was my preferred emrg dflt optz (-i == --info         )
alias emrgd='    emrgD    ';alias emrgD='   emrgk  -D' # --ask --keep-going --Deep          => -aD  --kp-go (-d == --debug        )
alias emrgu='    emrgD  -u';alias emrg1='   emrga  -1' # --ask --keep-going --Deep --update => -auD --kp-go (-1 == --oneshot [+-a])
alias emrgsys='  eN system';alias emrgwrld='eN  world' # --ask --keep-going --Deep --update => -auD--k-g--Newuse sys && wrld
alias emrgn='    emrga  -n';alias emrgN='   emrga  -N' # --ask --noreplace                                  (-N == --Newuse  [+-a])
alias emrgo='    emrga  -o';alias emrgO='   emrga  -O' # --ask --onlydeps                                   (-O == --nOdeps  [+-a])
alias emrgs='    emerge -s';alias emrgS='   emerge -S' # --search                                           (-S == --Searchdesc   )
alias emrgp='    emerge -p';alias emrgP='   emrga  -P' # --pretend                                          (-P == --Prune   [+-a])
alias emrgc='    emerge -c';alias emrgC='   emrga  -C' # --clean                                            (-C == --unmerge [+-a])
alias emrgsync=' emerge --sync' # ... && othr useful utlz:glsa-ck -[pf] (new|all);revdep-rebld -ipv;perl-clnr (libperl|all) ask;python-upd8r -pv (-dm)?;
alias emrgupd8=' emrgsync; glsa-check -f new;    emrgsys; upd8db' # maybe this should be a nightly||weekly upd8 task scheduled b4 upd8db via cron(&&wo -ask)
alias ema='emrga';alias eme='emrge';alias emu='  emrgu  ';alias em1='   emrg1   ';alias emo='   emrgo   ';alias emO='   emrgO   ';alias emc='emrgc';
alias emd='emD  ';alias emk='emrgk';alias emsys='emrgsys';alias emwrld='emrgwrld';alias emsync='emrgsync';alias emupd8='emrgupd8';alias emC='emrgC';
alias emD='emrgD';alias emn='emrgn';alias emN='  emrgN  ';alias ems='   emrgs   ';alias emS='   emrgS   ';alias emp='   emrgp   ';alias emP='emrgP';
alias ChRootGen2LiveCD='mount /dev/sda3 /mnt/gentoo;mount /dev/sda1 /mnt/gentoo/boot;mount -t proc none /mnt/gentoo/proc;mount -o bind /dev /mnt/gentoo/dev;chroot /mnt/gentoo /bin/bash;env-update;source /etc/profile;export PS1="(ChRoot)$PS1"'; # A85AfWf: trying to get Akuma 2boot wi anythng othr than GenKrnlz is pain!
alias mknwkrnl='MkNwKrnl';alias mkmnucfg='mkMnuCfg      ';alias mkMnuCfg='mk menuconfig';alias mkModIns='    mk modules_install ';alias mkmodins='mkModIns';
alias MkNwKrnl='echo "em gen2-srcz;/usr/src/linux;mkMnuCfg;mk;mkModIns;bak.cfg;cp arch/x86_64/boot/bzImage /boot;cpS.map2/boot/smap;cnfGRUB;reboot"';
#En= [nN] -a[nN]      #-ask-noreplace(|Newuse)    #Esync=   --sync       #&&helpfulUtlz:glsa-ck -[pf] (new|all);revdep-rebld -vv;perl-clnr (libperl|all) ask`
#ED= [Dd] -an[Dd]     #-ask-noreplc-Deep(|debug)  #ESorW=auD system|world#-ask-update-Deep(Sys|Wrld)
#Ei=v[i1] -av1?--info?#-ask-verbose-info(|oneshot)#Eupd8=   --sync;glsa-check -f new;emerge -uD system;updatedb' # cron.(night|week)ly upd8 task2go b4upd8db?
#Eo= [oO] -a[oO]      #-ask-onlydeps(|nOdeps)     #Es=  [sS] -[sS]       #-search(deSc) #Ee= e   -ae        #-ask-emptytree(eg,wrld4UsrModeLnux)
#Ec= [cC] -[cC]       #-clean(|Clip|Cut|ChopUMrg!)#Ep=  [pP] -[pP]       #-pretend(|Prune!) -vp --depclean best2dpndntlyAware rmPkgz(prtndng1st)
alias vimuse='vim /usr/portage/profiles/use.desc /etc/make.conf /usr/portage/profiles/use.local.desc /etc/portage/package.use   /etc/portage/package.keywords';
alias vimUz=' vimuse                                                                                 /etc/portage/package.*mask /etc/portage/color.map';
#lias scp='noglob scp'; # still want to glob locally so just intentionally escape remote globs wi \* etc; #Rot13perLyn:`vim $fyl`Vg?
alias              ..='cd ..                 ';alias cdup='..';alias cd..='..                      ';
alias             ...='cd ../..                              ';alias cd...='...                    ';
alias            ....='cd ../../..                           ';alias cd....='....                  ';
alias           .....='cd ../../../..                        ';alias cd.....='.....                ';
alias          ......='cd ../../../../..                     ';alias cd......='......              ';
alias         .......='cd ../../../../../..                  ';alias cd.......='.......            ';
alias        ........='cd ../../../../../../..               ';alias cd........='........          ';
alias       .........='cd ../../../../../../../..            ';alias cd.........='.........        ';
alias      ..........='cd ../../../../../../../../..         ';alias cd..........='..........      ';
alias     ...........='cd ../../../../../../../../../..      ';alias cd...........='...........    ';
alias    ............='cd ../../../../../../../../../../..   ';alias cd............='............  ';
alias   .............='cd ../../../../../../../../../../../..';alias cd.............='.............';
alias      mk='   make'; # following are my main super-terse aliases for performing almost every core GNU/Linux system utility (with some inherited from DOS)
alias      sz='   sudo -E zsh';alias SS='sudo shutdown -h now'; # possible emergency Sudo Shutdown now!
alias      pu='  pushd';alias  ua='un    '; # just add a couple basic abbreV8ions for sys-info
alias      po='   popd';alias una='un -a ';
alias      pe='   perl -MOctology::a8 -pe'; # setup Perl Eval filter easy to give a 's///' after
alias      pa='   perl -MOctology::a8  -e'; # setup Perl eval        with Attribute Auto-export globals of A8
alias     pla='   pa  '; # pb is already taken by pingb
alias     plb='   perl -MOctology::b8  -e'; # setup PerL eval        with Base-transl8   export globals of B8
alias     pab='   perl -MOctology::a8 -MOctology::b8  -e'; # Perl eval with A8  &&  B8   exports together like `pab "b8colr(b64(calQ('4096xx2048')))"`
alias    pabd='   perl -MOctology::a8 -MOctology::b8 -MOctology::d8  -e'; # Perl eval with A8 && B8 && D8 (although d8 mainly crE8s new objects, not exports)
alias     pep='   perl -MOctology::a8 -MOctology::b8 -MOctology::d8 -pe'; # Perl Eval with A8 && B8 && D8 for Piping filtr8ion
alias      gg='   perl ~/dvl/d8/bin/gg   '; # basic perl call to priv8 non-executable development utility to Gener8 G-mail stamps for Gerry (my Dad)
alias    drkh='   pa  "print drkh(@ARGV)"'; # HEX to RgbL with 8th intensities
#lias    h2rl='   pa  "print h2rl(@ARGV)"'; # HEX to RgbLowbitz    # actually trying to reform these alias wrappers to standalone usable new ~/bin page2 utlz
#lias    rl2h='   pa  "print rl2h(@ARGV)"'; #        RgbLowbitz to HEX
#lias    fctz='   plb "      fctz(@ARGV)"';
#lias    fibz='   plb "      fibz(@ARGV)"';
#lias    prmz='   plb "      prmz(@ARGV)"';
#lias    sumz='   plb "      sumz(@ARGV)"'; # printing these was just yielding an extra 1 at each end, after they printed output themselves instead of returnd
alias      dv='   dirs -v';
alias    dirz='   dirs -p|perl -pe "\$_ = \$. - 1 . q. . . \$_"'; # sho lynz
alias     d2u='   dm2u   ';
alias     u2d='   dm2u  d';
alias     del='     rm';
alias    copy='     cp';
alias    move='     mv';
alias  attrib='   echo "Try chmod instead! ;) "'; # just print advice for this, since calling semantics are so different
#lias    mutt='   mutt; ~/lib/Octology/f8/pal8/TIGSfAVS.pal8'; # mutt clears pal8 colors so at least restore favor8s afterward
# Many of these Octology aliases should become special V8 via c8 coloriz8ion command wrappers or otherwise enhanced (&& simplified?) && unified funcs or cmdz:
alias       0='echo 0 '; #       : # figure out good aliases for remaining numbers
alias       1=' mpg321'; # m 321 :                audio-player
alias       2=' mpg123'; # m 123 :                audio-player
alias       3='   g3  '; #  g3   :         gst123 audio-player wrapped with Expect manipul8ion layer
alias       4='en   4 '; #       :
alias       5='ec   5 '; #       :
alias       6='en   6 '; #       :
alias       7='ec   7 '; #       :
alias       9='en   9 '; #       :
alias       A='   a   ';
alias       a='   asci'; #  a    :           asci
alias    asci='   UTF8'; #       :                (renamed in U8 && bin)
alias    utf8='   UTF8';
alias      u8='   utf8';
alias       B='   b   ';
alias       b='   bk  '; #  b    :             bk
alias      bk='   bak '; # bk    :            bak            (orig Pip:Utl file backup command)  # for wc BlO,suport`dd --help`like printf style size formats
alias     cls='  clear'; #  cls  :          clear (like DOS command for CLearScreen)
alias       C='  cls  '; #  C    :B4 clear was wc (Count charz,words,&&lines&&eventually bits,bytes,[KMGTPEZY]i?bits|Bytes,code points,paragraphs,subs,etc.)
alias      CC='  cd;C '; #       :                (combines Change directory back2 home ~ && then Clear screen,pretty easy2type 1-handed but Enter is a reach)
alias     CCC='CC;en -e "\e[3J"' ; # special super Clear of scrollback too (goodaftr `kp` along wi xx 2clear paste buffers);CSI n J - ED(Erase in Display)
alias    dusb=' du -sb'; #  du   :             du|df|dfc     (Disk usage, free, etc.) with -sb to Summarize (only total4each arg) with block-size Bytes
alias     dus=' dusb  '; #                        it's often pretty useful to pipe the raw decimal size Summary in Bytes in2 `cma` 4isol8ing Thou,Mill,Bill...z
alias      ds=' dus   '; #                        might be nice to l8r offer parameter options to `b64` && `b256` to only oper8 on 1st decimal field(lIk `cma`)
alias     dub=' dusb  ';                        # maybe EvN2ally `dub` shudB realloc8d as somehow rel8d 2gr8 Obsidia|PegBoardNerds|Tristam|TutTut Dubstep mUzic
alias      db=' dub   ';                        # maybe EvN2ally `db`  shudB realloc8d as somehow rel8d 2 d8a-base (PostGreSQL?) queries, manipUl8ion,&& mngmNt
# no longer just d aliasing du above since better to apply to ~/bin/dic (my colorful enhanced `dict` wrapper, like piping thru `colorit`) since I Use it fR mor
alias       F='   f   ';
alias       f='   find'; #  f    :           find            (with combined interface to loc8?)
alias       g='   grp '; #  g    :          sarep|(e|f)?grep (sed|awk too?)
alias      gi='   g -i'; #                              grep -i to      Ignore_case
alias      gv='   g -v'; #                              grep -v to                     inVert_match_results
alias     giv='  gi -v'; #                              grep    to both Ignore_case && inVert_match_results
alias    gadd='  gi "^ *[a-z8]*8[a-z8]* *[:#].* add.*8" ~/dox/2du/8.txt'; # early varE8ion which didn't require pound after colon,like Blow expecting both l8r
alias    gad8='  gi "^ *[a-z8]*8[a-z8]* *:.*#.* add.*8" ~/dox/2du/8.txt'; # utility alias to grep 8.txt for all comments describing potential words to add l8r
alias     gad='  gad8 '; # while the above 2 originally differed into more restricted result count, material text has been upd8d such that they match on I98
alias      eg='  egrep'; # eg    :                 e    grep
alias      zg='  zgrep'; # zg    :                     zgrep (like zcat for *.gz)      # below heX aliasing must get decimal input piped thru, can't du pRam
alias       G='  zg   ';                        # (if hX duz!wrk BlO,try`HEX|perl -pe 'lc'`or shL func.Note:had2unalias lc ls -ct ChngTime 2mk tr 4lowr&&uc.)
alias     heX='HEX|lc '; #  heX  :            heX (shouldbe rel8ively equivalent 2old ~/bin/heX of Octology::b8->heX() 2turn decimal input in2 lowercase heX)
alias      hX='heX    '; #   hX  :              # (just more terse varE8ion with same pronunC8ion for lowercase  heX ) # might want to sepR8 implement8ions?
alias       H='  htop '; #       :       "H"  8sh (should EvN2ally be custom Octology shell instead of just UpperCase administr8ion access2 htop diagnostics)
alias       h='history'; #  h    :        history (built-in in zsh && probably needs to be built-in for 8sh too)
alias       I='   i   ';
alias       i='   info'; #  i    :           info
alias       J='   j   ';
alias       j='   jobs'; #  j    :           jobs (shell-built-in)
alias       k='kill   '; #  k    :           kill (maybe kill is too risky to abbreV8 this tersely?)
alias      ka='killall'; #  ka   :           killall
alias      k9='k -9   '; #  k -9 :           kill with -9 force
alias       K='k9     ';
alias       M='   m   ';
alias       m='   mn  '; #  m    :            man (mn() already zsh function below, but may soon extract to preserve parameter history like d8:dic)
alias       P='   pal8'; #  P    :           pal8 terminal color setting utility from my Octology::f8 module ("f8ful 0per8ion" for handling f0nt && pal8 d8a)
alias       p='   CCC '; #  p    :            CCC (p used to be just 'ps' "Process Snapshot" but remapped to super Clear from above for easy one-hand entry)
alias      pp='pu;p;po'; #  pp   :       prepriv8 (same as single p for CCC cd,clear,cut scrollback but wrapped with pushd && popd aliases to undo the cd ~)
alias       pl='  perl'; #  pl   :           perl
alias       T='   tee '; #  tee  :            tee (maybe can wrap into c8 with cut,cat,colored columns?); rEmMbr standRd `tr -d ...` is transl8 DlEt like subS
alias       t='   tmux'; #  tmux :           tmux|screen ... any other altern8ive multiplexers forked out there? (orig:  `tsgr b` shO xtrm256colr pal8 Blox)
alias       x='   exit'; #  x    :           exit
alias      lS='   less'; #  lS   :           less
alias      mo='   most'; #  mo   :           most|more
alias      md='  mkdir'; #  md   :          mkdir
alias      rd='  rmdir'; #  rd   :          rmdir
alias      dm='  dmesg'; #  dm   :          dmesg
alias     mnt='  mount'; #  mnt  :          mount
alias    umnt=' umount'; # umnt  :         umount
alias     chm=' chmod '; #  chm  :          chmod
alias     cho=' chown '; #  cho  :          chown
alias     chg=' chgrp '; #  chg  :          chgrp
alias     chr=' chroot'; #  chr  :          chroot
alias     chs=' chsh  '; #  chs  :          chsh  (follow with -s SHELL to autom8, or get interactive prompting without)
alias     chf=' chfn  '; #  chf  :          chfn  (changes user FullName, office room number, office phone number, && home phone number)
alias     cht=' chti  '; #  cht  :          chti  (changes terminal window title)
alias      ct=' cht   ';
#          mc() already zsh function below
#lias      mc='  md;cd'; #  mc   :          md+cd (make sure to override MidnightCommander if found)
#          c8   already ~/bin/
#lias      c8='cut|cat'; #  c8   :        cut|cat (with columnar alignment, coloring, && command matching..)
alias      zc='   zcat';
alias       Z='   zc  ';
#lias      f8='   f80p'; #pal8   : should eventually be CLI && powerful interactive f0nt && pal8 selector && editor
alias      fp='     ls       ~/lib/Octology/f8/*   '; # fp was fontpal => fpal => f80p but none are presently functional
alias      f8f='    ls       ~/lib/Octology/f8/f0nt';alias lsf0nt='f8f'; # eventually these should switch to f8 cmdz
alias      f8p='    ls       ~/lib/Octology/f8/pal8';alias lspal8='f8p';
alias   fixfont=' etfp -s -f ~/lib/Octology/f8/f0nt/psf/rOMAN3.psf';  # these hopefully restore usable f0nts to full-screen console (or 8trm also eventually)
alias resetfont=' etfp -s -f ~/lib/Octology/f8/f0nt/psf/france9.psf'; # these maybe should be `setfont` instead of `etfp` for more reliable compatibility
alias      s8n='    s8 -n'; # "Prince of Darkness"  game eventually? or just simple Numeric Sorting alias until then
alias      s8='   sort'; #  s8   :           sort (maybe eventually a collection of my own custom sortings for orders beyond the default `sort` offerings)
#          d8   already ~/bin/
#lias      d8='   date'; #  d8   :           date|time|pt
#          g8   already ~/bin/
#lias      g8='    git'; #  g8   :            git (was my much earlier attempt at wrapping to handle abbreV8ions && gener8 commits from .bak && vice-versa)
alias    g8st='    git status   '; # basic Octology-memorable combined rhyme 1-string altern8 way to call what should be effectively the same as: `g8 st`
alias    gaa='     git  add .* *'; # handy alias to Add All (Asterisk) changes, Commit by Message string below, then Push Origin Master (likely to GitHub)
alias    gcm='     git commit -m'; # tried to call each of these through g8 initially, but maybe -m flag wasn't passing on to git correctly so explicit now
alias    gac='     gaa; gcm     '; # should setup gcm to auto-commit basic gener8d d8-stamp message && maybe list biggest few file changes, if no mesg given
alias    gacm='    gac          '; # should maybe make as function which takes parameter or gener8d commit message then gpom with auto user Pip pRam or cnfg?
alias    gpom='    git push origin master';alias g8st8='g8st';alias g8s='g8 s';alias g8h='g8 h';alias g8l='g8 l';alias g8d='g8 d';alias g8p='g8 p';
alias       n=' ncal  ';           # above shortcuts are: status,           show,            help,            log,             diff,            pull
alias       N='  calN '; #  N    :            calN (use `rsn` ReSize4calN 171x57 to show 19-Years, 2000-2018 solidly in slightly lRgr than Dflt 160x50 size)
alias    caln='  calN ';
alias      l8='  calN '; #  l8   :            cal|cron|at|batch
alias      sl='  ln -s'; #  sl   :             ln (maybe on this, since ln usually makes SymbolicLinks?)
alias       O='  o    ';
alias       o='  orpie';
alias       Q='  calQ '; #  cl   :            calQl8|bc|dc like my old calc && symlnk cln (maybe swapping so n reverses meaning to non-default append Newline?)
alias    calq='     q '; # all lowercase too
alias    calQ='     q '; # now q is just replacing old calQ
#lias       q='  cl   '; #     q was symlinkB4g8 - simple command-line calculator in Octology::b8 with BigFloat (orig:'perl -e "print eval join q( ),@ARGV"')
alias      cl='  cln  ';
alias     cln='  calQ ';
alias       R='  r    ';
alias       V='vim.tiny';
alias    viii='vim    '; #  viii : v8 v 8     vim (lowercased Roman Numerals for 8 for my vim-style editor command name)
#lias      v8='viii   '; #  v8  changing to Xport $Hv8f B4 calling vim on it, so that it can also be used by U8:upd8
alias       8='viii   '; # might try quoting 8 or just synhilite makes it seem wrong when it will work, eventually a c8-based clone that might also perform e
alias       v='v8     '; # v8 and v might become an experimental varE8ion branch of my hopefully eventually standardized ~vim-compatible viii and 8 editor
alias     dif='vimdiff'; #  dif  :            vimdiff|diff|cmp|comm
#   (upd|loc)8  already above near e (which should eventually wrap v8?)
#lias    loc8=' locate'; #  loc8 :             locate|find # f is already find above
# F5QMGkI3:while trying2`pmei Moose`a tSt sugSted PAR::Dist having an `up` so maybe unalias this in case && ck. u && up used2alias Pip:Utl:updt B4 U8:upd8;
alias       u=' upd8  '; #  upd8 :           upd8 (U8 tool to cp dvl code into bin && lib, upd8 may eventually wrap g8 git && collabor8 2ease general sync)
alias    updt='perl -MPip::Utl -e "updt @ARGV"'; # replace old tiny ~/bin/updt with alias in case newer upd8 fails
alias    uptm=' uptime'; #  uptm :           uptime
alias     uni='   uniq'; #  uni  :           uniq
#         dic   already ~/bin/
#lias     dic='   dict'; #  dic  :           dict     (reformatted for 160 or other columns, colored, with reviewable query history in ~/.log/dic.log file)
alias       d='   dic ';
alias       D='   dfc '; #                            ("D" Used2alsOBshort4 pronunC8ion of "define" too, before realloc8ion to administr8ion DiskFreeColor)
alias       y='   yelp';
alias       Y='   y   ';
alias      zp='    tar czvf'; #zp:            tgz|tar|zip|7z (eventually inspect parameters to detect which zip to use)
alias       z='     zp';
#          uz() already function below
#lias      uz='  unzip'; #  uz   :          unzip
alias      ec='  echo '; #  ec   :           echo
alias      ee='  ec -e';
alias     en='   ec -n';
alias     ene='  en -e';
alias      ev=' evince'; #  ev   :           evince (decent PDF document reader)
alias    cncl=' cancel'; #  cncl :         cancel
alias   comma=' cma   '; #  comma:            cma (like coma inserts by 4, these insert after 3)
#lias      hd='   head'; #  hd   :           head (hd is already HexDump, which maybe should be combined (&& hd is more crucial HardDisk LVM util too?)) 
alias      tl='   tail'; #  tl   :           tail
alias      tp='    top'; #  tp   :            top|htop
alias     htp='   htop'; # htp   :                (ht is already HyperText? in /usr/bin which appears to gener8 HTML from TeX input files, but H also is htop)
#          ss() already function below
#lias      ss='    ssh'; #  ss   :            ssh
alias      wd='    pwd'; #  wd   :            pwd # eventually rep this with new b8:wd in bin like width in wdht span for f(ib|ct)z (su|pr)mz sizing pRam linz
alias      pw=' passwd'; #  pw   :         passwd
alias      pn=' ping  '; #  pn   :           ping
alias      pb=' pingb '; #  pb   :           pingb      (needed2`sz; echo net.ipv4.icmp_echo_ignore_broadcasts=0 >> /etc/sysctl.conf; sysctl -p`)
alias     ic='ifconfig'; #  ic   :       ifconfig
alias     msg='   mesg'; #  msg  :           mesg|write
alias      W=' whereis'; #  W    :                      whereis      # below replaced wh which alias with function nstd 2 avoid early pRam Xpansion
#lias      wh='which  '; #  wh   :     type|who|w|which|where|whence (like wi uptm prefix line ls of loggedin userz)  (tried whence -w for single word typez)
wh(){          which $@; } # maybe the original wh alias abov was expanding to an old Csh binary nstd of DsIrd Zsh biltin && thN alsO Xpandng pRam2or nahLswr2?
alias     lsm='  lsmod'; #  lsm  :          lsmod                    # HTTPS://Unix.StackExchange.Com/questions/85249/why-not-use-which-what-to-use-then DtAlz
alias     lsc='  lscpu'; #  lsc  :          lscpu
alias     lsp='  lspci'; #  lsp  :          lspci
alias     lsu='  lsusb'; #  lsu  :          lsusb
alias     ren=' rename'; # might take just Perl quoted regex instead of $from $to before shell fileglob to alter
alias   srchl=' source-highlight -f esc --style-file=~/.shl.style'; # hopefully EvN2ally c8 can supplant shl for file && cmd auto-reformatting && color8ion
alias    shlp=' srchl -s perl -i'; # assume source code is Perl && expect next param 2B Input source-code filename
alias     shl=' srchl         -i'; # above srchl changes from default HTML output format to ANSI escape codes && set component field color style
alias       s='   shlp'; # assume Perl since an upd8 to source-highlight seems to no longer auto-detect when input files are such code
alias      S8='   shl8'; # my primitive c8:SourceHighLight8 Utl to hopefully eventually approach functional parity with source-highlight before surpassing it
alias     sho='cd ~/gfx/sho;shot -u'; # change to typical local Octology screenshot directory && take a shot of the focUsed window (no border) in 3 seconds
alias    resp='   reso spec'; # joining like =~ /^respect/ shortcut to list resolution specific8ionz  # abovUsed2B S=shl,s=shl8 but S repurposed in a8 4 SKpz
alias    resh='   res  HD  ';alias res='reso';alias re='res'; # basic a8.pm resolution HD limit8ion (not to get confused with resoLVE or resoURCE varE8ionz)
alias    reph='re Pi|gi pi;re HD|gi hd'; # example alias isol8ing matches case-sensitively for reso && grep, but not gi, so just Pixelz in title then HighDef
alias   xical='xinput-calibrator';alias xic='xical';alias xbk='xbindkeys';alias xdt='xdotool';alias xd2='xdt'; # basic Chun touch-scrn&&X re-bind&&scrpt utlz
alias    ctor='ctorrent -e 16 -z 64'; # abov: %eval $(xdotool getmouselocation --shell); %echo $X,$Y; will override Dflt $Y bright Yellow mapping with coordz
alias     sig='signal-desktop'; # I7GMFSIG:installed HTTPS://Signal.Org on my Android phone && Aku here as likely better than Slack or Discord 4the future;
alias     p47='parsec47';alias a7='a7xpg'; # some of my favorite Kenta Cho Shmups ("Bullet Hell") in /usr/games
alias      rr='rrootage';alias tt='torus-trooper';alias tf='tumiki-fighters'; # would be gr8 to study BulletML && explor own similRly themed varE8ions someday
alias      xb='xboard';alias xbsf='xb -fcp stockfish -fUCI'; # gr8 Chess program with shortcut to top StockFish engine as FirstChessPlayer
alias    kpcl=' kpcli      --kdb=~/.kp/pswd.kdb --histfile=/dev/null --no-recycle'; # 2!stor any hist or entry changes in /Backup or "/Recycle Bin" old dfalts
alias    kp='  pu  ~/.kp;    kpc --kdb=pswd.kdb --histfile=/dev/null --no-recycle;chm 600 pswd.kdb;b pswd.kdb;po';  # alias2 kpcli-3.0 modwimor aliasz&&alInmNt
k8(){        KDBF='pswd';if [[ "$#" -gt 0 && "$1" != "" ]]; then KDBF=".$1"; fi; # if [[ $B64N =~ ^([a-zA-Z]w) ]]; then BNWH=${BNWH:s/  e    / e }; fi; # Xmpl
  if   ! [[ $KDBF =~ .kdb$  ]]; then    KDBF="${KDBF}.kdb"; #    KDBF=".${1:gs/\^./}"; orig atMpt abov was trying2 GloblStrip all anchord stRt dotz,but syntax?
    if ! [[ $KDBF =~  pswd  ]]; then    KDBF="${KDBF}."   ; fi; fi; # so now just any non-default param for d8abase name getz forced hidN prEpNded dot &&apNd2
  pu               ~/.kp; # it would just be so much simpler if shell variable regex syntax could optionally resemble Perl, but then less arcana to learn about
  if     [[       -e $KDBF  ]]; then # try to only load up whatever the default or priv8 specified file if it exists (&& should be read/writable to user alreD)
                             kpc --kdb=$KDBF    --histfile=/dev/null --no-recycle;chm 600 $KDBF   ; # might also want to chm 600 the file above before kpc too?
    if   [[ $KDBF =~  pswd  ]]; then b $KDBF; fi;     # ideally this should all behave quite similarly to just basic kp alias above && may replace it once same
  else   ec   "k8 failed to loc8 ~/.kp/$KDBF;";   fi; # should print out passed in or manipul8d file when it didn't exist where it was expected to be openable
  po;} # simply popd back to the original working directory before the default home d8abase directory was pushd added above the standard shell directory stack
alias    U='   U2b8';alias U2bk='Uk';alias u2bk='uk'; # shud l8r add 1-colm <98wId mOd&&some a8 autOcolrz 2furthr hIlIt mapngz
alias    Ukey='echo -n "m c b : togl volMute Caption Bakgr colr [ U2b-hotKey ];  Dn Up : lowr 5%vol (arowkyz) rais 5%vol;
p f n : Prevplayls toglFulsc Nextplayls (Escap=2exitf);  Lt Rt : bkwd 5secs (arowkyz) 4wrd 5secs;
j k l : bkwd10secs toglpause 4wrd10secs (Space=2pause);   , .  : bkwd 1fram (ifpausd) 4wrd 1fram;
 0-9  : jump to N *10% playbak position (Home/End=0/9);   < >  : slow down< playbkspd >up> fastr;"';
alias    ukey='echo -n  "m c b:volu Muted toglCaptn Bakgr cycl;(Home/End= 0/9 2)> 0-9 :jmp% \$n*10 plabakpos =r8io %abs; < > :slow down< plabakspd >upup fast;
j k l:bkwd 10sec toglpausd 10sec 4wrd<(Spacebar=pause2);Lt Rt:bkwd -5sec arrowkeys +5sec 4wrd; , . :bkwd -1frm whenpausd +1frm 4wrd;
p f n:Prev plals toglFulsc plals Next<(Escapkey=exitf2);Dn Up:dec% -5vol arrowkeys +5vol %inc;"';
alias    uky=' echo     "j k l:bkwd 10sec toglpausd 10sec 4wrd<(Spc=pausHmEnd0-9); 0-9 :jmp% \$n*10 plabakpos =r8io %abs;Lt Rt:bkwd -5sec +5sec 4wrd; < > :slow down< >upup fast;
p f n:Prev plals toglFulsc plals Next<(Escapekey=exitf2);m c b:volu Muted toglCaptn Bakgr cycl;Dn Up:dec% -5vol +5vol %inc; , . :bkwd -1frm +1frm 4wrd;"';
alias    Uk='  echo -en "${R}m$G c$K b${W}:${B}togl${M}vol${R}Mute${G}Caption${K}Bakgr${C}colr${Y}[${G}U2b$C-${R}hot${r}Key${Y}]${W}${M}Dn$G Up${W}:${M}lowr${C}5${Y}%${w}vol${Y}(${O}arow${r}kyz${Y})${G}rais${C}5${Y}%${w}vol
${M}p$C f$B n${W}:${M}Prev${P}pla${c}ls${B}togl${C}Fulsc${B}Next${P}pla${c}ls${Y}(${O}Esc${W}=${g}2${R}exit${C}f${Y})${W}${Y}Lt$R Rt${W}:${B}bkwd${C}5${M}secs${Y}(${O}arow${r}kyz$Y)${R}4wrd${C}5${M}secs
${B}j$M k$R l${W}:${B}bkwd${G}10${M}sec${B}togl${M}pause${R}4wrd${G}10${M}sec${Y}(${M}Spc${W}=${g}2${M}pause${Y})${W}$B ,$M .$W :${B}bkwd${O}1${c}fram${Y}(if${M}pausd${Y})${R}4wrd${O}1${c}fram
$C 0$O-${R}9$W :${Y}jump${w}to$r N${C}*${G}10${Y}%${O}play${B}bak${P}position${Y}(${C}Hm${Y}/${R}End${W}=${C}0${Y}/${R}9${Y})${W}$M <$G >$W :${r}slow${M}down<${O}play${B}bk${c}spd${G}>up${K}fastr${W};"'; # squEzdout most spaces so whole keymap now fitz 80x4 term dimNsions,c turns Captions off but!togl on,no b bkgrnd
alias    Uk2=' echo -e  "${R}m$G c$K b${W}:${R}Mute${G}Caption${K}Bkgr${Y}[${G}U2b$C-${R}hot${r}Key${Y}]$W;${M}Dn$G Up${W}:${M}lowr${C}5${Y}%${w}vol${G}rais$W;${B}j$M k$R l${W}:${B}bkwd${G}10${M}secs${R}4wrd${Y}(${M}Spc${W}=${M}K${g}2${M}paus${Y})$W;$B ,$M .$W :${B}bkwd${O}1${c}frm${Y}(${M}pausd${Y})${R}4wrd$W;
${M}p$C f$B n${W}:${M}Prv${z}ls${C}Fulsc${B}Nxt${z}ls${Y}(${O}Esc${W}=${g}2${R}exit${C}f${Y})$W;${Y}Lt$R Rt${W}:${B}bkwd${C}5${M}secs${R}4wrd$W;$C 0$O-${R}9$W :${Y}jmp${R}N${C}*${G}10${Y}%${O}pla${P}pos${Y}(${C}Hm${Y}/${R}End${W}=${C}0${Y}/${R}9${Y})$W;$M <$G >$W :${r}slo${M}<down<${O}pla${c}spd${G}>up>$W;"';
# abov try2cram Uk in2 lt 160x2 (or 113x2 4now) wi just colrz 4 mAn Keyz
alias    uk2=' echo -e  "${R}m$G c$K b${W}:${B}togl${M}vol${R}Mute${G}Caption${K}Bakgr${C}colr${Y}[${G}U2b$C-${R}hot${r}Key${Y}]$W;${M}Dn$G Up${W}:${M}lowr${C}5${Y}%${w}vol${Y}(${O}arow${r}kyz${Y})${G}rais${C}5${Y}%${w}vol$W;${B}j$M k$R l${W}:${B}bkwd${G}10${M}sec${B}togl${M}pause${R}4wrd${G}10${M}sec${Y}(${M}Spc${W}=${g}2${M}pause${Y})$W;$B ,$M .$W :${B}bkwd${O}1${c}fram${Y}(if${M}pausd${Y})${R}4wrd${O}1${c}fram$W;
${M}p$C f$B n${W}:${M}Prev${P}pla${c}ls${B}togl${C}Fulsc${B}Next${P}pla${c}ls${Y}(${O}Esc${W}=${g}2${R}exit${C}f${Y})$W;${Y}Lt$R Rt${W}:${B}bkwd${C}5${M}secs${Y}(${O}arow${r}kyz$Y)${R}4wrd${C}5${M}secs$W;$C 0$O-${R}9$W :${Y}jump${w}to$r N${C}*${G}10${Y}%${O}play${B}bak${P}position${Y}(${C}Hm${Y}/${R}End${W}=${C}0${Y}/${R}9${Y})$W;$M <$G >$W :${r}slow${M}down<${O}play${B}bk${c}spd${G}>up>${K}fastr${W};"'; # try"2"cram Uk 80x4 in2 just 160x2 nstd (mAB 178+wId 2fit prmpt2wi -n)
alias    uk='echo -en "${R}m$G c$K b$W:${M}volu$R Muted$B togl${G}Captn$K Bakgr$C cycl$W;$Y(${C}Home$Y/${R}End$W=$C 0$Y/${R}9$g 2$Y)$W>$C 0$O-${R}9$W :${O}jmp$Y%$G \$${r}n$C*${G}10$O pla${B}bak${P}pos$W =${R}r8io$Y %${P}abs$W;$M <$G >$W :${r}slow$M down<$O pla${B}bak${c}spd$G >upup$K fast$W;
${B}j$M k$R l$W:${B}bkwd$G 10${M}sec$B togl${M}pausd$G 10${M}sec$R 4wrd$W<$Y(${M}Spacebar$W=${M}pause${g}2$Y)$W;${Y}Lt$R Rt$W:${B}bkwd$g -${C}5${M}sec$O arrow${r}keys$G +${C}5${M}sec$R 4wrd$W;$B ,$M .$W :${B}bkwd$g -${O}1${c}frm$w when${M}pausd$G +${O}1${c}frm$R 4wrd$W;
${M}p$C f$B n$W:${M}Prev$O pla${c}ls$B togl${C}Fulsc$O pla${c}ls$B Next$W<$Y(${O}Escap${r}key$W=${R}exit${C}f${g}2$Y)$W;${M}Dn$G Up$W:${M}dec$Y%$g -${C}5${M}vol$O arrow${r}keys$G +${C}5${M}vol$Y %${G}inc$W;"'; # should consider making new 1-column Uk varE8ion which auto-resizes term @start && only needs rescaling2Bbig
alias    ukz='Uk;echo;uk'; # for clearest biggest, open Default 80x24 purple GnomTerm, resize to 97x5, scale up a couple times, then run just `Uk`
alias    U2b=' echo "U2b=youtube-dl 2save file2probably runthru U2b4 aftr orbetr2Use U2b8..."; youtube-dl'; # precede dl with some of my help text
alias    U2bm='U2b  -o "%(title)s-tItL-%(uploader)s-uldr-%(extractor)s-Xtrc-%(id)s-IdNt-%(epoch)s-epch-%(upload_date)s-uldt-%(autonumber)s-otnm.%(ext)s" --restrict-filenames';
#lias    U2b3='U2bm -x --audio-format=mp3  --audio-quality=0'; # just having --audio-format=mp3 was converting to just 32K quality =( hopefully 0 will improve
#lias    U2ba='U2bm -x --audio-format=best --audio-quality=0'; # gst123 works admirably on most formats, but `mpg123 -Cv` is much nicer interface-wise
#lias    mysrut='mysql -u root'; # used to also alias just my to the same, back when I was developing any MySQL code && had mysqld installed
#for ip in $( seq 1 254);             do ping -c 1 192.168.8.$ip>/dev/null; # NAbl pb rEspnsbyapNdng "net.ipv4.icmp_echo_ignore_broadcasts=0" 2/etc/sysctl.conf
  #[       $? -eq 0    ]              && echo     "192.168.8.$ip UP" || : ;
#done # instead of doing pingb below (or just pb), could run this for loop without needing to open systemz to DDoS thru configur8ion for broadcast response
alias psag='ps  aux | grp     ';alias pingb='ping  192.168.8.255 -b'; #   ...or lern2Use`nmap -sP 192.168.8.1/24`nstd? or`arp-scan -l --interface=(eth|wlan)0`
alias idmg='identify          ';alias idmv=' idmg     -verbose     '; # ImageMagick IDentify IMaGe utl && verbose probably needs | $PAGER
alias ckya='w3m Mail.Yahoo.Com';alias gnuya='gnuyahoo -u=piptigger '; # Ubu brwsrz not in Dflt repoz: Opera Vivaldi (mAB some othrz listed below);
#lias cktm='w3m HTTP://Time.Gov'; # need to enable JavaScript in w3m for redirect to /HTML5/ to work so maybe just use FireFox or Chrome
# mAB Ubu brwsrz:FireFox Chrom(e|ium) Epiphany Arora Dillo WebBrowser-App (cudinstl) QupZilla Konqueror NetSurf Links2 (!in acs) Yandex PaleMoon Midori Brave;
alias crmm='chromium-browser  ';alias crom=' google-chrome';alias crm='crom';alias epip='epiphany';alias aror='arora';alias dilo='dillo';alias lnx2='links2';
alias brav='brave';alias brvb='brave';alias brav='brave';alias bb='brvb';alias tb='torb'; # prEfer prv8 tb&&bb&&ff mor than old (proly WebKit-based?) abovz now
alias torb='pu ~/bin/.tst/tor-brwsr-linux64-8.0_en-US-I98MKtor;./start-tor-browser.desktop;po';alias tor='tb'; # new d8d locl v8.0 instal of sepR8 brwzr methd
alias brwz='en "PipzBrwz: ff=FireFox, bb=Brave, tb=Tor, crom=Chrome, crmm=Chromium, epip=Epiphany, aror=Arora, dilo=Dillo, lnx2=Links2;"'; # echo reminderz
alias 2lo=' perl -e "rename(\$_,lc) for @ARGV"'; # orig fIlnAm lOwrcAsng 1-lInr was ~/bin/tolo thN as 2lo but mAB zsh func can't stRt wi '2'? Alias workz tho!
alias j2k=' joy2key $TTY -terminal -rcfile ~/.joy2keyrc -axis Left Right Up Down -buttons a b c d e f g h i j &';
alias j2kx='joy2key      -X        -rcfile ~/.joy2keyrc                                                       &';
alias glxg='glxgears -info -geometry 1920x1056+0+0'; # had to agi libssl-dev to configure opusfile, then below should be good to compress speech for Dad
alias opuse='echo    "opusenc --bitrate 32 --vbr --artist GerryStuart,PipStuart --genre Radio --album FixTheRadio-0 --title FixTheRadio-0.0 --date `date +%Y-%m-%d` in.wav out.opus";
             echo -n "opusenc --bitrate 32 --vbr --artist GerryStuart,PipStuart --genre Radio --album FixTheRadio-0 --title FixTheRadio-0.0 --date `date +%Y-%m-%d` in.wav out.opus"|xclip -si -se p -l 1';
#lias setfont='consolechars -f'; # fb lines on Gen:  # setfont is its own sepR8 command now, so don't alias over it
alias fb6=' fbset  640x480-60 '; #              30
alias fb8=' fbset  800x600-100'; #              37
alias fb10='fbset 1024x768-100'; #              48
alias fb12='fbset 1280x1024-75'; #              64
alias fb16='fbset 1600x1200-76'; #              75
alias moz='/usr/local/mozilla/mozilla -P Pip 2>&1 >/dev/null &'; # from way back when I used Pip Profile (likely before FireFox) with Mozilla spewing warningz
alias irc='irssi';
#lias    ircsdl='     irssi -c IRC.Perl.Org          -n Pip      '; #sdl         # no longer using any b(itch)?x, switched completely to Perl-based Irssi.Org
#lias    ircpl='      irssi -c IRC.Perl.Org          -n Pip      '; #perl  #yapc (which might be renamed after 2016 to just ThePerlConference #tpc?)
#lias    ircpl6='     irssi -c IRC.FreeNode.Org      -n PipStuart'; #perl6       # might need Chat.FreeNode.Net instead? Changing nick destroys config form@ing
#lias    ircrt='      irssi -c IRC.RT.Ru             -n Pip      ';alias irc='ircpl'; # probably wrapping in scrn like `sirc` below is preferred 2 any of these
#lias       sc='      irssi -c IRC.Prison.Net        -n PipStuart'; #soulcalibur # used to use -n Pipsurugi
#lias       srk='     irssi -c IRC.ServerCentral.Net -n PipStuart'; #srk         # can also do -w evl2003 to include pswd && might need -p to chng port BlO
#lias       srk='     irssi -c IRC.INet.Tele.Dk:6667 -n PipStuart'; #srk         # altern8 IRC servers to try to connect to if otherz are down or net-split
#  otherz:  EFNet.Demon.Co.UK  IRC.Nijenrode.Nl  HomeLien.No  QEast.Net          # for ScreenOctology*.pm editz BlO had2rEplAc e wi vim for multi-fIl OpNng
alias swip='screen -wipe  '; # learn how to restore block cursor within multiplexed vim from the $TERM=screen.linux console (sEmz scrn mustXitB4 `curs` resetz)
alias scrn='screen -h 9999'; # might not need to temporarily change TERM for irc (or any of these if TERM becomes working screen.xterm-256color) below
alias s2du='pu ~/dox/2du;export TERM="xterm";scrn -S 2du -t 2du e 2;export TERM="xterm-256color";po';alias s2='s2du'; # Used2wrap2ovrId TERM=screen ,xterm betr
alias sirc='ct "irssi"  ;scrn -S irc -t irc irssi       ;  ';alias si='sirc';  # don't need -c IRC.Perl.Org or -n Pip since specified in ~/.irssi/config now
#lias s2du='pu ~/dox/2du;scrn -S 2du -t 2du e     2     ;po';alias s2='s2du';  # reverted to exporting TERM=xterm around s2 2mk vim statusbar dRk AgN
alias s28x='pu ~/dox/2du;scrn -S 8xt -t 8xt e     8     ;po';alias s28='s28x'; # s8 is already aliased to sort; weird that e 8 didn't have e 2 problM
alias s8lc='pu ~/dox/2du;scrn -S 8lc -t 8lc e     8plc  ;po';alias s8l='s8lc'; # elabor8ing out2 tRget all sepR8 doQmNtz stil mAntAnd as 2du EvN2ally
alias satl='pu ~/dox/2du;scrn -S atl -t atl e     at.ls ;po';alias sa='satl';alias soa='pu ~/dvl/a8;scrn -S oa8 -t oa8 e a8.pm;po'; # OpenOctology *8.PlModulez
alias sb8a='pu ~/dox/2du;scrn -S b8a -t b8a e    b8a.ls ;po';alias sb='sb8a';alias sob='pu ~/dvl/b8;scrn -S ob8 -t ob8 e b8.pm;po'; # Screen_lib/Octology/\w.pm
alias sbxl='pu ~/dox/2du;scrn -S bxl -t bxl e   boox.ls ;po';alias sB='sbxl';alias scS='            scrn -S';alias sat=' sa      '; # kinda similR2old e fIl.ls
alias scm8='pu ~/dox/2du;scrn -S cm8 -t cm8 e   ckm8.txt;po';alias sc='scm8';alias soc='pu ~/dvl/c8;scrn -S oc8 -t oc8 e c8.pm;po'; #   ..2Elabor8Uni4m abrEV8z
alias skno='pu ~/dox/2du;scrn -S kno -t kno e   know.ls ;po';alias sk='skno';alias sod='pu ~/dvl/d8/lib/Octology;scS od8 -t od8 vim d8.pm d8/[df]??[8z].pm;po';
alias smul='pu ~/dox/2du;scrn -S mul -t mul e    muz.ls ;po';alias Sm='smul';alias som='pu ~/dvl/m8/xml         ;scS om8 -t om8 vim [MT][ei][rd]*[ey]/*.pm;po';
alias smvl='pu ~/dox/2du;scrn -S mvl -t mvl e    mvz.ls ;po';alias SM='smvl';alias sop='pu ~/dvl/p8;scS op8 -t op8 vim [tmnp]??[hx8s]/[tmnp]??[hx8s].pm   ;po';
alias sput='pu ~/dox/2du;scrn -S put -t put e   putr.txt;po';alias sP='sput';alias sot='pu ~/dvl/t8/Octl/Octology;scS ot8 -t ot8 vim *.md;po;en oupd,gac,gpom';
alias ssfv='pu ~/dox/2du;scrn -S sfv -t sfv e    sfv.txt;po';alias sf='ssfv';alias sof='pu ~/dvl/f8;scrn -S of8 -t of8 e f8.pm;po'; # mABl8r vary4asOC8d binz2
alias stab='pu ~/dox/2du;scrn -S tab -t tab e   tabz.ls ;po';alias sT='stab';alias sog='pu ~/dvl/g8;scrn -S og8 -t og8 e g8   ;po'; # not A sepR8 PlModule yet
alias stip='pu ~/dox/2du;scrn -S tip -t tip e   tipz.ls ;po';alias sI='stip';alias soU='pu ~/dvl/U8;scrn -S ou8 -t ou8 e U8.pm;po';alias sou='soU'; # bOthKsez
alias sdvl='pu ~/dvl    ;scrn -S dvl -t dvl             ;po';alias sd='sdvl';  # mAB some new sD can lOd Xtra Dvl lIk Utl Tk Time Math anythng else important
alias smuz='pu ~/muz    ;scrn -S muz -t muz             ;po';alias sm='smuz';alias so=' ob ';alias mob='ob';alias obs='ob';alias Obs='ob';alias sobs='   ob';
alias smvz='pu ~/mvz    ;scrn -S mvz -t mvz             ;po';alias sM='smvz';alias Ob=' ob ';alias ob=' pu ~/muz/U2b;scrn -S mob -t mob g3 **/*Obs*     ;po';
alias srut='pu  /etc    ;scrn -S rut -t rut sudo -E  zsh;po';alias sr='srut';alias Ob8='lob';alias lob='pu          ;l              m[uv]z/**/*Obs*ate_*;po';
alias sadm='pu  /root   ;scrn -S adm -t adm sudo    bash;po';alias sA='sadm'; #abovOb8 orig just listed: (Annihil|Deso|Domin|InitE|Obliter)8 B4XtNdng2alldirz
alias sx='  scrn -x '; # would also be good to upd8 abov openingz of scrnz 2ck4 `scrn -ls $mtch` for already crE8d wich shud just B -x reattached 2 nstdofnew
#lias sls=' scrn -ls'; # stuD screenie 2mkOwn version. wrapd `scrn -ls` BlObutl8r tAkthOs b8 && d8 rE4m@z as valid pRamz2reattach2. rEplAc scrn wi autO sx;
alias sls=' pabd "\$v=q(screen -ls);\$v.=qq( @ARGV) if(@ARGV > 0);\$S=\`\$v\`;while(\$S=~ /\t((\d+)\.(\S+)\s+\((\d+)\/(\d+)\/(\d+)\s+(\d+:\d+:\d+)\s+([AP])
  M\)\t\(([AD])[te]tached\)\n)/x){\$L=\$1;\$I=b8c(b64(\$2));\$H=\$3;\$N=\$4;\$D=\$5;\$E=\$6;\$T=\$7;\$n=\$8;\$t=\$9;\$x=S(q(Rr));\$t=\$x.\$t if(\$t=~ /D/);
  if(\$n=~ /P/ && \$T=~ /^(\d+):/){\$h=\$1+12;\$h%=24;\$T=~ s/^(\d+):/\$h:/;}   \$A= S   (q(Ab));\$x=q(XtracmNt:Repurposd RedOnRed detached in2filr text;);
  \$d=Octology::d8->new(q(expand)=>\$Mon[\$N-1].q( ).\$D.q( ).\$T.q( ).\$E);\$e=\$d->colr(q(a) );\$S=~ s/\Q\$L\E/\$I\$K.\$A\$H\$z\t\$e \$G\$t\$z\n/igixi;};
\$S  =~ s/(There)( are| is a)( screens?)( on)(:)/\$B\$1\$p\$2\$G\$3\$o\$4\$W\$5/gig;\$x=q(XtracmNt:sinc -ls tAk m@chpRam,1st passin ARGV B4wrap ZshLfunc;);
if(\$S=~ /(\d+)( Sockets?)( in )(.+)\..*/){\$s=b8c(b64(\$1));\$X=\$2;\$i=\$3;\$F=c8fn(\$4);\$x=q(XtracmNt:CmzlIk6.5solidsourclInz puttz mE undrpR4ashole;);
  \$S=~ s/(\d+)( Sockets?)( in )(.+)\..*/\$s\$C\$X\$p\$i\$Y\$F\$W;\$z/;}print \$S;"'; # 2du:s/// tabz wi spAcpadz justifyng 4m@ng alInmNt; # /mE isA putzr?
#There are screens on: #	17836.b8a	(10/03/2018 04:09:10 AM)	(Detached)  # /defhijlnqstuvx/i + AZ are sOlOz avAl 4 golf abov (aftr a8 sOlO color Xportz);
# cangiv m@chpRam now; #	 5604.irc	(10/02/2018 07:48:46 PM)	(Attached)\n#2 Sockets in /run/screen/S-pip.  # SCreenLiStcmnd=S,ScreenLINe=L,PRocessIDnt=I,
#lias g3='   gst123 '; # replaced by Xpct XperimNt  # sux2havnOsyntxhIlIt  # ScreenTiTL(PID.TTY.Host)=H,moNth=N,Day=D,yEar=E,Time=T,afterNoon=n,deTached=t,
alias m3='   mpg123 '; # replace  wi Xpct l8r too   # butsumvrynIcalInmNt  # Hour=h,d8OBject=d,d8colrEskaped=e,Socketcount=s,soX=X,In=i,screenpathFilenm=F,
#lias m1='   mpg321 '; # replace  wi Xpct l8r too   # guessngaboutARGVthO  # eXtra_detached_color_with_red_background=x (mOmNtary modific8ionB4cmNt filrz);
#lias m0='   mpr0   '; # replace  wi Xpct l8r too;  already replaced by function below for now!   # OMG! Such consistNtly blockedout p@rnz of alInmNt abov;
alias dvdb=' dvdbackup -M -p';alias dvdbak='dvdb';  # default DVD backups -Mirroring full disc into current working directory && upd8ing d8a copy -progress
# H7IM3Qvo:mp -vo help; MPlayer 1.3.0 (Debian), built with gcc-6.3.0 (C) 2000-2016 MPlayer Team; Available video output drivers: # pretty old optnz now
# vdpau      X11 VDPAU                                           fbdev    Framebuffer Device                        xvmc     XVideo Motion Compensation
# xv         X11/Xv                                              fbdev2   Framebuffer Device                        mpegpes  MPEG-PES to DVB card
# X11        X11 ( XImage/Shm )                                  aa       AAlib                                     yuv4mpeg yuv4mpeg output for mjpegtools
# xover      General X11 drvr4overlay capable vidout drvrz       caca     libcaca                                   png      PNG  file
# sdl        SDL YUV/RGB/BGR renderer (SDL v1.1.7+ only!)        v4l2     V4L2 MPEG Video Decoder Output            jpeg     JPEG file
# gl_nosw         OpenGL no software rendering                   directfb Direct Framebuffer Device                 gif89a   animated GIF output
# gl              OpenGL                                         dfbmga   DirectFB/Matrox G200/G400/G450/G550       tga      Targa        output
# gl_tiled   X11 (OpenGL) - multiple textures version            xvidix   X11    (VIDIX)                            pnm      PPM/PGM/PGMYUV file
# matrixview     (OpenGL) MatrixView                             cvidix   console VIDIX                             md5sum   md5sum of each frame
# dga        DGA (Direct Graphic Access V2.0)                    null     Null video output   # drvrz listed in likely most useful ordr(&&bak2 xv fixd stutr)
#    -fixed-vo only with xv, x11, xvidix, gl, gl_tiled, && svga (ignoring irrelevant Matrox); # swapping mp && mplyr alias dFinitionz due2frEquNC of use&&mM
alias mplyr='mplayer'; # EBIL4AcZ:just upgraded all machines to mplayer2 so need --no-keepaspect to allow scaling to full window dimensions
alias mp='   mplayer -vo xv  -fixed-vo                              -cache 16384 -cache-min 99'; # should try different -vo (xv was default) for performance
alias mpns='cd ~/mvz/U2b/nxt;mp $(ls B* Dr* *Tut* Ex* M* O*-Res* Var* *Trap* *Trap* *Boy*|shfl);cd ..'; # mk MPlyrNxtShfl 4 quik favor8 mvz Drub&&Trap vidzls
alias mpx='  mp      -fs'; #-x 1920 -y 1080'; # originally quite a long time ago, I used to include -noborder optn abov but thN cud!mv wndw
alias mply=' mplayer -vo xv  -fixed-vo -nosound -loop 0          -geometry 1916x1052+0+0    '; #-x 1916 -y 1052' # mplayer canOnly stRt wi1920maxBcuzXinerama?
#lias mpr0=' mplayer                   -nosound --no-keepaspect  -geometry 1920x1052+0+0    '; # still needs vid file params like: ~/mvz/U2b/**/*Obsidia*.opus
alias mpr0=' mplayer -vo xv  -fixed-vo -nosound -nokeepaspect    -geometry 1920x1052+0+0    -loop 0'; # this 4 MPlayer && above 4 MPlayer2 (wich I had4 awhIl)
alias mpr1=' mplayer -vo xv  -fixed-vo -nosound -nokeepaspect    -geometry 1920x1052+888+88 -loop 0'; # this 4 same as mpr0 but on Aku's  middle   24" display
alias mpr2=' mplayer -vo xv            -nosound -nokeepaspect    -geometry 1920x1052+1919+0 -loop 0'; # this 4 same as mpr0 but on Aku's far right 50" display
alias mpr0t='mplayer -vo xv  -fixed-vo -nosound -msgcolor -noborder -cache 16384 -cache-min 99 -geometry 1916x1052+0+0 -msglevel all=0:identify=4 ~/mvz/.pr0/tst/Aut0pr0-9AS4gTn/pr0-*/*'; # test if messages can report desired details; # for some reason,above mpr1 won't take geom 2full midl display so just offset a bit?
alias mpfb=' mplayer -vo fbdev -vf scale=640:400   -loop 0'; # ~/mvz/U2b/* for some old scaled FrameBuffer modes
alias mpfbs='mplayer -vo fbdev -vf scale=1920:1200 -loop 0'; # ~/mvz/muV/*
alias mpf8=' mplayer -vo fbdev        -nosound --no-keepaspect  -vf scale=1920:1080 '; # still needs vid file params to follow
m0() { # mplayer pr0n function
  if       [[ "$#" -gt   0 ]]; then # print out some help text for -h (or l8r add --help) as first parameter && then return
    if     [[ "$1"  ==  *h ]]; then echo 'm0 crE8d by PipStuart <Pip@CPAN.Org> to wrap mpr0 for streamlining calls to mplayer on my pr0n;'
      echo                               ' h - print this Help text && exit;  No pRam runs mpr0 on mpg,wmv,avi * (left scrn,mpr1 right).'
      echo                               ' 1 - runs mpr1 on     wmv,avi,mpg ht*;    (this 1 && v below ignore any l8r pRameters so far)'
      echo                               ' 2 - runs mpr2 on mpg,wmv,avi     ht*;'
      echo                               ' s - runs mpr2 on mpg,wmv,avi shfl   ;'
      echo                               ' v - runs  vp  in   .VelvetPound/    ;    Other pRams will just be passed on to mpr0 for now;';return 0;
    elif   [[ "$1"  ==  *v ]]; then                                                cd ~/mvz/.pr0/.VP/     ;vp
    elif   [[ "$1"  ==  *1 ]]; then                                                cd ~/mvz/.pr0/         ;mpr1 mpg/ht* wmv/ht* avi/ht*
    elif   [[ "$1"  ==  *2 ]]; then                                                cd ~/mvz/.pr0/         ;mpr2         wmv/*   avi/*   mpg/*
    elif   [[ "$1"  ==  *s ]]; then                                                cd ~/mvz/.pr0/         ;mpr2 $(ls    wmv/*   avi/*   mpg/* | shfl)
      # & \ abov just bkgrndz 0 procS so nEd2du smthng lIk vp 2spawn 2sepR8 windOz && 4nO pRamz else BlO  ;mpr0 wmv/ht* avi/ht* mpg/ht*
    else                                                                                                   mpr0 $@;fi # assume othr pRamz mEn alreD in fIn dir
  elif     [[ `pwd` ==  *.pr0/mpg/  ]] || [[ `pwd` ==  *.pr0/wmv/  ]] || [[ `pwd` ==  *.pr0/avi/  ]]; then mpr0 *
  else                                                                             cd ~/mvz/.pr0/         ;mpr0 mpg/*   wmv/*   avi/*;fi }
alias m1='m0 1'; # could also try to add |g -v "_server /home/" or |g steam|g " Ssl " below to inVert match to try to not get child processes first
alias m2='m0 2'; #   Screeps was below, but for some reason spawning server process was uniquely showing up with space for second 's' but no longer
alias kscr='k $(psag "/screeps_server\$"|g " Ssl "|head -n 1|cut -c10-14)'; # try2 kill prv8 screeps_server process easier than typing k $PID aftr psag Sc
alias kamp='ka -q -9 mplayer'; # -quiet (!warn if!mtch) && -9 kill force signal  ## du! actually kill any @all (if U can hLp it, plEz)!
alias kasd='ka -q speech-dispatcher'; # resolve Aku's buggy loud HDMI audio clicking loop from "cicero" tXt2sPch4 mbrola wich surfaced aftr watching Twitch vid
alias kafp='ka -q plugin-container'; #'kill `ps ax | grep firefox | grep flash | cut -d" " -f1`'; # Kill crashed adobe Flash plugin (altho bad if ever running additional firefox plugins && will have to restart those too). Could also use   | c8 0';#now instead.
#/usr/lib/firefox/plugin-container /usr/lib/flashplugin-installer/libflashplayer.so -greomni /usr/lib/firefox/omni.ja 1881 true plugin
alias kas=' kasd'; # KillAllStupidScratchySpeechSoundStaticShockSparkSpaz
alias  klok='dclock -date "%A %B %d, %Y" -geometry 256x88-1920-0 -miltime -bg "#03071B" -led_off "#031B0B" -fn Fixed &';
alias xklok='xclock -digital -fg yellow -bg black -rv -geometry 512x64 -update 1 &'; # stuD fdclock gworldclock osd_?clock twclock tzwatch 2add more good here
alias echoe='echo -e'; #  enable interpret8ion of backslashed escapes (default is -E to disable)
alias echon='echo -n'; # disable trailing Newline
alias echos='echon  ';
alias eqx='/home/pip/dvl/m8/clda/eqx/eqx-0.9.4.26/equinox3d-0.9.4.26-Linux64bit/eqx &'; # Gabor Nagy's awesome EQuinoX3D
alias fstat='  perl -MTime::PT     -e "@s=split(/ /,scalar(localtime((stat(shift))[9])));print   \"@s\"      ;"';
#lias fstatpt='perl -MTime::PT     -e "@s=split(/ /,scalar(localtime((stat(shift))[9])));print `pt @s`,\"\n\";"'; #pt(@s) not exported,so try shell,leav Nwln?
alias fstd8='  perl -MOctology::d8 -e "@s=split(/ /,scalar(localtime((stat(shift))[9])));print Octology::d8->new(\"expand\"=>\"@s\");"'; 
alias    xt=' xterm      -geometry 160x50   &'; #     xt used2B a symlink2 ~/bin/xmltidy but more consistent with gt,Et,st to have it as xterm now instead
alias uxtrm='uxterm      -geometry 160x50   &';alias uxt='uxtrm';alias st='stterm -g 160x50 -T st &'; # also SimpleTerminal st
alias lxtrm='lxterminal --geometry=160x50   &';alias lxt='lxtrm'; # =lxterm is a separ8 sh script wich testz locale && wrapz plain uxterm for UTF-8
alias satrm='sakura      -c 160     -r 50   &';alias sak='satrm'; # thEse termz are each made pretty similar to my Dfalt GT dimensionz
alias  tn8r='terminator --geometry=1608x932 &'; # geom here is strangely pixLz nstd of charz with char dimensionz about 10x18 pixLz plus border && tabbar
alias  xf4t=' x4t       --geometry=160x50   &';alias x4t='xfce4-terminal'; # need to config terminalrc to use smaller font
alias  rox='  rxt       --geometry=160x50   &';alias rxt='roxterm'; # anothr VTE-bAsd xterm (-z $ZoomFrom1.0 [want 0.8333] spits CRITICAL assertion pango)
alias  Etrm=' Eterm     --geometry 160x50 --scrollbar-width 15 --cmod 227 -L 65536 &';alias Et='Etrm';alias E='Et'; # used to be 'Eterm -t E &' but it...
export ETERM_THEME_ROOT="~/.Eterm/themes"; # wuz ~/.Eterm/themes/Eterm                       # ...looks like I don't even need that plain old  E theme anymore
#lias E=' Eterm -t E --scrollbar-type motif --scrollbar-width 15 &'; # --cmod 227 &';
#lias Et='Eterm --background-pixmap mits1024.jpg -c orange -T PipzEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --path /home/pip/.Eterm/ --default-font-index 4 &'
#lias Et='Eterm -c #FFA404 -T PipzEtrm --scrollbar-type motif --scrollbar-color blue    --scrollbar-width 15 --scrollbar-right --default-font-index 4 &'
#lias Et='Eterm -c #FFA404 -T PipzEtrm --scrollbar-type motif --scrollbar-color #071531 --scrollbar-width 15 --scrollbar-right --default-font-index 4 -F andalemo.ttf --proportional --cmod 195 --double-buffer &'; "-*-*-*-*-*-*-$1-*-*-*-*-*-*-*"
#/usr/share/texmf/fonts/afm/adobe: avantgar bookman courier helvetic         ncntrsbk palatino         symbol times zapfchan zapfding
#/usr/share/texmf/fonts/tfm/adobe: avantgar bookman courier helvetic mathppl ncntrsbk palatino pslatex symbol times zapfchan zapfding
#/usr/share/texmf/fonts/vf /adobe: avantgar bookman courier helvetic mathppl ncntrsbk palatino pslatex        times zapfchan
#lias Et='Eterm -c #FFA404 --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --cmod 227 &';
#lias Et='Eterm -c #FFA404 -T PipzEtrm --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --buttonbar --cmod 227 -L 4095 --double-buffer -x &'; #\
#                                                       --font1 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-56-iso8859-1" \
#                                                       --font2 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-66-iso8859-1" \
#                                                       --font3 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-76-iso8859-1" \
#                                                       --font4 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-96-iso8859-1" \
#                                                  --bold-font  "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-96-iso8859-1" &';
#lias gtd0='gnome-terminal --display=:0.0'; # these were old Ryu gN2 GT aliasz which I keep around for l8r rFerence
#lias gtrm='    gtd0 --class=gtrm     --geometry  80x46-0+0      --hide-menubar --window-with-profile=GT80x46Terminus18           --title=zsh          &';
#lias gterm='   gtd0 --class=gterm    --geometry 160x64+0+0      --hide-menubar --window-with-profile=GT160x64Courier14                                &';
#lias gnomterm='gtd0 --class=gnomterm --geometry  80x51+0+0      --show-menubar --window-with-profile=GT80x39CourierBold20        --title=zsh          &';
#lias gtpt='    gtd0 --class=ptok     --geometry  27x1-0-0       --hide-menubar --window-with-profile=GT27x1AndaleMonoBold40-ptok --title=ptok -e ptok &';
#lias gtpto='   gtd0 --class=ptok     --geometry  27x1+3002+1141 --hide-menubar --window-with-profile=GT27x1AndaleMono40-ptok     --title=ptok -e ptok &';
#lias gtpm='    gtd0 --class=pmix     --geometry 160x3+1921+1141 --hide-menubar --window-with-profile=GT67x3Lincoln12-pmix --title=pmix -e pmix&';#160,180,282
alias gtt='gnome-tweaks'; # used to be gt-tool scaling all fontz to 1.5 && mkng CapsLock a Ctrl;XperimNt wi Caps2:Hyper,Menu,Win2see wut else can map too?
alias gt=' gnome-terminal';alias wmc='wmctrl'; # mAB -x zsh (-c)? s2 & or wiout aliasz: pushd ~/dox/2du;screen -h 9999 -S 2du -t 2du e 2;popd;
alias xr='xrandr --output DVI-0 --mode 1920x1080 --rate 60';alias cx='ct "init";xr'; # nEd2set ViotekGN32C over DVI from Dflt 144 rEfresh down2cAbl suportd 60
if       [[ "${(L)HHst}" ==  aku    ]]; then  alias gtss='sleep 1'; # GnomeTerminal SleepSeconds 2 delay 4 gti init   # only Akuma was fast Enuf2kEp up with 1
else                                          alias gtss='sleep 2'; fi            # ... second before && hopefully Ryu, Ken, && Chun can all handle just 2 now
# below set 8sh "H" Viewport Width 1..3 | Height 1 defaults of all 3840x1080 then override as approprE8 for host-specific display resolution varE8ionz
                                                                              export HVW1='3840';export HVW2='3840' ;export HVW3='3840' ;export HVH1='1080';
if       [[ "${(L)HHst}" ==  aku    ]];                                  then                    export HVW2='7680' ;export HVW3='11520'; # new50"TV is 3wide
  if     [[     "$H3WF"  ==  "1"    ]];                                  then export HVW1='5760';export HVW2='11520';export HVW3='17280';                fi
elif     [[ "${(L)HHst}" ==  ryu*   ]] || [[ "${(L)HHst}" ==  ken*   ]]; then export HVW1='1920';                    export HVW3='5760' ;                    fi
if       [[ "${(L)HHst}" ==  ryu*   ]];                                  then                                                            export HVH1='1200'; fi
if       [[ "${(L)HHst}" ==  chun*  ]] || [[ "${(L)HHst}" ==  taki*  ]]; then export HVW1='1280';export HVW2='2560';export gtss='sleep 3';export HVH1='800'; fi
chvp() { # CHange ViewPort ("virtual desktop") thru wmc -o ... based on host dimz && Compiz 8 viewportz in 4x2 grid
  if     [[ "$1"         ==     ""  ]] ||
         [[ "$1"         ==    "0"  ]]; then wmc -o     0,0;
  else
    if   [[ "$1"         ==    "1"  ]]; then wmc -o $HVW1,0;
    elif [[ "$1"         ==    "2"  ]]; then wmc -o $HVW2,0;
    elif [[ "$1"         ==    "3"  ]]; then wmc -o $HVW3,0;
    elif [[ "$1"         ==    "4"  ]]; then wmc -o     0,$HVH1; # 2du:figure out why Chun can't chv4,proly Compiz desktop Cube restrictz from lower row
    elif [[ "$1"         ==    "5"  ]]; then wmc -o $HVW1,$HVH1;
    elif [[ "$1"         ==    "6"  ]]; then wmc -o $HVW2,$HVH1;
    elif [[ "$1"         ==    "7"  ]]; then wmc -o $HVW3,$HVH1; fi; fi }
alias chv0='chvp 0';alias chv1='chvp 1';alias chv2='chvp 2';alias chv3='chvp 3';
alias chv4='chvp 4';alias chv5='chvp 5';alias chv6='chvp 6';alias chv7='chvp 7';
alias   gt3='gt --geometry=+0+0       --show-menubar --window-with-profile=PipsTestGnomTerm-DiffFont-D1NBxCf                                                &;
        gtss;wmc -r :ACTIVE: -T test                ;
             gt --geometry=-0+0       --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8                                                &;
        gtss;wmc -r :ACTIVE: -T othr                ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt                                               &;
        gtss;wmc -r :ACTIVE: -T ckm8               '; # slower now calling sleep between every spawn to give wmctrl time to grab active && set title
alias   gt4='gt3;
             gt --geometry=-1920+0    --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8                                                &;
        gtss;wmc -r :ACTIVE: -T Othr               '; # so far, only Aku has multiple displayz in default configur8ion, with room for these 2 xtra terminalz
alias   gt5='gt4;
             gt --geometry=-3840+0    --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8                                                &;
        gtss;wmc -r :ACTIVE: -T othr               '; # so far, it's too bad that Othr background dark green looks just black with l8st Sony TV settingz
alias rs=' resize'; # also able to pass '-s $rowz $colz' to set term dimNsionz,sO mAB cnvrt this alias in2 function wi pRam optnz l8r Dtectng ${W}x$H 4m@z too
alias rsN='noglob eval `resize -s 57 171`';alias rsn='  rsN'; # N for 171-wide (for calN to show 19-Years slightly lRgr than Dflt 160x50 standRd Used Lswhere)
alias rsZ='noglob eval `resize -s 75 240`';alias rs240='rsZ'; # zdflt 160-wide (not sure how necessary noglob, eval, or backtix are, but they make cmnd quiet)
alias rsz='noglob eval `resize -s 50 160`';alias rs160='rsz'; # zdflt 160-wide (not sure how necessary noglob, eval, or backtix are, but they make cmnd quiet)
alias rs8='noglob eval `resize -s 25  80`';alias rs80=' rs8'; # 8 for  80-wide (might want to make these only 24 high, like Default Gnome-Terminal profile)
alias rs4='noglob eval `resize -s 12  40`';alias rs40=' rs4'; # 4 for  40 && also 2 for 20 as good halvingz 2l8r suport4low-reso nEdz (thO int(25/2)= just 12)
alias rs2='noglob eval `resize -s  6  20`';alias rs20=' rs2'; # if ever capable of displaying on large 4K HD monitorz, may want to try out a huge 320x100 too
alias rs1='noglob eval `resize -s  3  10`';alias rs10=' rs1'; # continue halving standards to obtain dimensions all the way down to just 30 characters total
alias rs3='noglob eval `resize -s  1  34`';alias rsd8=' rs3'; # 3 for  34-wide d8ok termz (somewhat more straightforward && brief 2 use char dimz versus pixlz)
alias rsd8ok='                      rs3  ';alias rsd='  rs3'; #   && a few more for d8ok  (even though wmctrl -e below is making these rel8ively unnecessary)
alias rs160x50='rs1';alias rs80x25='rs8 ';alias rs34x1='rs3'; # HB1MBPrr:just removing Ubu17.10 deprec8d -e && -x + pRams to popul8 in GT d8ok profls && this;
# HC3L0DNV:noglob eval around backticks may try to reach out to propag8 exported upd8 dimensions to invoking parent environment && variables, workz without?;
if       [[ "${(L)HHst}" ==  aku    ]]; then # 664||-1882,-e2586 1294w 3840-1958=-1882 wmc -r :ACTIVE: -e 0,664,-1,-1,-1;wmc -r:ACTIVE:-e 0,-1882,-1,-1,-1;
  # Most of these below originally had --title= parameters like d8ok,d8ok-f,othr,2du,muz,mvz but current version no longer supports it. I've run s/title/role/g
  #   since their purpose is similar but I wish GT would just enable titles&&less than 4 rowz again like B4. Lookz like wmctrl is Able2resolv all these issuez.
  #     gtss;wmc -r :ACTIVE: -b add,sticky,below; # this was all linez aftr any d8ok (B4Itried2set -Titlez,add skip_(pager|taskbar) && upd8 geom wi -e rEsize)
  # Apparently 1st resize field is gravity:0-WinMngr shud use grav specified in WM_SIZE_HINTS.win_gravity,1-NW,2-N,3-NE,4-W,5-cNtr,6-E,7-SW,8-S,9-SE,10-static.
  # Same page: HTTPS://SuperUser.Com/questions/576057/bash-resize-terminal-xterm has `echo -e "\e[8;1;34t"` which also workz nicely 2 resize my d8ok terminalz.
 if      [[     "$H3WF"  ==  "1"    ]]; then # H78M19EK:insertd new H variable test for whether using Sony50"1080iTV or 32"Viotek display as 3-Wide-Flag 4Aku;
                                             #   Below used to just have "-e ~/bin/d8ok" before appending the -d parameter so needing the -x instead.
  # I71M8wxh:Maybe Ubu18.04 upd8d GnomTerm or GnomTwekTool gone dropd scaling so old d8ok32->36 && main8->7.9 nEdz x664,4504,2584 chopd 4 4mor char widthz;
  # q 1306/34=38.41176470588235294117647058823529411765
  # 1306-1292=14 mAB scrlbR widt; 4x38=152; 512,4352,2432; mIt nEd2scAl 1306 wIdr2 1458; try even shorter 1268, wi each of 34 char widz 38px or 33 wo padspc?
  # q 1458/34=42.882352941176470; 4x42=166; 496,4336,2416; othr was +306+0 up2 466;
  alias gtI='gt --geometry=+664-0     --hide-menubar --window-with-profile=d8ok                               --role=d8ok                                   &;
        gtss;wmc -r :ACTIVE: -T d8ok                ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e  10,664,1006,1268,74;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=-0-0       --hide-menubar --window-with-profile=d8ok                               --role=d8ok                                   &;
        gtss;wmc -r :ACTIVE: -T d8ok                ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e 10,4504,1006,1268,74;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=-0-0       --hide-menubar --window-with-profile=d8fd                               --role=d8fd                                   &;
        gtss;wmc -r :ACTIVE: -T d8fd                ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e 10,2416,1006,1458,74;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=+466+0     --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=othr                                   &;
        gtss;wmc -r :ACTIVE: -T othr                ;
             gt --geometry=-1920+0    --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=sys                                    &;
        gtss;wmc -r :ACTIVE: -T sys                 ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=2du                                    &;
        gtss;wmc -r :ACTIVE: -T 2du                '; # might want to experiment with 5-centered or 10-static gravity to see if they're any better than S && SE
  alias gtm='gt --geometry=+0+0       --show-menubar --window-with-profile=PipsTestGnomTerm-DiffFont-D1NBxCf  --role=test                                   &;
        gtss;wmc -r :ACTIVE: -T test                ;
             gt --geometry=-1920+0    --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=Othr                                   &;
        gtss;wmc -r :ACTIVE: -T Othr                ;
             gt --geometry=-3840+0    --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=muz    --working-directory=muz/U2b     &;
        gtss;wmc -r :ACTIVE: -T muz                 ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=mvz    --working-directory=mvz/U2b     &;
        gtss;wmc -r :ACTIVE: -T mvz                '; # Aku gti below fully loadz GTz in all 8 ViewPortz
  alias gti='gtI;gtss;chv1;gtss;gtm;gtss;chv2;gtss;gt5;gtss;chv4;gtss;gt5;gtss;chv5;gtss;gt5;gtss;chv6;gtss;gt5;gtss;chv7;gtss;gt5;gtss;chv3;gtss;gt5;chv0';
 else # back to older Aku GnomTerm aliases for just 2 24-inch Asus displays, before adding SonyTV or new curved as 3rd display
  alias gtI='gt --geometry=-1882-0    --hide-menubar --window-with-profile=d8ok                               --role=d8ok                                   &;
        gtss;wmc -r :ACTIVE: -T d8ok                ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e  10,664,1006,1306,74;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=-0-0       --hide-menubar --window-with-profile=d8fd                               --role=d8fd                                   &;
        gtss;wmc -r :ACTIVE: -T d8ok-fd             ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e 10,2584,1006,1306,74;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=-1920+0    --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=othr                                   &;
        gtss;wmc -r :ACTIVE: -T othr                ;
             gt --geometry=-0+0       --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=sys                                    &;
        gtss;wmc -r :ACTIVE: -T sys                 ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=2du                                    &;
        gtss;wmc -r :ACTIVE: -T 2du                '; # might want to experiment with 5-centered or 10-static gravity to see if they're any better than S && SE
  alias gtm='gt --geometry=+0+0       --show-menubar --window-with-profile=PipsTestGnomTerm-DiffFont-D1NBxCf  --role=test                                   &;
        gtss;wmc -r :ACTIVE: -T test                ;
             gt --geometry=-0+0       --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=Othr                                   &;
        gtss;wmc -r :ACTIVE: -T Othr                ;
             gt --geometry=-1920+0    --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=muz    --working-directory=muz/U2b     &;
        gtss;wmc -r :ACTIVE: -T muz                 ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=mvz    --working-directory=mvz/U2b     &;
        gtss;wmc -r :ACTIVE: -T mvz                ';
  alias gti='gtI;gtss;chv1;gtss;gtm;gtss;chv2;gtss;gt4;gtss;chv4;gtss;gt4;gtss;chv5;gtss;gt4;gtss;chv6;gtss;gt4;gtss;chv0'; # Aku loadz GTz in left 6 ViewPortz
 fi
else # following settings will hopefully work well for single-screen Ryu, Ken, && Chun (Taki's hard drive failz && she runz slow && hot, she's pretty dead)
  if     [[ "${(L)HHst}" ==  ken*   ]]; then # should be almost the same as Aku's left screen, but mAB 10-static like Chun will also position best?
    alias gtI='gt --geometry=-0-0     --hide-menubar --window-with-profile=d8ok                               --role=d8ok                                   &;
        gtss;wmc -r :ACTIVE: -T d8ok                ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e  10,664,1006,1306,74;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=-0+0       --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=othr                                   &;
        gtss;wmc -r :ACTIVE: -T othr                ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=2du                                    &;
        gtss;wmc -r :ACTIVE: -T 2du                ';
  elif   [[ "${(L)HHst}" ==  ryu*   ]]; then # Ryu should just resize to Aku's d8ok y-offset + 120    (for display pixel heightz 1200 - 1080)
    alias gtI='gt --geometry=-0-0     --hide-menubar --window-with-profile=d8ok                               --role=d8ok                                   &;
        gtss;wmc -r :ACTIVE: -T d8ok                ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e  10,664,1126,1306,74;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=-0+0       --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=othr                                   &;
        gtss;wmc -r :ACTIVE: -T othr                ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=2du                                    &;
        gtss;wmc -r :ACTIVE: -T 2du                ';
  elif   [[ "${(L)HHst}" ==  chun*  ]]; then # d8ok resize geometry to fit Chun best, starting 421 602 886 198, each row is 49 pixlz high so less 147 for 3
    alias gtI='gt --geometry=-0-0     --hide-menubar --window-with-profile=d8ok                               --role=d8ok                                   &;
   gtss;gtss;wmc -r :ACTIVE: -T d8ok                ;wmc -r :ACTIVE: -b add,skip_pager,sticky;
             wmc -r :ACTIVE: -e    10,420,749,886,51;wmc -r :ACTIVE: -b add,skip_taskbar,below;
             gt --geometry=-0+0       --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=othr                                   &;
        gtss;wmc -r :ACTIVE: -T othr                ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=2du                                    &;
        gtss;wmc -r :ACTIVE: -T 2du                ';
  fi
  alias gtm='gt --geometry=+0+0       --show-menubar --window-with-profile=PipsTestGnomTerm-DiffFont-D1NBxCf  --role=test                                   &;
        gtss;wmc -r :ACTIVE: -T test                ;
             gt --geometry=-0+0       --show-menubar --window-with-profile=PipsOthrGnomTerm-TestFont-CCIHPS8  --role=muz    --working-directory=muz/U2b     &;
        gtss;wmc -r :ACTIVE: -T muz                 ;
             gt --geometry=+0-0       --show-menubar --window-with-profile=PipsCkm8GnomTerm-NiceFont-DC9LDaPt --role=mvz    --working-directory=mvz/U2b     &;
        gtss;wmc -r :ACTIVE: -T mvz                ';
  alias gti='gtI;gtss;chv1;gtss;gtm;gtss;chv2;gtss;gt3;gtss;chv3;gtss;gt3;gtss;chv0';
fi
#lias gti='gtI;sleep 3;wmctrl -o 1280,0;sleep 3;gt3;sleep 3;wmctrl -o 2560,0;sleep 3;gt3;sleep 3;wmctrl -o 3840,0;sleep 3;gt3;sleep 3;wmctrl -o 0,0';
# abov are new Ubu14.10 GT aliasz tstd on Chun; mA nEd geom chgz 4 Akuz 2 monitorz; tryd 2 ch d8ok profile 2 autorun d8ok nstd of zsh but can't figure out yet;
#   mIt also want 2 try 2 figure out how 2 autom8 dangling d8ok over edge && Dflt visible on all wrkspcz && hide wndw bordr tItlbar;
# according 2 HTTP://AskUbuntu.Com/questions/41093/is-there-a-command-to-go-a-specific-workspace I can send Ckm8+Othr GTz 2> wrkspcz wi wmctrl or xdotool:
#   Chun:`wmctrl -d`:0  * DG:  5120x800   VP: 0,0  WA: 73,24 1207x776   N/A; thN wmctrl -o 0,0 or 1280,0 or 2560,0 or 3840,0 for 4Compiz ViewPorts in1 DsktpGrp
#    Aku:`wmctrl -d`:0  * DG: 15360x2160  VP: 0,0  WA:  0,24 3840x1056  N/A; thN_1920, 3840, _5760, 7680, _9600, 11520, _13440, 15360; rEspAcd2alIn both dimz
#     add`wmctrl -b add,sticky,below` after -r IdNtify d8ok window or just :ACTIVE: after spawnd; d8ok wmctrl -e -1,664,1004 [geom +664(-0|+1004)] &&-e +2586-0
# old WindowMaker wharf ATerm buttons (the latter being specialized for my PTok clock)
#    aterm -bg #03071B -fg #88F8B0 --cursorColor #30D0F0 --cursorColor2 #204080 -color3 #FF9911 -color13 #AA22BB -pr #D8D870 -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 -vb -fn                "-*-*-*-*-*-*-15-*-*-*-*-*-*-*" -fb                "-*-*-*-*-*-*-19-*-*-*-*-*-*-*"
# ptokterm -bg #03071B -fg #88F8B0 --cursorColor #30D0F0 --cursorColor2 #204080 -color3 #FF9911 -color13 #AA22BB -pr #D8D870 -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 -vb -fn "-ttf-lucida console-*-*-*-*-47-*-*-*-*-*-*-*" -fb "-ttf-lucida console-*-*-*-*-48-*-*-*-*-*-*-*" -geometry 27x1+492+972
At() { echo At params without residue: 11,12,17,18,20,22,23,28,31,32,40,41,49 \n mixr bar Gen: At 17, 44x3+0+950 Eiji: 105x3; # no border, always top
 #if [[ "$1" == "" ]]; then aterm -geometry 80x30 -color3 "#FFAA33" -color13 "#9933BB" -bg "#03071B" -fg "#88F8B0" --cursorColor "#30D0F0" --cursorColor2 "#204080" -pr "#D8D870" -vb -fn "-ttf-DejaVu Sans-*-*-*-*-18-*-*-*-*-*-*-*" -fb "-ttf-DejaVu Sans-*-*-*-*-18-*-*-*-*-*-*-*" -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 &; #2>&1 >/dev/null &;
  if [[ "$1" == "" ]]; then aterm -geometry 80x30 -color3 "#FFAA33" -color13 "#9933BB" -bg "#03071B" -fg "#88F8B0" --cursorColor "#30D0F0" --cursorColor2 "#204080" -pr "#D8D870" -vb -fn "-*-*-*-*-*-*-18-*-*-*-*-*-*-*" -fb "-*-*-*-*-*-*-18-*-*-*-*-*-*-*" -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 &; #2>&1 >/dev/null &;
  else                      aterm -geometry 80x30 -color3 "#FFAA33" -color13 "#9933BB" -bg "#03071B" -fg "#88F8B0" --cursorColor "#30D0F0" --cursorColor2 "#204080" -pr "#D8D870" -vb -fn "-*-*-*-*-*-*-$1-*-*-*-*-*-*-*" -fb "-*-*-*-*-*-*-$1-*-*-*-*-*-*-*" -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 2>&1 >/dev/null &;
  fi}
alias tStl='tStc R;ec;tStc R d;ec;tStc R a;ec;tStc R l'; # loop all 4 colr layrz, leaving Lite last, calling just Reverse to pretend lower L indic8s bkgrounds
alias tStL='tStc F;ec;tStc F D;ec;tStc F A;ec;tStc F L'; # loop all 4 colr layrz, leaving Lite last, calling just Fraktur which probably rarely does anything
tStc() { # tSt 8pal8 colrz (this is a very slow precursor to ~/bin/tstc since many sub-processes need to load zsh,perl,&&a8 d8a just to manipUl8 eScApe valUez)
  if       [[ "$#" -gt 0 ]]; then # print out some help text for just h or -h or --help as first parameter && then return
    if     [[ "$1" == *h ]] || [[ "${(L)1}" == *help ]]; then # this function was originally named 'tS8()' but has been renamed to reflect similarity to `tstc`
      echo 'tStc crE8d by PipStuart <Pip@CPAN.Org> to tSt the display of 8pal8 (64-of-256) colors && terminal attributes;'
      echo " h - print out this Help text && then return; This version is a zshell function meant to be similar to tstc."
      #cho "     Any number of the parameter options below can be combined together (without spaces) as a single string.";  # not yet!
      echo "     Only one parameter is checked for so far, but l8r combin8ions may behave more like tstc (using regexes)."
      echo " s -             Squeeze each of the 4 2pal8s onto a single line (if terminal has at least 160 columns)"
      echo " z -             check roundtripZ of each 8pal8 color code going through S && c to be back to the same (slo)"
      echo " b - call S '^'  reset Bold making all fonts normal 4 colrs gr8rthan 15 (dfalt is Bold for all gr8rthan 7)"
      echo " A - call S ':A' set fAint SelectGraphicRendition attribute on all colrs printed after the 1st 2pal8"
      echo " I - call S ':I' set Italics             (most parameter flags can be combined like 'IFDOCURL' top8)"
      echo " U - call S ':U' set Underline           (see 'tsgr' for my typical mapping of all these attributes)"
      echo " L - call S ':L' set bLink               (slow,lessthan 150/min) # can give second param 'DAL' layer"
      echo " K - call S ':K' set blinK               (fast,morethan 150/min) ever supported?"
      echo " R - call S ':R' set Reverse             " # 2du:xtnd main gener8ion thru FDAL;" # or mAB optn 2 invrt 2 bdal nstd
      echo " V - call S ':V' set inVisible"  ; # lookz like var form uses fnmatch where '*' is like a glob, not prev mod && `man regex` DscrIbz the =~ 4m@
      echo " C - call S ':C' set Crossed-out"; # pure bash: HTTP://StackOverFlow.Com/questions/13043344/search-and-replace-in-bash-using-regular-expressions
      echo " F - call S ':F' set Fraktur  font       (hardly ever supported)"; #hello=ho02123ware38384you443d34o3434ingtod38384day
      echo " D - call S ':D' set underline Double    (!Gnome-Term supported)"; #re='(.*)[0-9]+(.*)'; # zsh has just $match versus $BASH_REMATCH
      echo " M - call S ':M' set fraMed              (hardly ever supported)"; #while [[ $hello =~ $re ]]; do hello=${BASH_REMATCH[1]}${BASH_REMATCH[2]}; done
      echo " E - call S ':E' set Encircled           (hardly ever supported)"; #echo "$hello"; # yields just letters
      echo " O - call S ':O' set Overlined           (!Gnome-Term supported)"; #   or        | perl -pe  's/[a-z]/X/gi and s/[0-9]/N/g' for even more familiar
      echo " H - call S ':H' set ideogram line rigHt (hardly ever supported)"; # echo $MyVar | sed -e 's/[a-zA-Z]/X/g' -e 's/[0-9]/N/g' should be even easier
      echo " T - call S ':T' set ideogram line lefT  (hardly ever supported)"; # might be able to loop all paramz && construct ordrd flagz from pasd SGR codz
      echo " G - call S ':G' set ideoGram stressmark (hardly ever supported)";return 0;fi;fi # ${variable//pattern/replacement} basic shL regX from StakOvrflO
  for B64N in k r O g c b P w K R Y G C B M W   e h o d t s p i E H y D T S m I   '.' f u a z n l j '_' F U A Z N L J   0 2 4 6 8 x v q 1 3 5 7 9 X V Q;do
      LAYR="F"; # setup some default && optional equals  =altern8 8pal8 64 Layer from Foreground through Dark, Avrg, Lite
    if     [[ "$#"        -ge   2 ]] && [[ "${(L)2}" == *d  ]]; then LAYR="D"; # could just give F first param && also OH layers as second
    elif   [[ "$#"        -ge   2 ]] && [[ "${(L)2}" == *a  ]]; then LAYR="A";
    elif   [[ "$#"        -ge   2 ]] && [[ "${(L)2}" == *l  ]]; then LAYR="L";
    elif   [[ "$#"        -ge   2 ]] && [[ "${(L)2}" == *o  ]]; then LAYR="O"; # trying Orig && High layerz too
    elif   [[ "$#"        -ge   2 ]] && [[ "${(L)2}" == *h  ]]; then LAYR="H"; fi
                                           S "$LAYR:$B64N"    ; # inject new layer codes which will collide with available renditions Doublundrlin,fAint,bLink
    if     [[ "$#"        -ne   0 ]] && [[ "${(L)1}" == *s  ]]; then # check for Squeeze rowz parameter to try to fit each 16 2pal8 on just 4 linez instead
                           echo     -n       "$B64N=";      # parameter testz BlO wrapd in starz so they can then all be combined together within 1st arg
    else                   echo     -n       "$LAYR:"; fi   # when in Short mode, skip layer colon && just try to show Base64 Name of single color abbreV8ionz
    if     [[ "$COLUMNS"  -ge  96 ]]; then                  # if terminal should be wide enough to not wrap the linez, then show duplic8 code 4 comparison
      if   [[ "$#"        -eq   0 ]] || [[ "${(L)1}" != *s  ]]; then # check for Squeeze rowz parameter to try to fit each 16 2pal8 on just 4 linez instead
        if [[ "$#"        -eq   0 ]] || [[ "${(L)1}" != *z  ]]; then # normally echo initial duplic8 fast unless -z flag given to check roundtripZ slowly
                           echo     -n       "$B64N="; #*z* really need to learn shell regexes instead of trying double-glob, or send through g grep or sed?
        else                               S "$LAYR:$B64N"|c  ; echo -n '=';fi;fi;fi # didn't nEd2 ec -n wi bktix around S abov or BlO4 Bold&&fAint&&etc pRamz
                           printf "%-8s"  `S  $LAYR:$B64N |sS d`; # just substitute out && show intrnl Digitz && semicolonz from current colr's eScape code
    if     [[ "$#"        -gt   0 ]]; then # starting non-1st 8 row on next loop iter8ion && a parameter was given
      if   [[ "${(L)B64N}" ==  w  ]] || [[ "${(L)B64N}" == i ]] || [[ "${(L)B64N}" == j ]] || [[ $B64N == q ]]; then
        if [[ "${(L)1}"    =~  b  ]]; then S '^'     ;fi       # reset Bold making all fontz normal 4 colrz gr8rthan 15 (dfalt is Bold for all gr8rthan 7)
        if [[     "$1"     =~  A  ]]; then S ':A'    ;fi       # set fAint SelectGraphicRendition attribute on all colrz printed after the 1st 2pal8
        if [[     "$1"     =~  I  ]]; then S ':I'    ;fi       # set Italics                   (&& accept upper or lowercased parameterz for any of these)
        if [[     "$1"     =~  U  ]]; then S ':U'    ;fi       # set Underline                 (see `tsgr` for my typical mapping of all these attributez)
        if [[     "$1"     =~  L  ]]; then S ':L'    ;fi       # set bLink                (slow,lessthan 150/min)
        if [[     "$1"     =~  K  ]]; then S ':K'    ;fi       # set blinK                (fast,morethan 150/min)
        if [[     "$1"     =~  R  ]]; then S ':R'    ;fi       # set Reverse
        if [[     "$1"     =~  V  ]]; then S ':V'    ;fi       # set inVisible            # would be nicer to regex on these to more easily allow combind flagz
        if [[     "$1"     =~  C  ]]; then S ':C'    ;fi       # set Crossed-out
        if [[     "$1"     =~  F  ]]; then S ':F'    ;fi       # set Fraktur font         (hardly ever supported)
        if [[     "$1"     =~  D  ]]; then S ':D'    ;fi       # set underline Double     (hardly ever supported)
        if [[     "$1"     =~  M  ]]; then S ':M'    ;fi       # set fraMed               (hardly ever supported)
        if [[     "$1"     =~  E  ]]; then S ':E'    ;fi       # set Encircled            (hardly ever supported)
        if [[     "$1"     =~  O  ]]; then S ':O'    ;fi       # set Overlined            (hardly ever supported)
        if [[     "$1"     =~  H  ]]; then S ':H'    ;fi       # set ideogram line rigHt  (hardly ever supported)  (this just uprcase2provide help at top)
        if [[     "$1"     =~  T  ]]; then S ':T'    ;fi       # set ideogram line lefT   (hardly ever supported)
        if [[     "$1"     =~  G  ]]; then S ':G'    ;fi;fi;fi # set ideoGram stress mark (hardly ever supported)
    if     [[ "$#" -gt 0 ]] && [[ "${(L)1}" == *s  ]] && [[ "$COLUMNS" -ge 160 ]]; then # check AgN for Squeezed rowz parameter to only newline aftr each 2pal8
      if   [[      $B64N   ==  W  ]] || [[      $B64N   == I ]] || [[      $B64N   == J ]] || [[ $B64N == Q ]]; then echo;fi
    elif   [[ "${(L)B64N}" ==  w  ]] || [[ "${(L)B64N}" == i ]] || [[ "${(L)B64N}" == j ]] || [[ $B64N == q ]]; then echo
    elif   [[ "$COLUMNS"  -ge 110 ]]; then                       # maybe above testz could be replaced with a regex like =~ /^[wij]$/i && just q still sepR8?
      if   [[      $B64N   !=  Q  ]]; then echo -n '  ';fi       # only dblspace them out if term is wide enough
    elif   [[      $B64N   ==  Q  ]]; then echo        ;fi;done} # && finish with newline if term is narrow (although wrapping at likely 80 should look same)
  # 2du:contMpl8 adng au, agr, && ee ene around en;
wh8()   {  LP_F='0'; # same as wh8ch BlO but wi 8rows flipd2 8columns,othrwIz very similR (mAwant2add pRamz2du mor than just disabl colr,sinc sS duzfIn)
  # 2du:contMpl8 adng au, agr, && ee ene around en;
  if       [[ "$#" -gt   0 && "${(L)1}" =~  h  ]]; then echo -n " wh8 - show WHich primary single b64 && other valued commands by:$auth vers:$vers d8VS:$d8VS;
  h  - print out this basic Help text message then return; Any parameter other than h right now just strips colors && SGR attributes out;";return 0;fi
  for B64N in 0 8 G O W e m u   1 9 H P X f n v   2 A I Q Y g o w   3 B J R Z h p x   4 C K S a i q y   5 D L T b j r z   6 E M U c k s '.'   7 F N V d l t '_'   mk sz pu po pdoc ka pe  pa pla plb pab ag  drkh gg dv ac acs apts  auu aar ai dirz ic  s8 d2u u2d del copy move attrib  s8n grp asci utf8 u8 CC CCC cls  eg zg hX k9 pp lS mo md rd  dm ct chm cho chg chr chs chf cht  mnt umnt bk c8 zc d8 fp  fixfont g8 gaa gcm gac  gacm gpom caln l8 sl calq calQ cln  cl comma hd dif loc8 dic zp ud  updb upd8db up updt uptm ec en  uni cncl tl tp wd pw pn pb msg  ren wh lsm lsc lsp lsu xical S8  srchl shlp shl sho  p47 a7 rr tt tf gtt viii  lc chv0  uc chv7  ss  wmc resp ctor scrn sx gt  xt st uxtrm uxt lxt  lxtrm satrm sak tn8r  xf4t rox Etrm  x4t rxt Et un ev pl  xbk xb xbsf  kp   xdt s2 s28 sb sd si  au agr; do
 # crmm='chromium-browser  ';alias crom=' google-chrome         ';alias epip='epiphany';alias aror='arora';alias dilo='dillo';alias lnx2='links2';
 # brav='brave';brvb='brave';alias brv='brave';alias bb='brvb';alias irc='irssi'; # prEferprv8bb&&ffmornow
 # 2lo=' perl -e "rename(\$_,lc) for @ARGV"'; # orig fIlnAm lOwrcAsng 1-lInr was ~/bin/tolo thN as 2lo but mAB zsh func can't stRt wi '2'? Alias workz tho!
 # glxg='glxgears -info -geometry 1920x1056+0+0'; # had to agi libssl-dev to configure opusfile, then below should be good to compress speech for Dad
    if     [[ "$#" -eq   0                             ]]; then echo -n `S $B64N`; # also below tries to strip out all contained newlines
      if   [[ $B64N =~ ^([bk]|pp|rr|ss|CC|[ag][ag]|tt) ]]; then echo -n `S  w   `; # 4many dbld nAmz,try wHITE unlS 2nd char is w so thN try blacK nstd
        if [[ $B64N =~ ^([a-zA-Z]w)                    ]]; then echo -n `S  K   `;fi;fi;fi; BNWH=`which $B64N`  ;BNWH=${BNWH:s/      e    / e };
    if     [[ $LP_F =~ ^[0]$        ]]; then BNWH="$BNWH ";BNWH=${BNWH:s/ Et /    Et   };BNWH=${BNWH:s/tiny /tiny}  ;BNWH=${BNWH:s/ whereis /whereis };
      if   [[ $B64N =~ ^[_]$        ]]; then LP_F='1';fi  ;BNWH=${BNWH:s/h       /   h    };BNWH=${BNWH:s/k9      /   k9   }; #n LoopPast_undrscorFlag4 64
    fi;BNWH=${BNWH:s/ aliased to /alias2\'} ;BNWH="$BNWH'";BNWH=${BNWH:gs/	/  };BNWH=${BNWH:s/2\'apt                     /2\'apt}; # EndSpaceLoopCount
    BNWH=${BNWH:s/\'lsd8 \'/\'   lsd8 \'}   ;BNWH=${BNWH:s/ls  -F \'/  ls -F \'};BNWH=${BNWH:s/\'ls      /\'ls}     ;BNWH=${BNWH:s/    q /q};BNWH=${BNWH:gs/
/}; if     [[ $LP_F =~ ^[1]$        ]]; then BNWH=${BNWH:s/     /};BNWH=${BNWH:s/              \&/\&}               ;BNWH=${BNWH:s/--geom/ --geom};
      for ESLC in 0 1 2 3; do BNWH=${BNWH:s/2\' /2\'};BNWH=${BNWH:s/ \'/\'};done;BNWH=${BNWH:s/ \'/\'}          ;BNWH=${BNWH:s/    --geom/ --geom};
      BNWH=${BNWH:gs/  uname/uname};BNWH=${BNWH:s/  uname -a    return 0  /uname -a;return 0};fi                ;BNWH=${BNWH:s/160     -r 50  /160 -r 50};
    BNWH=${BNWH:s/ shell built-in command \'/ shel biltin cmd}    ;BNWH=${BNWH:s/ not found\'/: !not found! cmd};BNWH=${BNWH:s/srchl    -i/srchl -i};
    BNWH=${BNWH:s/\'ls      /\'ls} ;BNWH=${BNWH:s/  --geometry=160x50   \&/ --geometry=160x50 \&};
    BNWH=${BNWH:s/uxterm     -geometry 160x50   \&/uxterm -geometry 160x50 \&}  ;BNWH=${BNWH:s/git  ad/git ad}  ;BNWH=${BNWH:s/gaa; gcm/gaa;gcm};
    if     [[ "$COLUMNS" -lt 160    ]]; then  # brkngdn nwlnz from funcz mA lose nEded';'semiz,so leave actual nwlnz insIdof var asInmNt regX subst optnz&&alIn
      if   [[ $B64N =~ ^v8$         ]]; then BNWH=${BNWH:  s/elif/elif
};    elif [[ $B64N =~ ^ss$         ]]; then BNWH=${BNWH:  s/    then/ then
};    fi;fi # below left-to-right order of or 80-column limits then and with not wide then back to or for main dflt 160-colm limits
    if     [[ $B64N =~ ^([SXqwc]|[cdfg]8|hd|dic|mutt)$ ]]; then BNWH=${BNWH:gs/ /};BNWH="$B64N= ${BNWH:gs/\'/}";fi # subst to just chop end space?
    if     [[ $LP_F =~ ^[0]$        ]]; then printf "%-18s" $BNWH; else echo -n $BNWH;fi # mAB try2!pad up past top64
    echo -n `S W`';'; # tried2add /bin/ matchz wi $ end but syntax && escaping must be somewhat unconventional, probably nEd2rEd&&stuD mor PCRE dox
    if     [[ $B64N =~                                ^(pb|zg|wd|lsm|lsu|srchl|shl|resp|ctor|tt|lc|uc|wmc)$ ]] ||
           [[ $B64N =~ ^[OPQRSTUV]$ ]] || [[ $B64N =~ ^(pu|pla|plb|drkh|auu|del|mo|chm|chg|ct|caln|dif|loc8)$ ]] &&
           [[ "$COLUMNS" -lt 160    ]] || [[ $B64N =~ ^(pe|apts|ag|ic|attrib|cls|rd|cht|fp|gac|cln|ud|en|msg|sho|viii|[Sv]8|ss)$ ]] ||
           [[ $B64N =~ ^[uvwxyz._]$ ]] || [[ $B64N =~ ^(gt|lxt|tn8r|Etrm|pl|kp|agr|chv7|xbsf)$ ]]; then echo $z;fi;done}
wh8ch() { # see which most basic 64 single-character commands are mapped to what (majority being aliases, then just a few built-in or not yet found commands)
  for B64N in 0 1 2 3 4 5 6 7  8 9 A B C D E F  G H I J K L M N  O P Q R S T U V  W X Y Z a b c d  e f g h i j k l  m n o p q r s t  u v w x y z '.' '_'; do
    if     [[ "$#" -eq   0          ]]; then echo -n `S $B64N`; # BlO set to dark wHITE for invisibly dark BLACk b64 number to color (leave bLUE 4now)
      if   [[ $B64N =~ ^[k]$        ]]; then echo -n `S  w   `;fi;fi   ;BNWH=`which $B64N`" '"; # 4 b64,on sepR8lInzUsed2:export A=`S A`;echo -n "$A A:";wh A;
    BNWH=${BNWH:s/ aliased to /alias2\'} ;BNWH=${BNWH:s/      e   / e} ;BNWH=${BNWH:s/ whereis/whereis}; # cud :gs// 4glbl or ${BNWH//litrl/subst} 4nonwIldcRd
    BNWH=${BNWH:s/\'lsd8 \'/\' lsd8   \'};BNWH=${BNWH:s/tiny \'/tiny\'};BNWH=${BNWH:s/ls  -F \'/  ls -F \'};BNWH=${BNWH:s/\'Et \'/\'   Et   \'}; # alIn quOtz
    BNWH=${BNWH:s/ shell built-in command \'/shel biltin cmd}          ;BNWH=${BNWH:s/ not found \'/ cmd not found}; # mA want2add Xtra colrz4thEs?
    if     [[ $B64N =~   ^[SXcqw_]$ ]]; then BNWH="$B64N= ${BNWH:gs/ \'/}";fi;printf "%-18s" $BNWH;echo -n `S W`';'; # biltin printf
    if     [[ $B64N =~ ^[3BJRZhpx]$ ]] && [[ "$COLUMNS" -lt 160 ]] || # addXtra nwlnz 4orig 80colm mOd,fitz 64 mapz on 16lInz in 80x18 nIcely wrapd in prmptz
           [[ $B64N =~ ^[7FNVdlt_]$ ]]; then echo;fi;done} # !sureYsomtImz`wh`rEcursvlyXpndz alias pRamz whIl biltin`which`duznot
goo() { w3m "HTTP://Google.Com/search?q=$1+$2+$3+$4+$5+$6+$7+$8"     ; } # should probably pass $@ =~ s/ /+/g; or something smarter than this
mcp() { if [[ $# -gt 2 ]] && [[ ! -d ${$#} ]]; then    /bin/cp $@ .  ; return 0; fi; # adds a basic many-argument form of `cp` where all parameters are remote
                                                       /bin/cp $@    ; }             #   files to be copied into the current directory
src() {    [[ $# -lt 1 ]] && {                source         ~/.zshrc; return 0; }   # reload main shell resource file, or load parameter filename of script
                                              source           $@    ; }
xrc() {    [[ $# -lt 1 ]] && {                  xrdb  -merge ~/.Xrc  ; return 0; }   # merge  main X.Org resource file, or load parameter filename of altern8
                                                xrdb  -merge   $@    ; } # tryd2auto-call xrc at startx in .xinit but doesn't work so calling here BlO instead
un()  {    [[ $# -lt 1 ]] && {                 uname  -a             ; return 0; }   # should eventually c8 filter all uname output to add colrz && f0ntz
                                               uname           $@    ; }
if         [[ "$DISPLAY" != ""  ]];                                     then xrc; fi; # since Ubu14.10UUX11!srcing   .xinit,just rElOd .Xrc 4evry nonconsol zsh
mc()  { # used to be mcd for Mk&&ChDir on $1 but just MakeChng, MkCh is nicer, && now also does MvFil $1 into && ChDir $2
  if       [[ $#        -eq  2  ]] && [[   -f "$1" ]] && [[ -d "$2" ]]; then
    if     [[           -d "$2" ]];                                     then mv $1 $2; cd $2;
    elif   [[ "$VERBOSE" ==  1  ]];                                     then echo "!*EROR*! Cannot MvFil $1 into ChDir $2!";                fi
  elif     [[ $#        -eq  1  ]] && [[ ! -f "$1" ]];                  then
    if     [[ !         -d "$1" ]];                                     then md $1;
    elif   [[ "$VERBOSE" ==  1  ]];                                     then echo "!*EROR*! Cannot MkDir $1!";                              fi
    if     [[           -d "$1" ]];                                     then           cd $1;
    elif   [[ "$VERBOSE" ==  1  ]];                                     then echo "!*EROR*! Cannot ChDir $1!";                              fi
  elif     [[ "$VERBOSE" ==  1  ]];                                     then
    echo   "!*EROR*! Invalid arguments to either Mk&&ChDir $$1 (DrNm) or Mv $$1 (FlNm) to existing Dir $$2 (DrNm) before ChDir into DrNm!"; fi}
Xv8() { if   [[  $#       -ge  1  ]]; then export Hv8f="$1";                fi} # just Xport first param as Hv8f
v8()  { if   [[  $#       -ge  1  ]]; then export Hv8f="$1"; $HEdt  $@    ;     # try2 lOd pRam in2 %ENV 4 U8:upd8 2 autO-Use 4 tSt aftr editing
        elif [[ "$Hv8f"    != ""  ]]; then                   $HEdt  $Hv8f ; fi} #   maybe better to save $@ instead then split on spaces for multiple files
mn()  { if   [[  $#       -ge  1  ]]; then export Hmpt="$1"; man    $@    ;     # try2 lOd pRam in2 %ENV 4 ManPageTopic to be revisited on subsequent calls
        elif [[ "$Hmpt"    != ""  ]]; then                   man    $Hmpt ; fi} # shud also add $Hv8l && $Hmtl for Last valuez 4 !-e 'l' 2 jump bak 2
m423(){ # convert m4a filez to mp3 using ffmpeg, was originally bash script in ~/bin/m4a2mp3 derived from HTTP://UbuntuForums.Org/showthread.php?t=1643093 ;
  for M4FN in $@
  do  if  [[ -f "$M4FN" ]] && [[ "$M4FN" == *.m4a ]]; then M4BN=`basename "$M4FN" .m4a`; # echo "M4FileName:$M4FN:"; echo "M4BaseName:$M4BN:";
      ffmpeg -i "$M4FN" -acodec libmp3lame -ac 2 -ab 256k -ar 44100 "$M4BN.mp3"; else echo "!*EROR*! Parameter:$M4FN not found as .m4a file!"; fi; done}
#lias sslbox=' ssLBox' ; alias ssLBox='                ssh LBox.Org'; #216.158.99.146; #old 9PNet.Com download:screwyou;
alias sstaki=' ssTaki' ; alias ssTaki='                ssh Taki' ; # SShortcuts to my main machines based on /etc/hosts entries to map names to IP addresses
alias sstakiw='ssTakiW'; alias ssTakiW='               ssh TakiW'; # might be better to unify these to ping Taki then TakiW 2DcId wich IP&&IF 2auto ssh in2
alias sschunw='ssChunW'; alias ssChunW='               ssh ChunW';
alias sschun=' ssChun' ; alias ssChun='                ssh Chun' ;
alias ssryu0=' ssRyu0' ; alias ssRyu0='                ssh Ryu0' ;
alias ssken0=' ssKen0' ; alias ssKen0='                ssh Ken0' ;
alias ssken='  ssKen'  ; alias ssKen='                 ssh Ken'  ;
alias ssryu='  ssRyu'  ; alias ssRyu='                 ssh Ryu'  ;
alias ssaku='  ssAku'  ; alias ssAku='                 ssh Aku'  ;
ldh()      { DHst='Aku'; # LoadDestin8ionHost cking if AkuChunRyuKenTaki are!current host&&are on net to select ss && rsyn targetz  # BlO PingDestin8ion4Errorz
             if     [[ "${(L)HHst}" ==  aku   ]]; then echo "LoadDestin8ionHost() checking net..." ;DHst='ChunW';PD4E=`pn -c 1 -q $DHst|g error`;
               if   [[ "$PD4E"      != ""     ]]; then printf "DHst:%-5s had PD4E:%s\n" $DHst $PD4E;DHst='Chun' ;PD4E=`pn -c 1 -q $DHst|g error`; fi;
               if   [[ "$PD4E"      != ""     ]]; then printf "DHst:%-5s had PD4E:%s\n" $DHst $PD4E;DHst='Ryu'  ;PD4E=`pn -c 1 -q $DHst|g error`; fi;
               if   [[ "$PD4E"      != ""     ]]; then printf "DHst:%-5s had PD4E:%s\n" $DHst $PD4E;DHst='Ken'  ;PD4E=`pn -c 1 -q $DHst|g error`; fi;
               if   [[ "$PD4E"      != ""     ]]; then printf "DHst:%-5s had PD4E:%s\n" $DHst $PD4E;DHst='TakiW';PD4E=`pn -c 1 -q $DHst|g error`; fi;
               if   [[ "$PD4E"      != ""     ]]; then printf "DHst:%-5s had PD4E:%s\n" $DHst $PD4E;DHst='Taki' ;PD4E=`pn -c 1 -q $DHst|g error`; fi;
               if   [[ "$PD4E"      != ""     ]]; then printf "DHst:%-5s had PD4E:%s\n" $DHst $PD4E; fi; fi;export DHst; } # 2du:add colrz&&f0ntz&&logic4!Aku
ss()       { # SShortcut where empty goes to DHst ('Aku' 4all hostz!Aku, && best host that pingz 4Aku)
             if     [[ "$1"         == ""     ]]; then ldh;
               if   [[ "$DHst"      != ""     ]]; then ssh $DHst; fi;
             else                                      ssh $@   ; fi; } # sudo belo may now req -E 2 prEsrv calling Environment since upd8 2`sudo zsh`did;
pmei()     { if     [[ "$HUsr"      != "root" ]]; then sudo perl -MCPAN -e        "install  '$@' ";      # pronounced:"Perl"  .  "Mei"
             else                                           perl -MCPAN -e        "install  '$@' "; fi } #   lyk"Pai"."Mei" inKillBill
pmfi()     { if     [[ "$HUsr"      != "root" ]]; then sudo perl -MCPAN -e "force('install','$@')";      # pronounced:"Perl"  .  "MFfFi"
             else                                           perl -MCPAN -e "force('install','$@')"; fi } #   lyk"Pai"."MeFsckngForcei"
pmverck()  { cpan -D $1; } # used to check with perl -MExtUtils::MakeMaker -le 'print MM->parse_version(shift)' $1; but that old method no longer seems to work
alias  pdoc='perldoc'; # used to have problem with most needing -t for text-only version (not pod2man | nroff -man | $PAGER) or to just pipe thru less instead
alias prsyn='rsyncmd'; # PRint RSYN
rsyncmd()  {                                                echo      "rsync -avr  --files-from=dox/putr/RsynCore.ls . DstH:"; # common rsyn cmd
                                                            echo      "  add    -n 4dryruN 2tst, add --delete usually when SrcH is Aku 2propag8,";
                                                            echo      "  s/Core/Full/ between AkuRyuKen, might want SrcH: not just s/^/cd;/ then . ;";
                                                            echo   -n "rsync -avr  --delete --files-from=dox/putr/RsynCore.ls "|xclip -si -se p -l 1;}
rsyn()     { # rsync -n --dry-run 2tst,try --(in|ex)clude=PATRN or .='-from=FILE' also for  --files-from listng source filenmz,-t rEdundnt but -tavrn EZ2rEmMbr
             #sEF="--exclude='*.swp' --files-from=dox/putr"; # Rsyn Exclude && FilesFrom parameter (tries to start getting all of ~?)
             #sEF="                  --files-from=dox/putr"; # Rsyn Exclude && FilesFrom parameter (any $RsEF Xpansion BlO echoz good but hOsez rsync)
             #sEF="--exclude='*.swp'";                       # Rsyn Exclude && FilesFrom parameter (could!prECd&&pRTaly includ --files-from=dox/putr mAB4=*'?)
             if     [[ "${(L)HHst}" ==  aku   ]]; then # empty rsyn from Aku2top DHst 4now,$1 alt-host,l8r $2 -n && !--delete from other hosts bak2Aku
               if   [[ "$1"         == ""     ]]; then ldh; #     pu ~;rsync -avr  --delete --files-from=dox/putr/RsynFull.ls . $DHst:;po; # BlOwuz thisB4 RsEF
                 if [[ "${(L)DHst}" ==  ryu*  ]] || [[ "${(L)DHst}" ==  ken*   ]]; then # dsktpz get Full, laptopz get Core
                                                                  pu ~;rsync -avrn --delete --files-from=dox/putr/RsynFull.ls . $DHst:;po; # top4 callz were!-n
                                                            echo "pu ~;rsync -avrn --delete --files-from=dox/putr/RsynFull.ls . $DHst:;po;";
                 else                                             pu ~;rsync -avrn --delete --files-from=dox/putr/RsynCore.ls . $DHst:;po;
                                                            echo "pu ~;rsync -avrn --delete --files-from=dox/putr/RsynCore.ls . $DHst:;po;"; fi;
               elif [[ "${(L)1}"    ==  ryu*  ]] || [[ "${(L)1}"    ==  ken*   ]]; then # include full dvl,gfx,gmz,muz,mvz,.inst 2dsktpz (.arc nEdz root)
                                                                  pu ~;rsync -avrn --delete --files-from=dox/putr/RsynFull.ls . $1:   ;po;
                                                            echo "pu ~;rsync -avrn --delete --files-from=dox/putr/RsynFull.ls . $1:   ;po;";
               elif [[ "${(L)1}"    ==  chun* ]] || [[ "${(L)1}"    ==  taki*  ]]; then # should be m/.*w?$/i (mAB all should just be [arkct]* thru HHstAlESz)
                                                                  pu ~;rsync -avrn --delete --files-from=dox/putr/RsynCore.ls . $1:   ;po; # !sure if2Xclud.swp
                                                            echo "pu ~;rsync -avrn --delete --files-from=dox/putr/RsynCore.ls . $1:   ;po;";
               else                                    ldh;       pu ~;rsync -avrn --delete --files-from=dox/putr/RsynCore.ls --exclude='*.swp' . $DHst:;po;
                                                            echo "pu ~;rsync -avrn --delete --files-from=dox/putr/RsynCore.ls --exclude='*.swp' . $DHst:;po;";
               fi
             else                                      ldh;       pu ~;rsync -avrn          --files-from=dox/putr/RsynCore.ls . $DHst:;po;
                                                            echo "pu ~;rsync -avrn          --files-from=dox/putr/RsynCore.ls . $DHst:;po;";
             fi; } # if !Aku then just -n dry-run Core back to Aku to see what would upd8 for a typical reverse direction
                   # might want to add -z if someday start syncing with remote hostz && consider sharing sskeyz instead of requiring pswrdz
uz() {   [[         $#  -lt  1    ]] && {
    if   [[ "$VERBOSE"   ==  1    ]]; then echo "!*EROR*! Nothing to   UnTarB?X?Zip! $0 file: ??!";                                           fi; return 1; }
               file=$1; succ=0;
  if     [[   -f             "$1" ]] && [[   -r            "$1" ]];                                                              then
    if   [[ "${file:e}"  ==  "xz" ]] || [[ "${file:e}" == "txz" ]];                                                              then # l8r detect unlzma too
      if tar xJvf $@ 2>/dev/null     ||                                unxz   $@ 2>/dev/null;                                    then succ=1; fi
    elif [[ "${file:e}"  ==  "bz" ]] || [[ "${file:e}" == "tbz" ]] || [[ "${file:e}" == "bz2" ]] || [[ "${file:e}" == "tbz2" ]]; then
      if tar xjvf $@ 2>/dev/null     || tar xvf  $@ 2>/dev/null    || bunzip2 $@ 2>/dev/null;                                    then succ=1; fi # was xIvf
    elif [[ "${file:e}"  == "zip" ]] &&                                unzip  $@ 2>/dev/null;                                    then succ=1;
    elif tar xzvf $@ 2>/dev/null     || tar xvf  $@ 2>/dev/null    || gunzip  $@ 2>/dev/null;                                    then succ=1; fi
    if   [[ "$VERBOSE"   ==   1   ]]; then
      if [    $succ                ]; then echo "-=Note=- Successfully UnTarB?X?Zipped file: $1!";
      else                                 echo "!*EROR*! Cannot       UnTarB?X?Zip    file: $1!";                               return    2; fi; fi
  elif   [[ "$VERBOSE"   ==   1   ]]; then echo "!*EROR*! Cannot read    TarB?X?Zip    file: $1!";                               return    4; fi }
function xpwd () { pwd | xclip -i; xclip -o ; } # maybe function keyword is unnecessary && redundant, or different somehow?
function xcd  () { cd             `xclip -o`; } # rsyncz(nw)? below were how I primarily made regular backups of my old Gentoo drives
rsyncz() { # As root,rsync current boot drive (/dev/sda) over to secondary (/dev/sdb),mounting 2nd in /z (if not already mounted).
  if [[              "$HUsr" == "root"                                        ]]; then # if !root user,print eror&&quit
    if [[             -e                                    "/tmp/sfdisk.sdb" ]]; then # rm      potentially   old         data-file
      echo           "Attempting to rm                       /tmp/sfdisk.sdb"
                                    rm                       /tmp/sfdisk.sdb
    fi
    if [[           ! -e                                    "/tmp/sfdisk.sdb" ]]; then # mk sure potentially   old         data-file was `rm`d 1st
      echo           "Attempting to sfdisk -l /dev/sdb 2>&1 >/tmp/sfdisk.sdb"
                                    sfdisk -l /dev/sdb 2>&1 >/tmp/sfdisk.sdb
      if [[           -r                                    "/tmp/sfdisk.sdb" ]]; then # mk sure prev `sfdisk` cmd created data-file successfully
        echo         "Attempting to grep -v LongDiskDataRgEx /tmp/sfdisk.sdb >/dev/null"
                                    grep -v "^$\|^Disk /dev/sdb: 38913 cylinders, 255 heads, 63 sectors/track$\|^Disk /dev/sdb: 182401 cylinders, 255 heads, 63 sectors/track$\|^Disk /dev/sdb: 243201 cylinders, 255 heads, 63 sectors/track$\|^Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0$\|^   Device Boot Start     End   #cyls    #blocks   Id  System$\|^/dev/sdb1   \*      0+     [36][012]      [36][123]-    [25][450][796]0[304][789][+ ]  83  Linux$\|^/dev/sdb2         [36][123]    [ 4][251][495][017]    [ 4][250][159][195]   [ 3][24][018][089][043][460][018]7+  82  Linux swap / Solaris$\|^/dev/sdb3       [ 4][251][495][128] \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+83  Linux$\|^/dev/sdb4 \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+[EL][mi][pn][tu][yx]$" /tmp/sfdisk.sdb >/dev/null
        if [[         "$?" != "0"                                              ]]; then
          echo       "$0 has confirmed expected partitions so proceeding..."
          if [[     ! -d                              "/z/boot"               ]]; then # if !mounted /dev/sdb3 /z     ,try to mount 1st
            echo     "Attempting to mount /dev/sdb3    /z               ..."
                                    mount /dev/sdb3    /z
          fi # should confirm sdb3 is mounted at this point
          if [[     ! -d                              "/z/boot"               ]]; then
            echo     "Attempting to mkdir              /z/boot          ... (as mount point for /dev/sdb1)"
                                    mkdir              /z/boot
          fi
          if [[       -d                              "/z/boot"               ]]; then
            if [[   ! -d                              "/z/boot/grub"          ]]; then # if !mounted /dev/sdb1 /z/boot,try to mount too
              echo   "Attempting to mount /dev/sdb1    /z/boot          ..."
                                    mount /dev/sdb1    /z/boot
            fi
            if [[   ! -d                              "/z/boot/grub"          ]]; then # if  still  !grub/ there,try2sync just /dev/sda1's /boot over alon 1st
              echo   "Attempting to rsync -av --delete /boot /z         ... (sda1 /boot to sdb1 since /z/boot/grub !found)"
                                    rsync -av --delete /boot /z
            fi # might also need --exclude='/home/pip/.gvfs' sometimes, since it can barf even to root, but easier to just umount .gvfs first when necessary
            if [[   ! -d                              "/z/boot/grub"          ]]; then # if *still* !grub/ there,eror out
              echo   "!*EROR*! $0 fails to mount /z && /z/boot well enough to rsync drives!"
            else
              if [[ ! -d                              "/z/proc"               ]]; then
                echo "Attempting to mkdir              /z/proc          ..."
                                    mkdir              /z/proc
              fi
              if [[ ! -d                              "/z/sys"                ]]; then
                echo "Attempting to mkdir              /z/sys           ..."
                                    mkdir              /z/sys
              fi
              if [[ ! -d                              "/z/z"                  ]]; then
                echo "Attempting to mkdir              /z/z             ..."
                                    mkdir              /z/z
              fi # should maybe loop through root dirz instead of huge [A-ort-v]?
              echo   "Attempting to rsync -av --delete /sbin          /z..."
                                    rsync -av --delete /sbin          /z
                 # E4SMD3Gc: maybe another point of reference for just getting desired root d8a to backup comes from:
                 #  HTTP://AskUbuntu.Com/questions/55968/add-new-hard-drive-to-mirror-existing-lvm-drive-with-raid1 : (reordered here to better see excludes)
                 # `sudo tar cvpzf bak.tgz --exclude=bak.tgz --exclude=/boot --exclude=/dev  --exclude=/etc/fstab --exclude=/etc/mtab --exclude=/lost+found
                 #                         --exclude=/media  --exclude=/mnt  --exclude=/proc --exclude=/sys /`
#x =exclude from above matching against my l8st Ubu14.04LTS `ls /`
# g=notglob from below && also not already done separ8ly above: /(boot|sbin)  ... so maybe should add separ8 /srv above with /sbin but still skip /sys
#   bin                                                                           although may be unnecessary since /srv seems empty
#x  boot
#   cdrom
#x  dev
#x  etc  (just /(fs|m)tab)
#   home
#   initrd.img
#   initrd.img.old
#   lib
#   lib32
#   lib64
#   libx32
#x  lost+found
#x  media
#x  mnt
#   opt
#xg proc
#   root
#   run
#   sbin
# g srv
#xg sys
#   tmp
#   usr
#   var
#   vmlinuz
#   vmlinuz.old
              echo   "Attempting to rsync -av --delete /[A-ort-v]*    /z..."
                                    rsync -av --delete /[A-ort-v]*    /z
            fi # takes ~8.5hours on 1.5Gb/s or ~4hours on empty 3Gb/s SATA to sync ~100GB, ~6hours for ~150GB
            echo     "Attempting to umount             /z/boot          ..."
                                    umount             /z/boot
            echo     "Attempting to umount             /z               ..."
                                    umount             /z
          fi # tidy up by unmounting
        else
          echo       "!*EROR*! $0 detected unexpected partition info in      /tmp/sfdisk.sdb!"
          echo       "  Unwilling to run rsyncz without verifying partitions.  Aborting..."
        fi
      else
        echo         "!*EROR*! $0 could not run sfdisk -l /dev/sdb to create /tmp/sfdisk.sdb!"
        echo         "  Unwilling to run rsyncz without verifying partitions.  Aborting..."
      fi
    else
      echo           "!*EROR*! $0 could not rm /tmp/sfdisk.sdb!"
    fi
  else
    echo             "!*EROR*! $0 must be run as root!"
  fi }
rsyncznw() { # As root,prep new 2nd drv. Old manual steps: fdisk /dev/sdb;p (2ck!already part'd),n,p,1,,32,a,1,n,p,2,,291,t,2,82,n,p,3,,33713,p (final ck),w;
             #                           mkfs.xfs /dev/sdb[13];mkswap /dev/sdb2;rsyncz (wait ~2hourz/50GB needed to copy);grub;root (hd1,0),setup (hd1),quit;
  echo "!*EROR*! $0 needs further testing before it should be enabled!"
  return 0
  if [[         "$HUsr" == "root"                  ]]; then # if !root user,print eror&&quit
    if [[       -e               "/tmp/sfdisk.sdb" ]]; then # rm      potentially old               data-file
      rm                          /tmp/sfdisk.sdb
    fi
    if [[     ! -e               "/tmp/sfdisk.sdb" ]]; then # mk sure potentially old               data-file has been removed first
      sfdisk    -l /dev/sdb 2>&1 >/tmp/sfdisk.sdb
      if [[     -r               "/tmp/sfdisk.sdb" ]]; then # mk sure previous `sfdisk` cmd created data-file successfully
        grep    "^No partitions found$\|^/dev/sdb[123]          0       -       0          0    0  Empty$" /tmp/sfdisk.sdb >/dev/null
        if [[   "$?"    == "0"                     ]]; then
          echo "Proceeding with automated partitioning of /dev/sdb for rsyncz purposes..."
          # if avail but !partz `sfdisk /dev/sdb << ~/dox/putr/ST320GB-(most|full)3-(7200.10|ES).prt` to create parts if drv is new
          # ,32,L,*       # example had << EOF then Ctrl-D as soon as 5th empty line was reached to send EOF
          # ,259,S        # maybe need Perl wrapper to regex output of -l to verify part list is that desired?
          # ,33422,L      # most3 is left,full3 below    Experiment with this auto-parting && grub-install on next new drv later.
          # ,0
          # EOF but maybe could just use ",32,L,*\n,259,S\n;\n;\nEOF" to tk rest of drv w/ sdb3 but mk sure unmounted&&partless 1st
          echo "sfdisk    /dev/sdb < ~/dox/putr/HrdDskDrvz/Smzg2TB-full4-7200.12-Samsung-HD203WI_-1AN1-243201cylzxO1-9CN3GBk.prt ..."
          #     sfdisk    /dev/sdb < ~/dox/putr/HrdDskDrvz/Smzg2TB-full4-7200.12-Samsung-HD203WI_-1AN1-243201cylzxO1-9CN3GBk.prt
          echo "mkfs.xfs  /dev/sdb1                                 ..."
                mkfs.xfs  /dev/sdb1
          echo "mkswap    /dev/sdb2                                 ..."
                mkswap    /dev/sdb2
          echo "mkfs.xfs  /dev/sdb3                                 ..."
                mkfs.xfs  /dev/sdb3
          echo "mkfs.xfs  /dev/sdb4                                 ..."
                mkfs.xfs  /dev/sdb4
          echo "rsyncz                                              ..."
                rsyncz
          echo "grub-install --root-directory=/ hd1                 ..."
                grub-install --root-directory=/ hd1
        else # I think the above should setup the boot-loader on a new drive but it might need /z(/boot)? instead.
          echo "!*EROR*! $0 found partitions on /dev/sdb!"
                sfdisk -l /dev/sdb
        fi
      else
        echo   "!*EROR*! $0 could not run sfdisk -l /dev/sdb to create /tmp/sfdisk.sdb!"
        echo   "  Unwilling to run rsyncz without verifying partitions.  Aborting..."
      fi
    else
      echo     "!*EROR*! $0 could not rm /tmp/sfdisk.sdb!"
    fi
  else
    echo       "!*EROR*! $0 must be run as root!"
  fi }
if    [[ "${(L)HOTy}" ==        cygwin* ]]; then # upd8db optz # /proc/registry/HKEY_CLASSES_ROOT/Installer/Assemblies &&         (these should also be pruned)
#  export PRUNEPATHS="/c/System\\ Volume\\ Information";       # /proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Explorer/UserAssist
#  export PRUNEPATHS="/c/System\\ Volume\\ Information           /proc/registry/HKEY_CLASSES_ROOT/Installer/Assemblies /proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Explorer/UserAssist";
#  export   NETPATHS="/c";
#--findoptions='-option1 -option2...' - Global optz4find.                         $ENV{FINDOPTIONS} also sets this value. Default:none
#--localpaths='    path1    path2...' - Non-network directories to put in the db.                                         Default:/
#--netpaths='      path1    path2...' - Network(NFS,AFS,RFS,etc.) dirz2put in db. $ENV{NETPATHS   } also sets this value. Default:none
#--prunepaths='    path1    path2...' - Dirz wich would but should! be put in db. $ENV{PRUNEPATHS } also sets this value. Default:/(((us|va)r/)?tmp|afs)
     alias upd8db='updatedb --localpaths="/c" --prunepaths="/c/System\\ Volume\\ Information /proc/registry/HKEY_CLASSES_ROOT/Installer/Assemblies /proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Explorer/UserAssist"';
else alias upd8db='updatedb'; fi # note: s|/$||g (rm trailing slashes from pathz2omit) or upd8db will treat as RegExes.
# 47GKM3BY tmp pokr env varz (NO Slashes on end!) wher 1st 'pokr' is local path to data dir
#export     pokr=~/dvl/pokr/c
#export ldvlpokr=piptigger@lbox.org:dvl/pokr/c
#export lcgipokr=piptigger@lbox.org:public_html/cgi-bin/pokr
#export ldvl=piptigger@lbox.org:dvl
# folOng lInz were added by compinstall on 77PKLPFw thN editd by Pip && mergd wi /etc/zsh/newuser.zshrc.recommended on E96M5ZkH
zstyle ':completion:*'                      auto-description 'specify:   %d'
zstyle ':completion:*'                           completer   _expand _complete _correct _approximate
zstyle ':completion:*'                           format      'Completing %d'
zstyle ':completion:*'                     group-name        ''
zstyle ':completion:*'                           menu        select=4 # mIt want 2?
zstyle ':completion:*'                   squeeze-slashes     true
zstyle ':completion:*'                       max-errors      1 numeric
#eval  "$(dircolors -b)" # this haz alredE Bn handld abov
zstyle ':completion:*:default'              list-colors      ${(s.:.)LS_COLORS}
zstyle ':completion:*'                      list-colors      ''
zstyle ':completion:*'                      list-prompt      %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*'                   matcher-list        '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*'                           menu        select=long
zstyle ':completion:*'                    select-prompt      %SScrolling active: current selection at %p%s
zstyle ':completion:*'                       use-compctl     false
zstyle ':completion:*'                           verbose     true
zstyle ':completion:*'                           prompt      '[%e] '
zstyle ':completion::complete:*'             use-cache       1 # enable cache for completions
zstyle ':completion:*:*:kill:*:processes'   list-colors      '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*'                    command     'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':compinstall'                            filename    '/home/pip/.zshrc'
autoload -U                                      promptinit; promptinit;
autoload -U                                        compinit;   compinit;
                                                   compdef  _man w3mman;
