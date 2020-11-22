# 381F3RN - .zshrc header written by Pip@CPAN.Org
# Note: It's better to rely on standalone executable utility functions than aliases or shell scripts defined in an rc-file such as this because they will
#   still be available to spawned processes that don't happen to use your shell choice (eg. ":!cln 127/7" in vim) so port stuff to utl scripts when possible.
# 2do: add per-vc fpals && always start new local `scrn` if not in?
#   learn what -z does for autoload
#   get pcre (PerlCompatRegExes) module && any other useful ones
[[ -e /sw/bin/init.sh ]] && source /sw/bin/init.sh # fink - special FreeBSD stuff
setopt                 \
  autocd               \
  autonamedirs         \
  completeinword       \
  histverify           \
  magicequalsubst      \
  promptsubst          \
  pushdignoredups
unsetopt               \
  promptcr               # no carriage return before new prompt (It sucks that cmdln editing gets skewed unless newlines bracket everything.)
#  autopushd            \ # adds dirs to stack when just normally changing to them?
#  menucomplete         \ # menucomplete makes first tab explode match list
#  ksharrays            \ # remember when writing scripts [or functions] to include 'setopt [localoptions] ksharrays' so that they're 0-based
if   [ "$SHELL" = "" ]; then
  export SHELL=`which zsh`
fi
if   [ "$HOSTNAME" = "" ]; then
 #export HOSTNAME=`hostname` # this seems to be returning fscked up newlinez or something =(
  export HOSTNAME='W-PSTUART'
fi
export PipsUser='pip'
export PipsHost="$HOSTNAME"
export PipsOSys="$OS"
export PipsShel="zsh"
export PipsRows="$LINES"
export PipsCols="$COLUMNS"
if   [ "$HOSTNAME" = "Ax9.org"       ]; then
  export PipsHost='Ax9'
elif [ "$HOSTNAME" = "Genjuro"       ]; then
  export PipsHost='Gen'
elif [ "$HOSTNAME" = "BinQ.org"      ]; then
  export PipsHost='BinQ'
elif [ "$HOSTNAME" = "lbox.org"      ]; then
  export PipsHost='LBox'
elif [ "$HOSTNAME" = "taki"          ]; then
  export PipsHost='Taki'
elif [ "$HOSTNAME" = "risk"          ]; then
  export PipsHost='Risk'
elif [ "$HOSTNAME" = "trilogy-wsi01" ] ||
     [ "$HOSTNAME" = "TRILOGY-WSI01" ]; then # lern zsh's lc() 4 these 2 m//i
  export PipsHost='WSI01'
elif [ "$HOSTNAME" = "w-pstuart"     ] ||
     [ "$HOSTNAME" = "W-PSTUART"     ]; then
  export PipsHost='W-PStu'
  export PipsUser='pstuart'
fi
ulimit -c 65535  # 33553920-bytes # sets coredump size limit to 32MB (for debugging) where the # is *512-byte blocks.  'unlimited' is also an option.
# environment
typeset -U path
path=($HOME/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin ./ $path)
watch=(notme)
if   [ "$OSTYPE"   = "cygwin" ]; then
 #export  DST='1'   # DaylightSavingsTime?
 #export   TZ='PST' # United States of America / Los Angeles
elif [ "$PipsHost" = "LBox"   ]; then
  export   TZ='UTC' # Coordinated Universal Time
fi
#export TERM='linux' # find out when explicit TERM assignment has seemed necessary (maybe for vim colors but fixed by .vimrc "set background=dark"?)
export EDITOR=`which vim`
PAGER=`which most` || PAGER=`which less` || PAGER=`which more`
export PAGER
export PERL5LIB="$HOME/lib:$HOME/lib/site" # dflt(&&preferred)way2load my *.pm
export PERL_TEST_POD="1"    # a good practice for Kwalitee
export CVSROOT="/var/cvs"   # default
export CVS_RSH=`which ssh`
       dircolors=`which dircolors` || dircolors=`which gdircolors`
