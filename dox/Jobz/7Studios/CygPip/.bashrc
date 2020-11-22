# ~/.bashrc: executed by bash(1) for non-login shells.
export PATH=".:~/bin:$PATH" # add sbinz to PATH if root ... how 2 ck tho?
export SHELL="/bin/bash"
export PERL5LIB="$HOME/lib:$HOME/lib/site"
#export VERBOSE="1"
#export ETERM_THEME_ROOT="~/.Eterm/themes/Eterm"
if   [ "$HOSTNAME" = "BinQ.org"           ]; then
  export HOSTNAME='BinQ'
elif [ "$HOSTNAME" = "Ax9.org"            ]; then
  export HOSTNAME='Ax9'
elif [ "$HOSTNAME" = "Genjuro"            ]; then
  export HOSTNAME='Gen'
elif [ "$HOSTNAME" = "dimension"          ]; then
  export HOSTNAME='LBox'
elif [ "$HOSTNAME" = "powerpuff.lbox.org" ]; then
  export HOSTNAME='LBox'
fi
#export PS1='[\u@\h:\w]\$ '
# colorless [pip@kaka:~]$ in case bash sucks! =) j/k
umask 022
# You may uncomment the following lines if you want `ls' to be colorized:
#export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:*.jpg=01;36:*.gif=01;36:*.png=01;36:*.asm=1;35:*.c=1;35:*.h=1;35:*.cpp=1;35:*.m=1;35:*.o=0;31:*.gz=0;32:*.bz2=0;32;*.zip=0;32:*.html=1;32:*.htm=1;32:*.pl=1;32:*.pm=1;32:*.cgi=1;32:di=0;36:ex=1;33:ln=1;37:*.txt=1;37'
export LS_COLORS='*.asm=1;35:*.c=1;35:*.h=1;35:*.cpp=1;35:*.m=1;35:*.o=0;31:*.gz=0;32:*.bz2=0;32;*.zip=0;32:*.html=1;32:*.htm=1;32:*.pl=1;32:*.pm=1;32:*.cgi=1;32:di=0;36:ex=1;33:ln=1;37:*.txt=1;37'
export LS_OPTIONS='--color=auto'
#export PS1='\[\033[1;33m[\[\033[0;36m\u\[\033[1;37m@\[\033[0;36m\h\[\033[1;30m:\[\033[1;31m`pt`\[\033[1;30m:\[\033[1;34m\w\[\033[1;33m]\[\033[1;32m\$ '
#export PS1='\[\033[1;33m[\[\033[1;36m\u\[\033[1;37m@\[\033[1;36m$HOSTNAME\[\033[1;31m`pt`\[\033[1;34m\w\[\033[1;33m]\[\033[1;32m\$ '
#export PS1='\033[1;33m[\033[36m\u\033[37m@\033[36m${HOSTNAME}\033[1;31m`pt`\033[1;34m\w\033[33m]\033[32m\$ '
export PS1='\033[1;33m[\033[36m\u\033[37m@\033[36m${HOSTNAME}\033[31m`pt`\033[34m\w\033[33m]\033[32m\$'
#\033\[1;32m\$'
export CVSROOT='/var/cvs'
export EDITOR='vim'
if [ "$HOSTNAME" != "LBox" ]; then
  alias ls='ls $LS_OPTIONS'
  eval `dircolors`
