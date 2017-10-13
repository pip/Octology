# E95MJRPd:~/.bashrc Xecutd by bash(1) 4non-login shLz editd by PipStuart<Pip@CPAN.Org>; C /usr/share/doc/bash/examples/startup-files (pkg bash-doc) 4Xmplz.
# $VERSION='0.0';$d8VS='F25LNkIG'; # this file has not had aliasez sync'd with many changez to .zshrc in a lot of monthz (since before F25LNkIG)
case $- in # if!runing intractivly,don't du NEthng
  *i*)       ;;
    *) return;;
esac
umask  022;
export PATH=".:~/bin:$PATH"; # sbinz alredE get added2 PATH if root Uzr&&ipi's ~/.bash_profile adz ~/bin but! ./ sO just added bOth hEr Bcuz I rm'd ~/.*profile
export PERL5LIB="$HOME/lib";
export EDITOR=`which vim`;
export LANG="C";
export Vrb0="1";
export ETERM_THEME_ROOT="~/.Eterm/themes"; # wuz ~/.Eterm/themes/Eterm
HISTCONTROL=ignoreboth; # don't put duplic8 lines or lines starting with space in history. C bash(1) 4 more optNz
HISTSIZE=4096;          # 4setng history length C HISTSIZE && HISTFILESIZE in bash(1)
HISTFILESIZE=4096;
shopt -s histappend;    # apNd2history fIl,don't OvrwrIt it
shopt -s checkwinsize;  # ck windO sIze aftr Ech cmd && upd8 LINES && COLUMNS if necSary
shopt -s globstar;      # if set,the p@rn "**" Used in a pathnAm Xpansion contXt wil m@ch all fIlz && 0 or mor dirz && subdirz
       [   -x  /usr/bin/lesspipe    ] && eval "$(SHELL=/bin/sh lesspipe)"; # mk less mor friendly 4 non-tXt input fIlz, C lesspipe(1)
if     [   -z  "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then   # set variable IdNtifyng the chroot U wrk in (Used in prmpt bElO)
  debian_chroot=$(cat                         /etc/debian_chroot)
fi
case "$TERM" in         # set fanC prmpt (non-colr,unlS wE knO wE "want" colr)
  xterm-color)         color_prompt=yes;;
esac
                 force_color_prompt=yes; # uncomNt 4 colrd prmpt,if term has cApabiliT
if     [   -n  "$force_color_prompt"                             ]; then
  if   [   -x  /usr/bin/tput ] && tput setaf 1 >&/dev/null        ; then # wE hv colr suport; assume it's complIant with Ecma-48 (ISO/IEC-6429).
                       color_prompt=yes; # Lack of such is XtrEmly rare,&& such a cAse wud tNd 2 support setf rather than setaf.
  else
                       color_prompt=
  fi