export dircolors
eval $($dircolors $HOME/.lsrc)
export COLORFGBG='default;default'
export LS_OPTIONS='--color=force' # could be --color=tty?
if [ "$OSTYPE" = "BSD" ]; then   # originally just ck'd $PipsHost but better to ck explicitly for $OSTYPE =~ /BSD/i
  alias ls='gls $LS_OPTIONS'
else
  alias ls=' ls $LS_OPTIONS'
fi
## BEGIN KEY BINDINGS
#bindkey -e # setup emacs style command line editing... but I prefer to...
bindkey -v # setup vim style command line editing
# !?command <TAB>  complete from history  # Bang-history
# !#        <TAB>  repeat command line
# ^A   beginning-of-line, ^E end-of-line  # except I think all these are the Emacs (-e) mappings
# ^D   list completions, log out
# ^K   kill-line, ^U kill-whole-line
# ^R   history-incremental-search-backward, ^[P history-search-backward
# ^W   backward-kill-word, ^[D kill-word
# ^XU  undo, ^X^U undo
# ^[.  insert-last-word
# ^[B  backward-word, ^[F forward-word
# ^[H  run-help
# ^[Q  push-line
#bindkey "^Z"    accept-and-hold
#bindkey " "     magic-space  # also do history expansion on space
#bindkey "\e[3~" delete-char
#bindkey "\e[A"  up-line-or-search
#bindkey "\e[B"  down-line-or-search
## Thorsten's own bindings
## rxvt
# These are the same as below - captured with [Ctrl]+[V]
#bindkey "^[Od"  backward-word
#bindkey "^[[7~" beginning-of-line
#bindkey "^[[8~" end-of-line
#bindkey "^[Oc"  forward-word
# captured with "od -c"
#bindkey "\eOd"  backward-word
#bindkey "\e[7~" beginning-of-line
#bindkey "\e[8~" end-of-line
#bindkey "\eOc"  forward-word
## Cygwin Console
# Cygwin Console does not distinguish between [Ctrl]+[<|] and [<|] respectively [Ctrl]+[|>] and [|>]
if [ "$TERM" = "cygwin" ]; then
  bindkey "\e[1~" beginning-of-line
  bindkey "\e[4~" end-of-line