fi
alias l='ls -l'
alias ll='l -F'
alias la='l -A'
#alias ld='l -d' # Beppu said this is an important linker so don't alias it!
alias lsa='ls -A'
alias lsd='ls -d */'
alias more='most'
alias vi='vim'
#alias /='cd /' # invalid alias for some versions of bash?
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
alias md='mkdir'
alias rd='rmdir'
alias cls='clear'
alias copy='cp'
alias move='mv'
alias del='rm'
alias x='exit'
#alias ft='ncftp'
alias tn='telnet'
#alias grp='grep -n -i'
alias zp='tar czvf'
#alias uz='tar xzvf'
#alias ssbinq='ssh -l pip 192.168.0.7'
alias sslbox='ssh -l piptigger lbox.org'
alias sshelium='ssh -l pip helium.mindfireis.com'
#alias ss='sshelium'
alias ssquark='ssh -l pip quark.mindfireis.com'
alias ssproduction='ssh -l pip production.mindfireis.com'
alias ssprod='ssproduction'
alias ssukyo='ssh -l pip 192.168.1.114'
alias ssneptune='ssh -l pip 192.168.1.2'
alias ssquincy='ssh -l pip 192.168.1.9'
alias sstest='echo BTnj434; ssh -l nr0384 test-center.net'
alias ssax9='ssh -l pip ax9' #192.168.0.1'
alias ssgenjuro='ssh -l pip gen' #192.168.0.3'
alias ssgen='ssgenjuro'
#alias ftbinq='ncftp -u pip binq.org'
alias ftlbox='ncftp -u piptigger lbox.org'
alias fthelium='ncftp -u pip helium.mindfireis.com'
alias ftquark='ncftp -u pip quark.mindfireis.com'
alias ftproduction='ncftp -u pip production.mindfireis.com'
alias ftprod='ftproduction'
alias ftukyo='ncftp -u pip 192.168.1.114'
alias ftneptune='ncftp -u pip 192.168.1.2'
alias ftquincy='ncftp -u pip 192.168.1.9'
alias fttest='echo BTnj434; ncftp -u nr0384 test-center.net'
alias ft9pnet='echo screwyou; ncftp -u download 9pnet.com'
alias ftgenjuro='ncftp -u pip 192.168.0.3'
alias ftgen='ftgenjuro'
alias db='rm *~'
alias my='mysql -u root'
alias cya='w3m mail.yahoo.com'
alias pingb='ping 192.168.0.255'
alias setfont='consolechars -f '
#alias e='binq'
alias sp="export PS1='[\u@\h:\w]\$ '"  # SimplePrompt   ||   BeautifulPrompt
alias bp="export PS1='\[\033[1;33m[\[\033[0;36m\u\[\033[1;37m@\[\033[0;36m\h\[\033[1;30m:\[\033[1;35m\d\[\033[1;30m:\[\033[1;31m\t\[\033[1;30m:\[\033[1;34m\w\[\033[1;33m]\[\033[1;32m\$ '"
alias my='mysql -u root'
#alias grp='grep -i -n'
alias moz='mozilla 2>&1 >/dev/null &'
alias qloq='dclock -date "%A %B %d, %Y" -geometry 155x55+1120+953 -miltime -bg "#03071B" -led_off "#032B1B" &'
alias echos='echo -n'
alias cln='perl -e "print eval join q( ), @ARGV"' #simple cmdline calculator
#alias Et='Eterm --background-pixmap mits1024.jpg -c orange -T PipsEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --path /home/pip/.Eterm/ --default-font-index 4 &'
#alias Et='Eterm -c #ffa404 -T PipsEtrm --scrollbar-type motif --scrollbar-color blue --scrollbar-width 15 --scrollbar-right --default-font-index 6 &'
alias Et='Eterm -T PipsEtrm --scrollbar-type motif --scrollbar-width 15 --scrollbar-right --default-font-index 6 &'
ftbinq() {
  if [ "$HOSTNAME" = "Gen" ]; then
    ncftp -u pip 192.168.0.7
  elif [ "$HOSTNAME" = "Ax9" ]; then
    ncftp -u pip 192.168.0.7
  else
    ncftp -u pip BinQ.org
  fi
}
ssbinq() {
  if [ "$HOSTNAME" = "Gen" ]; then
    ssh -l pip 192.168.0.7
  elif [ "$HOSTNAME" = "Ax9" ]; then
    ssh -l pip 192.168.0.7
  else
    ssh -l pip BinQ.org
  fi
}
ft() { # ncftp alias
  if [ "$1" = "" ]; then
    ftbinq
  else
    ncftp $@
  fi
}
ss() { # ssh
  if [ "$1" = "" ]; then
    ssax9
  else
    ssh $@
  fi
}
grp() { # grep stuff I like
  grep -i -n $1 $2 2>/dev/null
}
unalias mc
mc() {  # used to be mcd for Mk&&ChDir but MakeChng werks too! =)
  if [ ! -d "$1" ]; then 
    md $1
  elif [ "$VERBOSE" = 1 ]; then
    echo "!*ERROR*! Can't MkDir $1!"
  fi
  if [ -d "$1" ]; then
    cd $1
  elif [ "$VERBOSE" = 1 ]; then
    echo "!*ERROR*! Can't ChDir $1!"
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
    if [ "$VERBOSE" = 1 ]; then
      echo "!*ERROR*! Nothing to UntarZip!"
    fi
    return 0
  }
  if [ -f "$1" ] && [ -r "$1" ]; then
    if tar xzvf $@ 2>/dev/null || tar xvf $@ 2>/dev/null || gunzip $@ 2>/dev/null; then
      if [ "$VERBOSE" = 1 ]; then
        echo "Successfully UntarZipped file: $1"
      fi
    else
      if [ "$VERBOSE" = 1 ]; then
        echo "!*ERROR*! Can't UntarZip file: $1!"
      fi
    fi
  else
    if [ "$VERBOSE" = 1 ]; then
      echo "!*ERROR*! Can't find tarZip file: $1!"
    fi
  fi
}
e() {  
  [ $# -lt 1 ] && {
    $EDITOR $EDTF
    return 0
  }
  if [ -d "$1" ] ; then
    if [ "$VERBOSE" = 1 ]; then
      echo "!*ERROR*! Can't edit directory: $1!"
    fi
    return 0
  elif [ "$1" = a ] ; then
    export LASF=$EDTF
    export EDTF=~/.bashrc
  elif [ "$1" = l ] ; then
    export KAKA=$EDTF
    export EDTF=$LASF
    export LASF=$KAKA
  else
    export LASF=$EDTF
    export EDTF=$@
  fi
  $EDITOR $EDTF
}
e3() {  
  [ $# -lt 1 ] && {
    binq3 $EDTF
    return 0
  }
  if [ -d "$1" ] ; then
    if [ "$VERBOSE" = 1 ]; then
      echo "!*ERROR*! Can't edit directory: $1!"
    fi
    return 0
  elif [ "$1" = a ] ; then
    export LASF=$EDTF
    export EDTF=~/.bashrc
  elif [ "$1" = l ] ; then
    export KAKA=$EDTF
    export EDTF=$LASF
    export LASF=$KAKA
  else
    export LASF=$EDTF
    export EDTF=$@
  fi
  binq3 $EDTF
}
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#setfont med2
export LANG=C