fi
if     [             "$color_prompt" = yes                       ]; then
  #S1='\[\033[1;33m[\[\033[0;36m\u\[\033[1;37m@\[\033[0;36m\h\[\033[1;30m:\[\033[1;31m`pt`\[\033[1;30m:\[\033[1;34m\w\[\033[1;33m]\[\033[1;32m\$';
  #S1='\[\033[1;33m[\033[1;36m\u\033[1;37m@\033[1;36m$HOSTNAME\033[1;31m`d8 -a`\033[1;34m\w\033[1;33m]\033[1;32m\$'; # wuz`pt -c`
  #S1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$';
  #S1='${debian_chroot:+($debian_chroot)}\[\033[01;34m[\033[1;33m\u\033[1;34m@\033[1;35m\h`d8 -a`\033[1;33m\w\033[1;34m]\033[1;32m\$'; # bash just  []$
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;37m[\033[1;32m\u\033[1;34m@\033[1;36m\h`d8 -a``c8fn $PWD`\033[1;37m]\033[1;32m\$';  # !lIk zsh !<[]>!
else
  #S1='[\u@\h:\w]\$'; # colrlS [pip@host:~]$ prmpt in cAse shL can't du betr
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$'
fi
unset                  color_prompt    force_color_prompt
case "$TERM" in         # if this is an xterm set the title to user@host:dir
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
  *) ;;
esac
#if     [   -x  /usr/bin/dircolors                                ]; then # NAbl colr support of ls && alsO add hanD aliases
#  test     -r ~/.lsrc && eval "$(dircolors -b ~/.lsrc )" || eval "$(dircolors -b)"
#  alias      ls=' ls   $LS_OPTIONS';
#fi
dircolors=`which dircolors`||dircolors=`which gdircolors`||dircolors='/usr/bin/dircolors';export dircolors;export COLORFGBG='default;default';
export LS_OPTIONS='--color=auto'; # LsOptz: --color=always|yes|force|never|no|none|auto|tty|if-tty && usually want -v natural sort of Version numbers too
if   [[ "$OSTYPE" == *bsd ]]; then alias ls='gls $LS_OPTIONS'; # originally just ck'd $PipzHost but better to ck explicitly for $OSTYPE =~ /BSD/i
else                               alias ls=' ls $LS_OPTIONS'; fi # load ls/dir color resources...
if   [[ -r "$HOME/.lsrc"  ]]; then  eval $($dircolors -b $HOME/.lsrc);     # orig also ck'd 4 m/^~\/\.(ls|dir)_colors$/i beyond .lsrc
else                                eval $($dircolors -b            ); fi; #   but all those aren't needed && here just init defaults
  alias     dir=' dir  $LS_OPTIONS';
  alias    vdir='vdir  $LS_OPTIONS';
  alias    grep=' grep $LS_OPTIONS';
  alias   fgrep='fgrep $LS_OPTIONS';
  alias   egrep='egrep $LS_OPTIONS';
# these were my original basic aliases before I tried to just copy most of my zsh ones str8 over into here which seems to have worked
#alias         l='ls -l';
#alias        ll='l  -F';
#alias        la='l  -A';
##lias        ld='l  -d'; # ld is an important linker so don't alias over it!
#alias       lsa='ls -ACF';
#alias       lsd='ls -ACdF */';
#alias        pu='pushd';
#alias        po='popd';
##lias      more='most';
##lias        vi='vim';
#alias        md='mkdir';
#alias        rd='rmdir';
#alias       cls='clear';
#alias      copy='cp';
#alias      move='mv';
#alias       del='rm';
#alias        zp='tar czvf';
##lias        uz='tar xzvf';
#alias         x='exit';
#alias        my='mysql -u root';
#alias     pingb='ping -b 192.168.8.255';
#alias   setfont='consolechars -f ';
##etfont med;
##lias         /='cd /'; # both '/' && 'cd/' R invalid alias nAmz 4 recent versions of bash
#alias      cdup='..';
#alias      cd..='..';
#alias        ..='cd ..';
#alias     cd...='...';
#alias       ...='cd ../..';
#alias    cd....='....';
#alias      ....='cd ../../..';
#alias   cd.....='.....';
#alias     .....='cd ../../../..';
#alias  cd......='......';
#alias    ......='cd ../../../../..';
#alias cd.......='.......';
#alias   .......='cd ../../../../../..';
#alias       moz='mozilla 2>&1 >/dev/null &';
#alias      qloq='dclock -date "%A %B %d, %Y" -geometry 155x55+1120+953 -miltime -bg "#03071B" -led_off "#032B1B" &';
#alias     echos='echo -n';
## add an "alert" alias 4 long running cmdz. Uz lIk sO: sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"';
##lias Et='Eterm --background-pixmap mits1024.jpg -c orange -T PipsEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --path /home/pip/.Eterm/ --default-font-index 4 &'
##lias Et='Eterm -c #ffa404 -T PipsEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --default-font-index 6 &'
#alias Et='Eterm -T PipsEtrm --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --default-font-index 6 &'
# It loox lIk `ls` itself can h&l all kIndz of globz >than `dircolrz` mkz but! [chrz]||dbl*, .lsrc can!hv[-_?], && nd dif nwUtl4 `dircolrz -p` 2sync nw .XtNz;
# nOt:ther hv been afew problMz wi thEse l8r apNded dFinitNz clobrng earlier .XtN defz sO I've mAde nOticd 1z mor specific but mAB should just Only prEpNd all?
export   LS_COLORS="$LS_COLORS*-ignore=01;31:*-conf=01;33:*-magic=01;31:*-release=01;36:*-xsessions=01;35:*-=00;31:*_COLORS=01;33:*_vimrc=00;33:";
export   LS_COLORS="$LS_COLORS*_completion=01;35:*_version=00;36:*_not_found=01;31:";                #/etc Xtra _XtNz (here)    && -(release|xsessions)? (abov)
export   LS_COLORS="$LS_COLORS*_Dingbats=01;31:*_Symbol=01;33:*_Unicode=01;36:*_Wingdings=01;35:";   #/etc/alternatives/ghostscript-current/Resource/Decoding
export   LS_COLORS="$LS_COLORS*-down=00;31:*-up=01;31:*-off=00;35:*-on=01;35:*-aticonfig=01;36:*-wireless=01;33:*-undock=00;36:*-cmos=00;33:"; #/e*/acpi/events
export   LS_COLORS="$LS_COLORS*-Bold=01;31:*-BoldItal=00;33:*-Ital=01;33:*-Roma=00;36:*-BoldObli=01;36:*-Regu=01;35:*-ReguObli=00;35:*-Medi=00;31:";
export   LS_COLORS="$LS_COLORS*-MediItal=01;31:*-ReguItal=00;33:*-BoldCond=01;33:*-BoldCondItal=00;36:*-ReguCond=01;36:*-ReguCondItal=01;35:*-DemiBold=00;35:";
export   LS_COLORS="$LS_COLORS*-DemiBoldItal=00;31:*-Ligh=01;31:*-LighItal=00;33:*-Book=01;33:*-BookObli=00;36:*-Demi=01;36:*-DemiObli=01;35:";
export   LS_COLORS="$LS_COLORS*-PCLPS2=01;33:"; #</etc/alternati*/ghostscript-current/Resource/Init #^/etc/alternatives/ghostscript-current/Resource/Font
export   LS_COLORS="$LS_COLORS*-WMode=01;31:";                                                       #/etc/alternatives/ghostscript-current/Resource/SubstCID
export   LS_COLORS="$LS_COLORS*-account=01;31:*-auth=00;33:*-password=01;33:*-session=01;36:*-noninteractive=01;35:*-daemon=01;31:*-screensaver=01;35:";
export   LS_COLORS="$LS_COLORS*-autologin=00;35:*-greeter=01;36:*-freerdp=00;33:*-uccsconfigure=01;33:*-1=00;35:";  # (~8bow cycl) /etc/(apparmor|pam).d
export   LS_COLORS="$LS_COLORS*-common=01;31:*-client=00;33:*-accessibility=01;33:*-strict=00;36:*-integration=01;36:*-browser=01;35:*-kit=00;35:";
export   LS_COLORS="$LS_COLORS*-files=00;31:*_certs=01;31:*_keys=00;33:*-repositories=01;33:*-clients=00;36:*-browsers=01;36:*-email=01;35:*-readers=00;35:";
export   LS_COLORS="$LS_COLORS*-terminal=01;33:*-helpers=00;31:*-konsole=01;31:*-players=00;33:*-base=01;33:*-launcher=00;36:*-messaging=01;36:*-xterm=01;35:";
export   LS_COLORS="$LS_COLORS*-download=00;35:*-mail=00;31:*-manpages=01;31:*-tmp=00;33:*-write=01;33:*-data=00;36:*-desktop=01;36:"; #/etc/ap*.d/abstractions
export   LS_COLORS="$LS_COLORS*change_profile=01;35:*find_mountpoint=01;36:*is_enabled=01;33:";      #/etc/apparmor.d/abstractions/apparmor_api
export   LS_COLORS="$LS_COLORS*-editors=01;33:*-xul=01;35:";                                         #/etc/apparmor.d/abstractions/ubuntu-browsers.d
export   LS_COLORS="$LS_COLORS*-dirs=01;35:"; # all these /etc/** entries are mainly defined here in default `ls` order           #/etc/apparmor.d/tunables
export   LS_COLORS="$LS_COLORS*-kernels=01;31:*-stamp=01;33:*-notifier=01;36:";                                                   #/etc/apt/apt.conf.d
export   LS_COLORS="$LS_COLORS*-cache=01;31:*-validate=00;36:*-prompt=01;33:*-tools=01;36:*-highlight=01;36:*-completion=00;35:"; #/etc/bash_completion.d
export   LS_COLORS="$LS_COLORS*-settings=01;33:"; # care has been taken to attempt to distribute colors pretty evenly in dirz     #/etc/dconf/db/ibus.d
export   LS_COLORS="$LS_COLORS*-support=01;35:*-setup=00;36:*-chrome=01;36:*-config=01;33:*-3g=01;35:*-dispatcher=00;35:*-tips=01;31:"; #/etc/default
export   LS_COLORS="$LS_COLORS*-routes=01;35:";                                                                                   #*/dhcp/dhclient-exit-hooks.d
export   LS_COLORS="$LS_COLORS*-default=00;31:";                                                                                  #/etc/dictionaries-common
export   LS_COLORS="$LS_COLORS*-whitelist=01;37:";                                                                                #/etc/gnome-app-install
export   LS_COLORS="$LS_COLORS*skeleton=01;31:";                                                                                  #/etc/init.d
export   LS_COLORS="$LS_COLORS*_map=01;31:*_dsfield=00;33:*_protos=01;33:*_realms=01;36:*_scopes=01;35:*_tables=00;35:";          #/etc/iproute2   (~8bow cycl)
export   LS_COLORS="$LS_COLORS*-runtime=01;31:";                                                                                  #*/logcheck/ignore.d.paranoid
export   LS_COLORS="$LS_COLORS*-utils=01;36:";                                                                                    #/etc/logrotate.d
export   LS_COLORS="$LS_COLORS*-secrets=01;31:";                                                                                  #/etc/ppp
export   LS_COLORS="$LS_COLORS*debian_config=01;33:";                                                                             #/etc/python*
export   LS_COLORS="$LS_COLORS*README=01;37:";                                                                                    #/etc/(rc*|sysctl).d|terminfo
export   LS_COLORS="$LS_COLORS*-order=01;35:";                                                                                    #/etc/resolvconf
export   LS_COLORS="$LS_COLORS*ssh_config=01;33:*sshd_config=00;33:*sa_key=01;36:*_import_id=01;35:";                             #/etc/ssh
export   LS_COLORS="$LS_COLORS*-server=01;36:";                                                                                   #/etc/ufw/applications.d
export   LS_COLORS="$LS_COLORS*-upgrades=01;35:";                                                                                 #/etc/update-manager
export   LS_COLORS="$LS_COLORS*-manager=01;35:*core=01;31:*.conf.01162014=00;31:"; #/etc/X11    can't double star *.conf.* or charclass for *.conf.[0-9]{8}
export   LS_COLORS="$LS_COLORS*-color=01;36:*-nocase=01;33:*-chrtr=00;33:*-belgian=00;36:*-danish=01;35:*-fitaly=00;35:*-french=00;31:*-french2=01;31:";
export   LS_COLORS="$LS_COLORS*-german=00;33:*-greek=01;33:*-hebrew=00;36:*-icelandic=01;36:*-italian=01;35:*-jisx6002=00;35:*-jisx6004=00;31:";
export   LS_COLORS="$LS_COLORS*-korean=01;31:*-latin1=00;33:*-norwegian=01;33:*-portuguese=00;36:*-russian=01;36:*-slovene=01;35:*-small=00;35:";
export   LS_COLORS="$LS_COLORS*-spanish=00;31:*-strip=01;31:*-swedish=00;33:*-swissgerman=01;33:*-turkish=00;36:*-uk=01;36:";     #/etc/X11/app-defaults (~8bO)
export   LS_COLORS="$LS_COLORS*-args=00;31:*_xresources=01;31:*-local=00;33:*_xsessionrc=01;33:*_support=00;36:*-startup=01;36:*_gnomerc=01;35:";
export   LS_COLORS="$LS_COLORS*_localhost=00;35:*_path=00;31:*-update=01;31:*_launch=00;33:*-launch=01;33:*-gtk3=00;36:*-scrollbar=01;36:";
export   LS_COLORS="$LS_COLORS*-xim=01;35:*-gtk=01;33:";                                                                          #/etc/X11/xinit/xinput.d
export   LS_COLORS="$LS_COLORS*-a11y=01;35:*-agent=00;35:*_start=01;31:";                                                         #/etc/X11/Xsession.d
export   LS_COLORS="$LS_COLORS*-repository-8_xml=01;35:*-addons_list-2_xml=00;35:*-sys-img_xml=01;31:*-addon_xml=01;36:";         #~/.android/cache
export   LS_COLORS="$LS_COLORS*meta-release-lts=01;35:"; # E95M5MJR:done adding Aku:/etc && ~/.*/* but stil nd2recurse furthr l8r #~/.cache/update-manager-core
export   LS_COLORS="*done_upgrades=01;31:$LS_COLORS";                                                                             #~/.co*/compiz-1/compizconfig
export   LS_COLORS="*bookmarks=00;33:$LS_COLORS";                                                                                 #~/.config/gtk-3.0
export   LS_COLORS="$LS_COLORS*desktop-metadata=01;31:";                                                                          #~/.config/nautilus
export   LS_COLORS="$LS_COLORS*hooks_seen=01;35:";                                                                                #~/.config/update-notifier
export   LS_COLORS="$LS_COLORS*.converted-launchers=01;33:*-data-convert=01;36:*_migration-ubuntu=01;35:";                        #~/.local/share
export   LS_COLORS="$LS_COLORS*-default-sink=01;33:*-default-source=01;36:";                                                      #~/.pulse
export   LS_COLORS="*config=01;33:*config~=00;31:*known_hosts=01;31:*history=01;35:$LS_COLORS"; # prEpNdng thEse2!clobr l8r .XtNz #~/.(mplayer|schism|ssh|w3m)
export   LS_COLORS="*Metadata=00;31:$LS_COLORS";                                                                                  #~/.cpan (binary file?)
export   LS_COLORS="*Makefile=01;35:*INSTALL=01;36:*MANIFEST=01;30:*AUTHORS=01;36:*CHANGELOG=01;33:*LICENSE=01;37:$LS_COLORS";    #~/.inst/(youtube-dl|perl*)
export   LS_COLORS="*makefile=00;35:*installhtml=01;35:*Artistic=01;37:*Changes=01;33:*Copying=01;37:$LS_COLORS"; #`lsd8`duz gout #~/.inst/perl-5.8.8
export   LS_COLORS="$LS_COLORS*.serverauth.???=00;32:*.serverauth.????=00;31:*.serverauth.?????=00;35:*.goutputstream-??????=00;31:"; #*.gout*-? duz!wrk4`ls`
export GREP_COLORS="mt=01;34"; #indkey -v; #`bindkey -e`setzEmacs-stylCmdLynEdtng; -v hazBn betRsofR4mE,butdu!4getEmaxAtaxBax; #rEmMbr"^foo^bar"subst prEv cmd;
alias  grep=' grep --color=auto'; # want grep --color=auto all za tym2(&&mayB`dircolrz ~/.gprc`?)&&2hv -nubTHZ?fulnSwi:Hedrfylnmz,lyNumZeroUnixTabalyndBytofstz
alias fgrep='fgrep --color=auto'; #   ...also fgrep ndz auto2,wud B cool 2 mk perl grep from grepp&&sarep 2 auto colr multiple m@chz difrNtly;
alias egrep='egrep --color=auto'; #   ...also egrep
alias        sp="export PS1='[\u@\h:\w]\$'";  # SimplePrompt   ||   BeautifulPrompt
alias        bp="export PS1='\[\033[1;33m[\[\033[0;36m\u\[\033[1;37m@\[\033[0;36m\h\[\033[1;30m:\[\033[1;35m\d\[\033[1;30m:\[\033[1;31m\t\[\033[1;30m:\[\033[1;34m\w\[\033[1;33m]\[\033[1;32m\$'";
#     ls.*? -1:OnlE1FyLynz($_\n);clasiFy(dir/,symlnk@,exefyl*,etc);QuotRsltnzFylNmz(2sealSpcz&&othrDynabiliTBhynd lit txt);Long(shoXact byte fylsizes);
alias lsQ=' ls -Q ';alias l1=' ls -1';alias  lQ1=' lQ -1 ';alias l1Q='  lQ1 ';alias lF1='lF -1';alias l1F='lF1';alias ls1='l1'; #Human readable approx fylsyz;
alias  lsF='ls -vF';alias lL=' ls -l';alias   lFl=' lF -l';alias  llF='  lFl';alias lQl='lQ -l';alias llQ='lQl';alias ll='lFl'; #!?"proly adng 1A|StekSauc"?!;
alias  lQF='  lsQF';alias  lFQ=' lQF';alias lsQF=' lQ  -F';alias lsFQ='lsQF ';alias lsgdf='ls --group-directories-first';
alias   lF='   lsF';alias lh=' ll -h';alias   lFh=' lh -F';alias lhF='   lFh';alias lfh='lFh';alias lhf='lhF'; #-v in base lsF natural sort of Version numbers
alias  lQ='   lsQ ';alias lr=' ls -r';alias  lQh=' lh -Q ';alias  lhQ=' lQh ';alias lqh='lQh';alias lhq='lhQ';
alias ll='  lF -l       ';alias lh='  ll -h       ';alias l='lsd8';alias lst='lft'; #clasiFy,Long(shoFylBytSyz),Human(rEdablSyz); l was =lh;
alias lFR=' lF -R       ';alias llR=' ll -R       ';alias lR=' l -R       ';alias lfR=' lFR ';alias lsR=' lfR '; #Recurs subdirz;Rmembr:zsh`**`auto-recursz
alias lFa=' lF -A       ';alias lla=' ll -A       ';alias la=' l -A       ';alias lfa=' lFa ';alias lsa=' lfa '; #Almostall (.*;!./||../)
alias lFb=' lF -B       ';alias llb=' ll -B       ';alias lb=' l -B       ';alias lfb=' lFb ';alias lsb=' lfb '; #omitBakupz(!*~)
alias lFrs='lF  -rS     ';alias llrs='ll -rS      ';alias lrs='l -rS      ';alias lfrs='lFrs';alias lsrs='lfrs'; #sortbyReversdSize
alias lFrx='lF  -rX     ';alias llrx='ll -rX      '; #ias lrx='l -rX      ';alias lfrx='lFrx';alias lsrx='lfrx'; #sortbyReversdXtension #D92MCBuZ:`md lrx`prob
alias lFrc='lF  -rct    ';alias llrc='ll -rct     ';alias lrc='l -rct     ';alias lfrc='lFrc';alias lsrc='lfrc'; #sortbyReversdChngdTime(frstmodtym)
alias lFc=' lF   -ct    ';alias llc=' ll  -ct     ';alias lc=' l  -ct     ';alias lfc=' lFc ';alias lsc=' lfc '; #sortby       ChngdTime(lastmodtym)
alias lFx=' lF   -X     ';alias llx=' ll  -X      ';alias lx=' l  -X      ';alias lfx=' lFx ';alias lsx=' lfx '; #sortby       Xtension
alias lFs=' lF   -S     ';alias lls=' ll  -S      ';alias lS=' l  -S      ';alias lfs=' lFs ';alias lss=' lfs '; #sortby       Size
alias lF-d='lF  -d      ';alias ll-d='ll  -d      ';alias l-d='l  -d      ';alias lf-d='lF-d';alias ls-d='lf-d'; #Dirz; belo shud prolyBfuncz2tst4$1 B4pikng*
alias lFd=' lF-d    *(/)';alias lld=' ll-d    *(/)';alias lD=' l-d    *(/)';alias lfd=' lFd ';alias lsd=' lfd '; #       Dirz*(/) Beppu sez:"Do*NOT*alias
alias lFid='lF-d -I=*(/)';alias llid='ll-d -I=*(/)';alias lid='l-d -I=*(/)';alias lfid='lFid';alias lsid='lfid'; #Ignore Dirz(!/)   importnt linker`ld`!"
alias lFf=' lF      *(.)';alias llf=' ll      *(.)';alias lf=' l      *(.)';alias lff=' lFf ';alias lsf=' lff '; #normal fylz*(.) Note:symlynx(@)
alias lFif='lF   -I=*(.)';alias llif='ll   -I=*(.)';alias lif='l   -I=*(.)';alias lfif='lFif';alias lsif='lfif'; #Ignore fylz(!.)
      FTym=' --full-time';alias llft="ll $FTym    ";alias lft="l $FTym    ";alias ltym='lft ';alias lftym='lft';alias ltime='lft'; #shoFulTym stampz4LongLstz
# for some reason, old ea='e a' could shell out2`bak` from ~/dvl/Utl/.bak/ but can't create .bak/ EROR from ~/.arc/Aku_-arc-full-Ubu10.04-D1KD1KD/var/log/apt/
# mAB stRting ./ as root owned  (even if not that restrictive 755 permissions) can't find way to ~/ from there? Wrap p[uo] makes sense 2rElEtRgetfromNEwher
alias e='      e    $TTY';alias ea='pu;e a;po';alias e2='pu ~/dox/2du;e 2;po';alias e3='e 3';alias upd8-mime-d8bs='md8';alias larv='laff; ripv';
alias e4='     e    4   ';alias e5='   e 5   ';alias e6='             e 6   ';alias e7='e 7';alias   e8='pu ~/dox/2du;e 8;po ';alias e9='e 9';
alias bak='    bak  $TTY';alias   ept='  echo `pt`';alias upd8-mdb=' md8       ';alias upd8-md8b='md8';alias update-mime-db='md8';alias lar8='larv; updb';
#lias updt='   updt $TTY';
                          alias    loc8='   locate';alias mdb-upd8=' md8       ';alias md8b-upd8='md8';alias mime-db-update='md8';alias mdb8='  mdb-upd8';
alias up='     updt $TTY';alias    upd8='   up    ';
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
alias ag='apt-get  ';alias agi='ag install';alias agu='ag update';alias aguu='agu;ag upgrade'; # Debian && Ubuntu apt shortcuts
alias ac='apt-cache';alias acs='ac search ';alias agr='ag remove';alias agrm='agr';alias agar='ag autoremove';
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
#lias vi='vim'; #alias scp='noglob scp'; # still want to glob locally so just intentionally escape remote globs wi \* etc; #Rot13perLyn:`vim $fyl`Vg?
alias              ..='cd ..                 ';alias cdup='..';alias cd..='           ..           ';
alias             ...='cd ../..                              ';alias cd...='          ...          ';
alias            ....='cd ../../..                           ';alias cd....='         ....         ';
alias           .....='cd ../../../..                        ';alias cd.....='        .....        ';
alias          ......='cd ../../../../..                     ';alias cd......='       ......       ';
alias         .......='cd ../../../../../..                  ';alias cd.......='      .......      ';
alias        ........='cd ../../../../../../..               ';alias cd........='     ........     ';
alias       .........='cd ../../../../../../../..            ';alias cd.........='    .........    ';
alias      ..........='cd ../../../../../../../../..         ';alias cd..........='   ..........   ';
alias     ...........='cd ../../../../../../../../../..      ';alias cd...........='  ...........  ';
alias    ............='cd ../../../../../../../../../../..   ';alias cd............=' ............ ';
alias   .............='cd ../../../../../../../../../../../..';alias cd.............='.............';
alias      mk='   make';
alias      sz='   sudo -E zsh';
alias      pu='  pushd';
alias      po='   popd';
alias      dv='   dirs -v';
alias    dirz='   dirs -p | perl -pe "\$_ = \$. - 1 . q. . . \$_"'; # sho lynz
alias     d2u='dum2umd   ';
alias     u2d='dum2umd  d';
alias     del='     rm';
alias    copy='     cp';
alias    move='     mv';
alias  attrib='   echo "Try chmod instead! ;) "';
#lias    mutt='   mutt; ~/lib/Octology/f8/pal8/tigsfavs.pal8'; # mutt clears pal8 colors so at least restore favor8s afterward
# Many of these Octology aliases should become special V8 via c8 coloriz8ion command wrappers or otherwise enhanced (&& simplified?) && unified funcs or cmdz:
alias       f='   find'; #  f    :           find            (with combined interface to loc8?)
alias       g='   grep'; #  g    :          sarep|(e|f)?grep (sed|awk too?)
alias      eg='  egrep'; # eg    :                 e    grep
alias       d='     du'; #  d    :             du|df         (Disk usage, free, etc.)
alias       p='     ps'; #  p    :             ps            (Process snapshot)          # for wc below, support `dd --help` like printf style size formats
alias       c='     wc'; #  c    :             wc (Count charz,words,&&lines&&eventually bits,bytes,[KMGTPEZY]i?bits|Bytes,code points,paragraphs,subs,etc.)
alias       h='history'; #  h    :        history (built-in in zsh && probably needs to be built-in for 8sh too)
alias       m='    man'; #  m    :            man|info
alias       t='    tee'; #  t    :            tee (maybe can wrap into c8 with cut,cat,colored columns?)
alias       x='   exit'; #  x    :           exit
alias      mo='   most'; #  mo   :           more|less|most
alias      md='  mkdir'; #  md   :          mkdir
alias      rd='  rmdir'; #  rd   :          rmdir
alias     mnt='  mount'; #  mnt  :          mount
alias    umnt=' umount'; # umnt  :         umount
alias     chm=' chmod '; #  chm  :          chmod
alias     cho=' chown '; #  cho  :          chown
alias     chg=' chgrp '; #  chg  :          chgrp
alias     chr=' chroot'; #  chr  :          chroot
alias     chs=' chsh  '; #  chs  :          chsh
#          mc() already zsh function below
#lias      mc='  md;cd'; #  mc   :          md+cd (make sure to override MidnightCommander if found)
#          c8 already ~/bin/
#lias      c8='cat|cut'; #  c8   :        cat|cut (with columnar alignment, coloring, && command matching..)
alias      zc='   zcat';
#lias      f8='   f80p'; #pal8   : should eventually be CLI && powerful interactive f0nt && pal8 selector && editor
alias      fp='     ls       ~/lib/Octology/f8/*   '; # fp was fontpal => fpal => f80p but none are presently functional
alias      f8f='    ls       ~/lib/Octology/f8/f0nt'; # eventually these should switch to f8 cmdz
alias      f8p='    ls       ~/lib/Octology/f8/pal8';
alias   fixfont=' etfp -s -f ~/lib/Octology/f8/f0nt/psf/roman2.psf';
alias resetfont=' etfp -s -f ~/lib/Octology/f8/f0nt/psf/france.psf';
alias      s8='   sort'; #  s8   :           sort
#          d8 already ~/bin/
#lias      d8='   date'; #  d8   :           date|time|pt
#          g8 already ~/bin/
#lias      g8='    git'; #  g8   :            git
alias      l8='    cal'; #  l8   :            cal|cron|at|batch
alias      sl='  ln -s'; #  sl   :             ln (maybe on this, since ln usually makes SymbolicLinks?)
alias      cl='    cln'; #  cl   :            calQl8 like my cln (maybe swapping so n reverses meaning to append Newline?)
alias     cls='  clear'; #  cls  :          clear (like DOS command for CLearScreen)
alias    viii='vim    '; #  viii : v8         vim (lowercased Roman Numerals for 8 where maybe my editor command name should alias as just`8`if possible too?)
alias      v8='viii   ';
alias       8='v8     '; # might try quoting 8 or just synhilite makes it seem wrong when it will work, eventually a c8-based clone that might also perform e
alias     dif='vimdiff'; #  dif  :            vimdiff|diff|cmp|comm
#   (upd|loc)8 already above near e (which should eventually wrap v8?)
#lias    loc8=' locate'; #  loc8 :             locate|find # f is already find above
#lias    upd8=' updt  '; #  upd8 :           updt (my tool to push dvl into bin && lib && upd8 may eventually wrap g8 git && collabor8 2ease general sync)
alias    uptm=' uptime'; #  uptm :           uptime
alias     uni='   uniq'; #  uni  :           uniq
alias     dic='   dict'; #  dic  :           dict     (colored with reviewable history)
alias      zp='    tar czvf';
#lias      zp='    zip'; #  zp   :            zip|tar|7z
#          uz() already function below
#lias      uz='  unzip'; #  uz   :          unzip
alias      ec='   echo'; #  ec   :           echo
alias    cncl=' cancel'; #  cncl :         cancel
alias      k=' kill   '; #  k    :           kill (maybe kill is too risky to abbreV8 this tersely?)
alias      ka='killall'; #  ka   :           killall
#lias      hd='   head'; #  hd   :           head (hd is already HexDump, which maybe should be combined (&& hd is more crucial HardDisk LVM util too?)) 
alias      tl='   tail'; #  tl   :           tail
alias      tp='    top'; #  tp   :            top
#          ss() already function below
#lias      ss='    ssh'; #  ss   :            ssh
alias      wd='    pwd'; #  wd   :            pwd
alias      pw=' passwd'; #  pw   :         passwd
alias     msg='   mesg'; #  msg  :           mesg|write
alias      wh='  which'; #  wh   :                which (pretty similar to zsh's "=" cmd prefix already)
alias     lsc='  lscpu'; #  lsc  :          lscpu
alias     lsm='  lsmod'; #  lsm  :          lsmod
alias     lsp='  lspci'; #  lsp  :          lspci
alias     lsu='  lsusb'; #  lsu  :          lsusb
alias     ren=' rename'; # might take just Perl quoted regex instead of $from $to before shell fileglob to alter
alias  sslbox='    ssh pip@LBox.Org'; #LBox.Org 216.158.99.146; #Old 9PNet.Com download:screwyou;
alias     shl='source-highlight -f esc --style-file=~/.shl.style -i'; # change from default HTML output format to ANSI escape codes && expect next param 2B Input source-code filename
alias    ctor='ctorrent -e 15 -C 64';
alias     p47='parsec47'; # & was auto bg && explicit /usr/games/ but former is better appended manually when desired && latter is in PATH, as it should be
alias      rr='rrootage';
alias    U2b=' youtube-dl';
alias    U2bm='U2b  -o "%(title)s-tItL-%(uploader)s-uldr-%(extractor)s-Xtrc-%(id)s-IdNt-%(epoch)s-epch-%(upload_date)s-uldt-%(autonumber)s-otnm.%(ext)s" --restrict-filenames';
alias    U2b3='U2bm -x --audio-format=mp3  --audio-quality=0'; # just having --audio-format=mp3 was converting to just 32K quality =( hopefully 0 will improve
alias    U2ba='U2bm -x --audio-format=best --audio-quality=0'; # gst123 works pretty admirably on most formats, but `mpg123 -Cv` is a good bit nicer
alias      my='mysql -u root';
alias    irc='        bx -a irc.rt.ru             -n Pipsurugi -b' # should s/b(itch)?x/irssi/g
alias    ircsdl='  irssi -c IRC.Perl.Org          -n Pip'       #sdl
alias    ircPerl='    bx -a IRC.Perl.Org          -n PipStuart' #perl #yapc
alias    ircPerlFree='bx -a IRC.FreeNode.Org      -n PipStuart' #perl #perl6
alias     bxp4p='     bx -a IRC.INet.Tele.DK:6667 -n PipStuart -c #PipForPresident'
alias       puz='     bx -a irc.rt.ru             -n Pippu     -c #puzzlecraft'
alias        sc='     bx -a irc.prison.net        -n PipTigger -c #soulcalibur'
alias       srk='     bx -a irc.inet.tele.dk:6667 -n Pipsurugi'
#alias      srk='     bx -a IRC.ServerCentral.Net -n Pipsurugi'
#alias      srk='     bx -a irc.nijenrode.nl      -n Pipsurugi'
#alias      srk='     bx -a efnet.demon.co.uk     -n Pipsurugi'
#alias      srk='     bx -a efnet.demon.co.uk     -n Pipsurugi'
#alias      srk='     bx -a prison.net            -n Pipsurugi'
#alias      srk='     bx -a irc.rt.ru             -n Pipsurugi'
#alias      srk='     bx -a qeast.net             -n Pipsurugi'
#-c #puzzlecraft -c #soulcalibur' # rt.ru 4, prison.net 6, homelien.no 7 #ogcapcom bap
#-c "#srk had0 spd0 j3w n1ce apex2 evl2003 mandalay hiddenvalley redrock" -c "#ogcapcom bap chigga"
alias psag='ps  aux | grep    ';alias pingb='ping 192.168.16.255 -b';
alias idmg='identify          ';alias idmv=' idmg     -verbose     '; # ImageMagick IDentify IMaGe utl && verbose probably needs | $PAGER
alias ckya='w3m mail.yahoo.com';alias gnuya='gnuyahoo -u=piptigger ';
alias cktm='w3m http://www.time.gov/timezone.cgi\?Pacific/d/-8     ';
alias j2k=' joy2key $TTY -terminal -rcfile ~/.joy2keyrc -axis Left Right Up Down -buttons a b c d e f g h i j &';
alias j2kx='joy2key      -X        -rcfile ~/.joy2keyrc                                                       &';
alias glxg='glxgears -info -geometry 1920x1176+0+0';
#lias setfont='consolechars -f'; # fb lines on Gen:
alias fb6=' fbset  640x480-60 '; #              30
alias fb8=' fbset  800x600-100'; #              37
alias fb10='fbset 1024x768-100'; #              48
alias fb12='fbset 1280x1024-75'; #              64
alias fb16='fbset 1600x1200-76'; #              75
alias mysrut='mysql  -u root';
alias moz='/usr/local/mozilla/mozilla -P Pip';
#lias moz='mozilla 2>&1 >/dev/null &';
alias swyp='screen -wipe  ';
alias scrn='screen -h 9999';                        #-S srk  -t srk'
alias     s2du='             pu ~/dox/2du/    ; scrn -S 2du  -t 2du e       2  ; po';
alias     sirc='                                scrn -S irc  -t irc irssi -c IRC.Perl.Org -n Pip';
alias s2='s2du'; alias ssnc='pu ~/dox/2du/    ; scrn -S snc  -t snc            ; po'; # ssync2du
                 alias smuz='pu ~/muz         ; scrn -S muz  -t muz            ; po';
alias     srut='             pu  /etc         ; scrn -S rut  -t rut sudo -E zsh; po';
alias sr='srut'; alias sp4p='pu ~/dvl/p4p/    ; scrn -S p4p  -t p4p            ; po';
#lias g3='   gst123';
alias m3='   mpg123';
alias mp='   mplayer';
alias mplyr='mplayer -vo xv -fixed-vo          -loop 0   -noborder -cache 16384 -cache-min 99'; # should try different -vo (xv already default) for performance
alias mply=' mplayer -vo xv -fixed-vo -nosound -loop 0          -geometry 1916x1052+0+0'; #-x 1916 -y 1052' # mplayer can only strt wi1920maxBcuzXinerama?
alias mpr0=' mplayer                  -nosound                  -geometry 1916x1052+0+0'; # still needs vid file params like ~/mvz/*/mpg/*.mpg
alias mpr0t='mplayer -vo xv -fixed-vo -nosound -msgcolor -noborder -cache 16384 -cache-min 99 -geometry 1916x1052+0+0 -msglevel all=0:identify=4 ~/mvz/.pr0/tst/Aut0pr0-9AS4gTn/pr0-*/*'; # test if messages can report desired details
alias mpfb=' mplayer -vo fbdev -vf scale=640:400   -loop 0'; # ~/mvz/muz/vid/* for some old scaled FrameBuffer modes
alias mpfbs='mplayer -vo fbdev -vf scale=1920:1200 -loop 0'; # ~/mvz/muV/.../*
alias mpx='  mplyr   -fs'; #-x 1920 -y 1200'
alias kamp='killall -q -9 mplayer'; # -quiet (!warn if!mtch) && -9 kill force signal
alias kf='  killall -q plugin-container'; #'kill `ps ax | grep firefox | grep flash | cut -d" " -f1`'; # Kill crashed adobe Flash plugin (altho bad if ever running additional firefox plugins && will have to restart those too). Could also use   | c8 0';#now instead.
#/usr/lib/firefox/plugin-container /usr/lib/flashplugin-installer/libflashplayer.so -greomni /usr/lib/firefox/omni.ja 1881 true plugin
alias qloq=' dclock -date "%A %B %d, %Y" -geometry 155x55+1120+953 -miltime -bg "#03071B" -led_off "#032B1B" &';
alias xqloq='xclock -digital -fg orange -bg black -rv -geometry 255x63 -update 1 -brief &';
alias echos='echo -n';
alias eqx='/home/pip/dvl/clda/eqx/equinox-0.8.7-Linux-glibc2.3/bin/eq &'; # Gabor Nagy's EQuinoX3D
#lias cln='    perl -e "print eval join q( ), @ARGV;"'; # simple cmdln calculator # A771rfw: betr2Uz symlnk 4cln->calc wich handlz BigInt calQl8nz;
alias fstat='  perl -MTime::PT -e "@s=split(/ /,scalar(localtime((stat(shift))[9])));print  \"@s\n\"    ;"';
alias fstatpt='perl -MTime::PT -e "@s=split(/ /,scalar(localtime((stat(shift))[9])));print pt(@s),\"\n\";"';
export ETERM_THEME_ROOT="~/.Eterm/themes"; # wuz ~/.Eterm/themes/Eterm
alias E=' Eterm -t E &';
alias Et='Eterm --scrollbar-width 15 --cmod 227 -L 65536 --geometry 160x50+8+16 &';
#alias E='Eterm -t E --scrollbar-type motif --scrollbar-width 15 &'; # --cmod 227 &';
#alias Et='Eterm --background-pixmap mits1024.jpg -c orange -T PipzEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --path /home/pip/.Eterm/ --default-font-index 4 &'
#alias Et='Eterm -c #FFA404 -T PipzEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --default-font-index 4 &'
#alias Et='Eterm -c #FFA404 -T PipzEtrm --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --scrollbar-color "#071531" --default-font-index 4 -F andalemo.ttf --proportional --cmod 195 --double-buffer &';                                                                                            "-*-*-*-*-*-*-$1-*-*-*-*-*-*-*"
#/usr/share/texmf/fonts/afm/adobe: avantgar bookman courier helvetic         ncntrsbk palatino         symbol times zapfchan zapfding
#/usr/share/texmf/fonts/tfm/adobe: avantgar bookman courier helvetic mathppl ncntrsbk palatino pslatex symbol times zapfchan zapfding
#/usr/share/texmf/fonts/vf /adobe: avantgar bookman courier helvetic mathppl ncntrsbk palatino pslatex        times zapfchan
#alias Et='Eterm -c #FFA404 --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --cmod 227 &';
#alias Et='Eterm -c #FFA404 -T PipzEtrm --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --buttonbar --cmod 227 -L 4095 --double-buffer -x &'; #\
#                                                       --font1 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-56-iso8859-1" \
#                                                       --font2 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-66-iso8859-1" \
#                                                       --font3 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-76-iso8859-1" \
#                                                       --font4 "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-96-iso8859-1" \
#                                                  --bold-font  "-adobe-helvetica-medium-r-normal-*-10-100-75-75-p-96-iso8859-1" &';
alias gtd0='gnome-terminal --display=:0.0';
alias gtrm='    gtd0 --class=gtrm     --geometry  80x46-0+0      --hide-menubar --window-with-profile=GT80x46Terminus18           --title=zsh          &';
alias gterm='   gtd0 --class=gterm    --geometry 160x64+0+0      --hide-menubar --window-with-profile=GT160x64Courier14                                &';
alias gnomterm='gtd0 --class=gnomterm --geometry  80x51+0+0      --show-menubar --window-with-profile=GT80x39CourierBold20        --title=zsh          &';
alias gtpt='    gtd0 --class=ptok     --geometry    27x1-0-0     --hide-menubar --window-with-profile=GT27x1AndaleMonoBold40-ptok --title=ptok -e ptok &';
alias gtpto='   gtd0 --class=ptok     --geometry  27x1+3002+1141 --hide-menubar --window-with-profile=GT27x1AndaleMono40-ptok     --title=ptok -e ptok &';
alias gtpm='    gtd0 --class=pmix     --geometry 160x3+1921+1141 --hide-menubar --window-with-profile=GT67x3Lincoln12-pmix        --title=pmix -e pmix &'; # 160, 180, 282
ss() { # ssh
  if [ "$1" = "" ]; then
    ssh -l pip ChunW
  else
    ssh $@
  fi
}
grp() { # grep stuf I lIk
  grep -i -n $1 $2 2>/dev/null
}
mc() {  # Uzd2B mcd 4 Mk&&ChDir but MakeChng werkz too! =)
  if [ ! -d "$1" ]; then 
    md $1
  elif [ "$Vrb0" = 1 ]; then
    echo "!*EROR*! Can't MkDir $1!"
  fi
  if [ -d "$1" ]; then
    cd $1
  elif [ "$Vrb0" = 1 ]; then
    echo "!*EROR*! Can't ChDir $1!"
  fi
}
#cp() {
#  if [ $# -gt 2 ] && [ ! -d ${$#} ]; then
#    /bin/cp $@ .
#    return 0
#  fi
#  /bin/cp $@
#}
src() {
  [ $# -lt 1 ] && {
    source ~/.bashrc
    return 0
  }
  source $@
}
uz() {
  [ $# -lt 1 ] && {
    if [ "$Vrb0" = 1 ]; then
      echo "!*EROR*! Nothing to UntarZip!"
    fi
    return 0
  }
  if [ -f "$1" ] && [ -r "$1" ]; then
    if tar xzvf $@ 2>/dev/null || tar xvf $@ 2>/dev/null || gunzip $@ 2>/dev/null; then
      if [ "$Vrb0" = 1 ]; then
        echo "Successfully UntarZipped file: $1"
      fi
    else
      if [ "$Vrb0" = 1 ]; then
        echo "!*EROR*! Can't UntarZip file: $1!"
      fi
    fi
  else
    if [ "$Vrb0" = 1 ]; then
      echo "!*EROR*! Can't find tarZip file: $1!"
    fi
  fi
}
if     [   -f  ~/.bash_aliases                                   ]; then # separ8 alias dFinitNz nstd of all hEr. C /usr/share/doc/bash-doc/examples
  .            ~/.bash_aliases
fi
if       !     shopt -oq posix                                    ; then # NAbl prOgramabl complEtion fE2rz
  if   [   -f  /usr/share/bash-completion/bash_completion        ]; then # (&&don't nd2NAbl this if alredE NAbld in /etc/bash.bashrc srcd by /etc/profile)
    .          /usr/share/bash-completion/bash_completion
  elif [   -f  /etc/bash_completion                              ]; then
    .          /etc/bash_completion
  fi
fi