#  typeset -g -A key
#  key[F1]='^[[[A'
#  key[F2]='^[[[B'
#  key[F3]='^[[[C'
#  key[F4]='^[[[D'
#  key[F5]='^[[[E'
#  key[F6]='^[[17'
#  key[F7]='^[[18'
#  key[F8]='^[[19'
#  key[F9]='^[[20'
#  key[F10]='^[[21'
#  key[F11]='^[[23'
#  key[F12]='^[[24'
#  key[Backspace]='^H'
#  key[Insert]='^[[2~'
#  key[Home]='^[[1~'
#  key[PageUp]='^[[5~'
#  key[Delete]='^[[3~'
#  key[End]='^[[4~'
#  key[PageDown]='^[[6~'
#  key[Up]='^[[A'
#  key[Left]='^[[D'
#  key[Down]='^[[B'
#  key[Right]='^[[C'
#  bindkey "$key[Delete]" delete-char
#  bindkey "$key[Home]"   beginning-of-line
#  bindkey "$key[End]"    end-of-line
fi
## END KEY BINDINGS... && on to 1-line of olde bash styl prmp && the rest new zsh stl prmpz
#export PS1='%{[1;33m%}[%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}%m%{[1;31m%}`pt`%{[1;34m%}%~%{[1;33m%}]%{[1;32m%}%(!.#.$) '
#export PS1='%{[1;33m%}%[%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}%m%{[1;31m%}`pt`%{[1;34m%}%~%{[1;33m%}]%{[0;33m%}%(!.#.$)%{[1;32m%}'
#export PS1='%{[1;33m%}%(!.<.[)%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}$PipsHost%{[1;31m%}`pt -cp`%{[1;34m%}%~%{[1;33m%}%(!.>.])%{[1;32m%}'
#export PS1='%{[1;37m%}%(!.<.[)%{[1;36m%}%n%{[1;34m%}@%{[1;36m%}$PipsHost`pt -cp`%{[1;33m%}%~%{[1;37m%}%(!.>.])%{[1;32m%}'
export PS1='%{[1;37m%}%(!.<.[)%{[1;36m%}$PipsUser%{[1;34m%}@%{[1;36m%}$PipsHost`pt -cp`%{[1;33m%}%~%{[1;37m%}%(!.>.])%{[1;32m%}'
export HISTFILE=~/.history
export HISTSIZE=1023
export SAVEHIST=1023
if [ "$USER" != "root" ]; then
  if [ "$GLOBFPAL" != "1" ]; then # global pal
    if [ "$DISPLAY" =  "" ]; then
      if [ "$PipsHost" = "Ryu" ] || [ "$PipsHost" = "Gen" ]; then
        tigsfavs.fpp
      fi
    fi
    export GLOBFPAL=1
  fi            # Ryu is Old until `pmei Curses` or fpal doesn't require curses to wrap etfp && maybe fpals should be set in init.d/consolechars even sooner
  if [ "$PipsHost" = "RyuOld" ] || [ "$PipsHost" = "Gen" ]; then # load vterm-specific fonts just on Gen/Ryu (&& maybe add per-vterm -l[ocal] pals later)
    if   [ "$TTY" = "/dev/tty13" ] || [ "$TTY" = "/dev/vc/13" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/crakrjak.fnt
    elif [ "$TTY" = "/dev/tty3"  ] || [ "$TTY" = "/dev/vc/3"  ] ||
         [ "$TTY" = "/dev/tty15" ] || [ "$TTY" = "/dev/vc/15" ]; then
      etfp A172 F177
      fpal -x -l ~/dvl/utl/fontpal/test/font/hylas.fnt
    elif [ "$TTY" = "/dev/tty4"  ] || [ "$TTY" = "/dev/vc/4"  ] ||
         [ "$TTY" = "/dev/tty16" ] || [ "$TTY" = "/dev/vc/16" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/fresno.fnt
    elif [ "$TTY" = "/dev/tty5"  ] || [ "$TTY" = "/dev/vc/5"  ] ||
         [ "$TTY" = "/dev/tty17" ] || [ "$TTY" = "/dev/vc/17" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/sansurf.fnt
    elif [ "$TTY" = "/dev/tty6"  ] || [ "$TTY" = "/dev/vc/6"  ] ||
         [ "$TTY" = "/dev/tty18" ] || [ "$TTY" = "/dev/vc/18" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/med.psf.gz
    elif [ "$TTY" = "/dev/tty7"  ] || [ "$TTY" = "/dev/vc/7"  ] ||
         [ "$TTY" = "/dev/tty19" ] || [ "$TTY" = "/dev/vc/19" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/calligra.psf.gz
    elif [ "$TTY" = "/dev/tty8"  ] || [ "$TTY" = "/dev/vc/8"  ] ||
         [ "$TTY" = "/dev/tty20" ] || [ "$TTY" = "/dev/vc/20" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/roman3.psf.gz
    elif [ "$TTY" = "/dev/tty9"  ] || [ "$TTY" = "/dev/vc/9"  ] ||
         [ "$TTY" = "/dev/tty21" ] || [ "$TTY" = "/dev/vc/21" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/france.fnt
    elif [ "$TTY" = "/dev/tty10" ] || [ "$TTY" = "/dev/vc/10" ] ||
         [ "$TTY" = "/dev/tty22" ] || [ "$TTY" = "/dev/vc/22" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/antique.fnt
    elif [ "$TTY" = "/dev/tty11" ] || [ "$TTY" = "/dev/vc/11" ] ||
         [ "$TTY" = "/dev/tty23" ] || [ "$TTY" = "/dev/vc/23" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/broadway.fnt
    elif [ "$TTY" = "/dev/tty12" ] || [ "$TTY" = "/dev/vc/12" ] ||
         [ "$TTY" = "/dev/tty24" ] || [ "$TTY" = "/dev/vc/24" ]; then
      fpal -x -l ~/dvl/utl/fontpal/test/font/futura-2.fnt
    elif [ "$DISPLAY" = "" ]; then
  #    fpal -x -l ~/dvl/utl/fontpal/test/font/tektite.psf.gz
    fi
  fi
  if [ "$PipsHost" = "Ryu" ]; then
    curs # setup my own initial cursor preferences
  fi
fi
alias l='ls -hlF'           # Humanreadable, Long, classiFy (traildirswith/)
alias ll="ls -lF"           # same but show exact filesizes (in bytes)
alias la='l -A'             # Almostall (! .||..)
alias lb='l -B'             # omitBackups (! *~)
alias lc='l -ct'            # sortbylastmodificationTime
alias lf='l *(.)'           # normal files (.) NOTE: symlinks (@)
alias lr='l -r'             # Reverse sort order
alias lR='l -R'             # Recurse subdirectories
alias lx='l -X'             # sort by eXtension
alias lrx='l -rX'           # sort by Reverse eXtension
#alias ld='l -d'             # Beppu-san said this is typically an important linker so don't alias it!
alias lld='l -dF *(/)'      # only List(inLongformat)Dirs *(/)
alias llf='l *(.)'          # normal files (.) NOTE: symlinks (@)
alias lid='l -dF -I=*(/)'   # Ignore Dirs (! */)
alias lls='l -S'            # sort by Size
alias lrs='l -rS'           # sort by Reverse Size
alias ltime='l --full-time'
alias lsa='ls -A'
alias lsb='ls -B'
alias lsd='ls -dF *(/)'
alias lsf='ls *(.)'
alias lsr='ls -r' 
alias lsR='ls -R'  
alias lss='ls -S' 
alias lsrs='ls -rS' 
alias lsx='ls -X'  
alias lsrx='ls -rX'  
# remember `ls **/*.pl` auto recurses subdirs && ***/*.pl follows symlinks too
alias e='e       $TTY'
alias ea='e a'
alias bak='bak   $TTY'
alias updt='updt $TTY'
alias vi='vim'
alias ept='echo `pt`'
#alias scp='noglob scp' # still want to glob locally so just intentionally escape remote globs
alias cdup='..'
alias cd..='..'
alias ..='cd ..'
alias cd...='...'
alias ...='cd ../..'
alias cd...='...'
alias ....='cd ../../..'
alias cd....='....'
alias .....='cd ../../../..'
alias cd.....='.....'
alias ......='cd ../../../../..'
alias cd......='......'
alias .......='cd ../../../../../..'
alias cd.......='.......'
alias ........='cd ../../../../../../..'
alias fpdir='cd           ~/dvl/simp/bin/fpal/test/font; ls'
alias fixfont='etfp -s -f ~/dvl/simp/bin/fpal/test/font/roman2.psf'
alias mk='make'
alias md='mkdir'
alias rd='rmdir'
alias cls='clear'
alias copy='cp'
alias move='mv'
alias mmv='noglob zmv -W' #e.g.,`mmv crazily_long_name_*.html name_*.htm`
alias del='rm'
#alias attrib='chmod'
alias c='     chmod 644'
alias d2u='dum2umd'
alias u2d='dum2umd d'
alias x='exit'
alias pu='pushd'
alias po='popd'
alias dv="dirs -v"
alias zp='tar czvf'
alias sz='sudo zsh'
alias mutt='mutt; tigsfavs.fpp'
alias sslbox='ssh pip@LBox.Org' #LBox.Org 216.158.99.146
alias ssrisk='ssh pip@208.78.101.177' #Beppu-san's SliceHost MetaNotes.Kicks-Ass.Org 208.78.101.177
alias my='mysql -u root'
alias resetfont='etfp -s -f /usr/share/consolefonts/med.psf'
alias irc='        bx -a irc.rt.ru             -n Pipsurugi -b' # should s/b(itch)?x/irssi/g
alias ircPerl='    bx -a IRC.Perl.Org          -n PipStuart' #perl #yapc
alias ircPerlFree='bx -a IRC.FreeNode.Org      -n PipStuart' #perl #perl6
alias bxp4p='      bx -a IRC.INet.Tele.DK:6667 -n PipStuart -c #PipForPresident'
alias puz='        bx -a irc.rt.ru             -n Pippu     -c #puzzlecraft'
alias sc='         bx -a irc.prison.net        -n PipTigger -c #soulcalibur'
alias srk='        bx -a irc.inet.tele.dk:6667 -n Pipsurugi'
#alias srk='       bx -a IRC.ServerCentral.Net -n Pipsurugi'
#alias srk='       bx -a irc.nijenrode.nl      -n Pipsurugi'
#alias srk='       bx -a efnet.demon.co.uk     -n Pipsurugi'
#alias srk='       bx -a efnet.demon.co.uk     -n Pipsurugi'
#alias srk='       bx -a prison.net            -n Pipsurugi'
#alias srk='       bx -a irc.rt.ru             -n Pipsurugi'
#alias srk='       bx -a qeast.net             -n Pipsurugi'
#-c #puzzlecraft -c #soulcalibur' # rt.ru 4, prison.net 6, homelien.no 7 #ogcapcom bap
#-c "#srk had0 spd0 j3w n1ce apex2 evl2003 mandalay hiddenvalley redrock" -c "#ogcapcom bap chigga"
alias psag='ps aux | grep'
alias ckya='w3m mail.yahoo.com'
alias cktm='w3m http://www.time.gov/timezone.cgi\?Pacific/d/-8'
alias j2k='joy2key $TTY -terminal -rcfile ~/.joy2keyrc -axis Left Right Up Down -buttons a b c d e f g h i j &'
alias j2kx='joy2key -X -rcfile ~/.joy2keyrc &'
alias gnuya='gnuyahoo -u=piptigger'
alias pingb='ping 192.168.1.255 -b'
alias setfont='consolechars -f' # fb lines on Gen:
alias fb6='fbset 640x480-60'    #              30
alias fb8='fbset 800x600-100'   #              37
alias fb10='fbset 1024x768-100' #              48
alias fb12='fbset 1280x1024-75' #              64
alias fb16='fbset 1600x1200-76' #              75
# SimplePrompt   ||   NormalPrompt   ||   BigPrompt
alias sp="export PS1='%(!.<.[)%n@$PipsHost:`pt`:%~%(!.>.])'"  
alias np="export PS1='%{[1;33m%}%(!.<.[)%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}$PipsHost%{[1;31m%}`pt`%{[1;34m%}%~%{[1;33m%}%(!.>.])%{[1;32m%}'"
alias bp="export PS1='%{[1;33m%}%(!.<.[)%{[1;36m%}%n%{[1;37m%}@%{[1;36m%}$PipsHost%{[1;31m%}`pt`%{[1;34m%}%~%{[1;33m%}%(!.>.])%{[1;32m%}'"
alias my='mysql -u root'
alias moz='/usr/local/mozilla/mozilla -P Pip'
#alias moz='mozilla 2>&1 >/dev/null &'
alias scrn='screen -h 9999 -S srk -t srk'
alias s2do=' pu ~/dox/2do/; screen -h 9999 -S 2do  -t 2do e 2;po'
alias s2='s2do'
alias ssync='cd ~/dox/2do/; screen -h 9999 -S sync -t sync'
alias scrnp4p='             screen -h 9999 -S p4p  -t p4p '
alias mplay='mplayer -vo gl'
alias mply=' mplayer -vo gl -nosound -geometry 1919x1150+0+0' #-x 1919 -y 1150' # mplayer can only start with 1920 width for some reason =(
alias mpr0=' mplayer -vo gl          -loop 0 -shuffle -geometry 1919x2350+0+0                            ~/mvz/pr0n/*'
alias mpr0n='mplayer -vo gl -nosound -loop 0 -shuffle -geometry 1919x1150+0+0                            ~/mvz/pr0n/*'
alias mpr0t='mplayer -vo gl -nosound                  -geometry 1919x1150+0+0 -msglevel all=0:identify=4 ~/mvz/pr0n/tst/*'
alias mpx='  mplay -fs' #-x 1280 -y 1024'
alias qloq='dclock -date "%A %B %d, %Y" -geometry 155x55+1120+953 -miltime -bg "#03071B" -led_off "#032B1B" &'
alias xqloq='xclock -digital -fg orange -bg black -rv -geometry 255x63 -update 1 -brief &'
alias echos='echo -n'
alias fp='fpal' # was fontpal
alias eqx='/home/pip/dvl/clda/eqx/equinox-0.8.7-Linux-glibc2.3/bin/eq &' # Gabor Nagy's EQuinoX
alias cln='    perl -e "print eval join q( ), @ARGV; "' # simple cmdln calculator
alias fstat='  perl -e "use Time::PT;@s=split(/ /,scalar(localtime((stat(shift))[9])));print \"@s\n\";"'
alias fstatpt='perl -e "use Time::PT;@s=split(/ /,scalar(localtime((stat(shift))[9])));print pt(@s),\"\n\";"'
#alias Et='Eterm --background-pixmap mits1024.jpg -c orange -T PipsEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --path /home/pip/.Eterm/ --default-font-index 4 &'
#alias Et='Eterm -c #ffa404 -T PipsEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --default-font-index 6 &'
alias Et='Eterm -T PipsEtrm --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --default-font-index 6 &'
alias gtrm='    gnome-terminal --geometry=80x46-0+0  --class=gtrm     --hide-menubar --window-with-profile=GT80x46Terminus18 --title=zsh &'
alias gterm='   gnome-terminal --geometry=160x64+0+0 --class=gterm    --hide-menubar --window-with-profile=GT160x64Courier14 &'
alias gnomterm='gnome-terminal --geometry=160x64+0+0 --class=gnomterm --show-menubar --window-with-profile=GT160x64Courier14 &'
alias gtpt='    gnome-terminal --display=:0.0 --class=ptok  --geometry  27x1+3002+1141 --hide-menubar --window-with-profile=GT27x1AndaleMono40-ptok --title=ptok -e ptok &'
alias gtpm='    gnome-terminal --display=:0.0 --class=pmix  --geometry 160x3+1921+1141 --hide-menubar --window-with-profile=GT67x3Lincoln12-pmix    --title=pmix -e pmix &' # 160, 180, 282

rsyncz() { # as root, rsync current boot drive (/dev/sda) over to secondary (/dev/sdb) mounted in /z
  if [ "$USER" != "root"     ]; then # if ! root user, print eror && quit
    echo "!*EROR*! $0 must be run as root!"
  else
    if [ ! -d "/z/boot"      ]; then # if ! mounted /dev/sdb3 /z     , try to mount first
      echo "Attempting to mount /z..."
      mount /dev/sdb3 /z
    fi
    if [ ! -d "/z/boot/grub" ]; then # if ! mounted /dev/sdb1 /z/boot, try to mount too
      echo "Attempting to mount /z/boot..."
      mount /dev/sdb1 /z/boot
    fi
    if [ ! -d "/z/boot/grub" ]; then # if still not there, eror out
      echo "!*EROR*! $0 could not mount /z and /z/boot!"
    else
      if [ ! -d "/z/proc" ]; then
        mkdir /z/proc
      fi
      if [ ! -d "/z/sys"  ]; then
        mkdir /z/sys
      fi
      if [ ! -d "/z/z"    ]; then
        mkdir /z/z
      fi
      rsync -av --delete /portage-*.bz2 /z
      rsync -av --delete /sbin          /z
      rsync -av --delete /[A-ort-v]*    /z
    fi # takes ~8.5hours or ~4hours on empty 3Gb/s SATA
  fi
}

# old WindowMaker wharf ATerm button
# aterm -fn "-*-*-*-*-*-*-15-*-*-*-*-*-*-*"  -bg "#03071B" -fg "#88F8B0" --cursorColor "#30D0F0" --cursorColor2 "#204080" -pr "#D8D870" -vb -fb "-*-*-*-*-*-*-19-*-*-*-*-*-*-*" -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047
# ptokterm -fn "-ttf-lucida console-*-*-*-*-47-*-*-*-*-*-*-*" -bg #03071B -fg #88F8B0 --cursorColor #30D0F0 --cursorColor2 #204080 -pr #D8D870 -vb -fb "-ttf-lucida console-*-*-*-*-48-*-*-*-*-*-*-*" -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 -color3 #FF9911 -color13 #AA22BB -geometry 27x1+492+972
At() {
  echo At params that don\'t leave residue: 11,12,17,18,20,22,23,28,31,32,40,41,49
  echo mixr bar Gen: At 17, 44x3+0+950 Eiji: 105x3 # no border, always top
  if [ "$1" = "" ]; then
    aterm -geometry 80x30 -color3 "#FFAA33" -color13 "#9933BB" -fn "-ttf-lucida console-*-*-*-*-17-*-*-*-*-*-*-*"  -bg "#03071B" -fg "#88F8B0" --cursorColor "#30D0F0" --cursorColor2 "#204080" -pr "#D8D870" -vb -fb "-ttf-lucida console-*-*-*-*-17-*-*-*-*-*-*-*" -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 &
  else
    aterm -geometry 80x30 -color3 "#FFAA33" -color13 "#9933BB" -fn "-ttf-lucida console-*-*-*-*-$1-*-*-*-*-*-*-*"  -bg "#03071B" -fg "#88F8B0" --cursorColor "#30D0F0" --cursorColor2 "#204080" -pr "#D8D870" -vb -fb "-ttf-lucida console-*-*-*-*-$1-*-*-*-*-*-*-*" -tr -trsb -sh 31 -fade 63 -sb -sr -sl 2047 &
  fi
}
goo() { # should probably pass $@ =~ s/ /+/g; or something smarter than this
  w3m "HTTP://Google.Com/search?q=$1+$2+$3+$4+$5+$6+$7+$8"
}
grp() { # grep stuff I like
  grep -i -n $1 $2 2>/dev/null
}
#cp() { # a many-argument form of cp where all parameters are remote files to be copied into the current directory
#  if [ $# -gt 2 ] && [ ! -d ${$#} ]; then
#    /bin/cp $@ .
#    return 0
#  fi
#  /bin/cp $@
#}
src() {  
  [ $# -lt 1 ] && {
    source ~/.zshrc
    return 0
  }
  source $@
}
mc() {  # used to be mcd for Mk&&ChDir on $1 but just MakeChng, MkCh is nicer, && now also does MvFil $1 into && ChDir $2
  if   [ $# -eq 2 ] && [   -f "$1" ] && [ -d "$2" ]; then
    if [ -d "$2" ]; then
      mv $1 $2
      cd $2
    elif [ "$VERBOSE" = 1 ]; then
      echo "!*EROR*! Can\'t MvFil $1 into ChDir $2!"
    fi
  elif [ $# -eq 1 ] && [ ! -f "$1" ]; then
    if [ ! -d "$1" ]; then
      md $1
    elif [ "$VERBOSE" = 1 ]; then
      echo "!*EROR*! Can\'t MkDir $1!"
    fi
    if [ -d "$1" ]; then
      cd $1
    elif [ "$VERBOSE" = 1 ]; then
      echo "!*EROR*! Can\'t ChDir $1!"
    fi
  elif [ "$VERBOSE" = 1 ]; then
    echo "!*EROR*! Invalid arguments to either Mk&&ChDir $$1 (DrNm) or Mv $$1 (FlNm) to existing Dir $$2 (DrNm) before ChDir into DrNm!"
  fi
}
ss() { # ssh
  if [ "$1" = "" ]; then
    sslbox
  else
    ssh $@
  fi
}
pmei() { # pronounced: "PerlMei" like "PaiMei" in KillBill
  if [ "$USER" != "root" ] && [ "$OSTYPE" != "cygwin" ]; then
    sudo perl -MCPAN -e "install '$@'"
  else
         perl -MCPAN -e "install '$@'"
  fi
}
pdoc() {
  /usr/bin/perldoc    $@ | less # most messes up perldoc output
}
perldoc() {
  /usr/bin/perldoc -t $@        # most should just get the text-only version (not pod2man | nroff -man | $PAGER)
}
pmvertst() {
  perl -MExtUtils::MakeMaker -le 'print MM->parse_version(shift)' $1
}
alias rsyn='rsynlbox'
rsynlbox() {
  if [ "$1" = "dox" ] || [ "$1" = "dvl" ]; then
    cd
    rsync -tavz $1 LBox.Org:
  fi
  if [ "$1" = "" ]; then
    cd
    rsync -tavz dox LBox.Org:
    rsync -tavz dvl LBox.Org:
  fi
}
uz() {
  [ $# -lt 1 ] && {
    if [ "$VERBOSE" = 1 ]; then
      echo "!*EROR*! Nothing to UntarZip!"
    fi
    return 0
  }
  file=$1
  succ=0
  if [ -f "$1" ] && [ -r "$1" ]; then
    if [ "${file:e}" = "bz" ] || [ "${file:e}" = "bz2" ] || [ "${file:e}" = "tbz" ] || [ "${file:e}" = "tbz2" ]; then
      if tar xIvf $@ 2>/dev/null || tar xvf $@ 2>/dev/null || bunzip2 $@ 2>/dev/null; then
        succ=1
      fi
    elif [ "${file:e}" = "zip" ] && unzip $@ 2>/dev/null; then
      succ=1
    elif tar xzvf $@ 2>/dev/null || tar xvf $@ 2>/dev/null || gunzip  $@ 2>/dev/null; then
      succ=1
    fi
    if [ "$VERBOSE" = 1 ]; then
      if [ $succ ]; then
        echo "Successfully UntarB?Zipped file: $1!"
      else
        echo "!*EROR*! Can\'t UntarB?Zip file: $1!"
      fi
    fi
  elif [ "$VERBOSE" = 1 ]; then
    echo "!*EROR*! Can\'t find tarB?Zip file: $1!"
  fi
}
function xpwd () { pwd | xclip -i; xclip -o ; }
function xcd  () { cd             `xclip -o`; }
if [ "$OSTYPE" = "cygwin" ]; then # updtdb optz          # /proc/registry/HKEY_CLASSES_ROOT/Installer/Assemblies &&         (these should also be pruned)
#  export PRUNEPATHS="/c/System\\ Volume\\ Information"  # /proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Explorer/UserAssist
#  export PRUNEPATHS="/c/System\\ Volume\\ Information /proc/registry/HKEY_CLASSES_ROOT/Installer/Assemblies /proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Explorer/UserAssist"
#  export   NETPATHS="/c"
#--findoptions='-option1 -option2...' - Global optz4find.                         $ENV{FINDOPTIONS} also sets this value. Default:none
#--localpaths='    path1    path2...' - Non-network directories to put in the db.                                         Default:/
#--netpaths='      path1    path2...' - Network(NFS,AFS,RFS,etc.) dirz2put in db. $ENV{NETPATHS   } also sets this value. Default:none
#--prunepaths='    path1    path2...' - Dirz wich would but should! be put in db. $ENV{PRUNEPATHS } also sets this value. Default:/(((us|va)r/)?tmp|afs)
  alias updtdb='updatedb --localpaths="/c" --prunepaths="/c/System\\ Volume\\ Information /proc/registry/HKEY_CLASSES_ROOT/Installer/Assemblies /proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/Explorer/UserAssist"'
fi # note: s|/$|| (rm trailing slashes from pathz2omit) or updtdb will treat as RegExes.
# 47GM3BY tmp pokr env varz (NO Slashes on end!)
#   first is local path to data dir
#export   pokr=~/dvl/pokr/c
#export ldpokr=piptigger@lbox.org:dvl/pokr/c
#export lcpokr=piptigger@lbox.org:public_html/cgi-bin/pokr
#export ld=piptigger@lbox.org:dvl
# The following lines were added by compinstall (77PLPFw - then edited by Pip)
zstyle ':completion:*' completer _expand _complete _approximate
zstyle ':completion:*' list-colors ${(s.:.)lsrc}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 1 numeric
zstyle ':completion:*' menu select=4
zstyle ':completion:*' prompt '[%e] '
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
#zstyle ':completion::complete:*' use-cache 1 # enable cache for completions
zstyle :compinstall filename '/home/pip/.zshrc'
autoload   -U zmv
autoload   -U promptinit
              promptinit
if [ "$OSTYPE" != "cygwin" ]; then # was ckng PipsHost vs Taki|WSI01|W-PStu
  autoload -U   compinit
                compinit
                compdef _man w3mman
fi
# End of lines added by compinstall
