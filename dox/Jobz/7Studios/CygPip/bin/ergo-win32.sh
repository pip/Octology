#!/bin/bash
# 7AACqk2 - ergo-win32.sh from HTTP://Ergo.Rydlr.Net/?p=4 creates a ~/.ergo/
# cp dir_colors_* to $HOME/.ergo
#ergo dir
export ergo="$HOME/.ergo";
# environment
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:~/$ergo:
# aliases
alias m='more ';
alias ls='ls --color=always '; # colors are useful. disable w/: `unalias ls`
alias l='ls -lF ';
alias ll='ls -lAF ';
alias lm='l | m ';
alias llm='ll | m '
alias lsd='ls -lAd */ '; # list only directories
alias ltr='l -tr';       # list in reverse order of creation/modified time
alias g='grep ';
alias md='mkdir ';
alias rd='rmdir ';
alias ..='cd .. ';
alias rm='rm -i ';
alias h='history ';
alias j='jobs ';
alias k9='kill -9';
alias d='dirs -l -p -v ';
HISTCONTROL=ignoreboth;
HISTIGNORE=l:ll:h:rmj:lm:llm:ls:lsa:lsd:ltr:d:m
shopt -s no_empty_cmd_completion
function -() { # handy shortcut to return to previous current directory
  cd -;
}
function /() {
  cd /;
}
function e() { # emacs
  if [ "$TERM" = 'xterm' ]; then
    for file in $*
    do
      /cygdrive/c/utils/emacs/bin/runemacs.bat $file &
    done
  elif [ "$TERM" = 'linux' ]; then
    emacs $1;
  fi
}
function rmj() { # removes emacs backup files
  startdir=$1;
  if [ ! -d $startdir ]; then
    echo "Non-existant dir";
    exit 0;
  fi
  retval=`find ${startdir:-.} \( -name \*~ -o -name .\*~ -o -name \#*\#  -o -name .\#* \)`;
  if [ -z "$retval" ]; then
    echo "${startdir:-`pwd`}/* is clean";
    exit 0;
  else
    echo "$retval";
  fi
  read -p "Descend and delete[Y/n]?"
  if [ -z "$REPLY" -o "$REPLY" == "y" ]; then
    find ${stardir:-.} \( -name \*~ -o -name .\*~ -o -name \#*\# -o -name .\#* \) -exec rm {} \;
  fi
}
function ww() { # Launch Microsoft Word
  /cygdrive/c/Program\ Files/Microsoft\ Office/OFFICE11/WINWORD.EXE "$1" &
}
function xl() { # Launch Microsoft Excel
  /cygdrive/c/Program\ Files/Microsoft\ Office/OFFICE11/EXCEL.EXE "$1" &
}
function eh() { # Launch Windows Explorer in the current directory
  explorer /e, `pwd | cygpath -w -f -` &
}
# Vanilla prompt
function vp() {
  if [ "$UID" = 0 ];then
    PS1="#";
  else
    PS1="$";
  fi
}
function ep() { #ergo prompt
  #verbose command prompt off
  set +v
  #color codes
  clr_green="\[\033[32m\]";
  clr_white="\[\033[0m\]";
  clr_blue="\[\033[34m\]";
  clr_lightblue="\[\033[1;34m\]";
  clr_red="\[\033[31m\]";
  #ergo prompt variables / colors
  clr_path=$clr_green;
  clr_bg=$clr_white;
  clr_host=$clr_red;
  #ergo xterm prompt (black text on white background)
  if [ "$TERM" == 'xterm' ]; then
    clr_user=$clr_blue;
    clr_dir=$clr_blue;
    PS1="{\$(jobs | wc -l | sed 's/ *//')}$clr_path[\$(pwd)]$clr_bg\n$clr_user\u$clr_bg@$clr_host\h$clr_bg$clr_dir \W $clr_bg$ "
  fi
  #ergo linux prompt (white text on black background)
  if [ "$TERM" == 'linux' ]; then
    clr_user=$clr_lightblue;
    clr_dir=$clr_lightblue;
    PS1="$clr_path[\$(pwd)]$clr_bg\n$clr_user\u$clr_bg@$clr_host\h$clr_bg$clr_dir \W $clr_bg$ "
  fi
  #################################################################
  # bash prompt color codes
  #"\[\033[0;30m\]" # Black
  #"\[\033[1;30m\]" # Dark Gray
  #"\[\033[0;31m\]" # Red
  #"\[\033[1;31m\]" # Light Red
  #"\[\033[0;32m\]" # Green
  #"\[\033[1;32m\]" # Light Green
  #"\[\033[0;33m\]" # Brown
  #"\[\033[1;33m\]" # Yellow
  #"\[\033[0;34m\]" # Blue
  #"\[\033[1;34m\]" # Light Blue
  #"\[\033[0;35m\]" # Purple
  #"\[\033[1;35m\]" # Light Purple
  #"\[\033[0;36m\]" # Cyan
  #"\[\033[1;36m\]" # Light
  #"\[\033[0;37m\]" # Light Gray
  #"\[\033[1;37m\]" # White
  #"\[\033[0m\]"    # Neutral
  # Octal listing of colors
  # Black      0;30   Dark Gray    1;30
  # Blue       0;34   Light Blue   1;34
  # Green      0;32   Light Green  1;32
  # Cyan       0;36   Light Cyan   1;36
  # Red        0;31   Light Red    1;31
  # Purple     0;35   Light Purple 1;35
  # Brown      0;33   Yellow       1;33
  # Light Gray 0;37   White        1;37
  #################################################################
} # end ergo prompt
if [ "$TERM" = "xterm" ]; then #ergo dir colors
  eval `dircolors --sh $ergo/dir_colors_xterm`
fi
if [ "$TERM" = "linux" ]; then
  eval `dircolors --sh $ergo/dir_colors_linux`
fi
ep; # use the ergo prompt
