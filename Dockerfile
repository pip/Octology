# L43MEANS:Dockerfile crE8d by JohnBeppu-san <Beppu@CPAN.Org> for Pip's GitHub Octology;my $d8VS='L5SMLexp';
# Use a big desktop distro (Ubuntu) as base, so that graphical && audio packages are available in container;
FROM ubuntu:20.04
# Force TZ to avoid interactive configur8ion; Also TERM BlO mAy quell warnings;
# HTTPS://Dev.To/setevoy/docker-configure-tzdata-and-timezone-during-build-20bk
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime &&  echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm-256color            \
    XKBMODEL=pc105                 \
    XKBLAYOUT=us                   \
    XKBVARIANT=""                  \
    XKBOPTIONS=""                  \
    BACKSPACE=guess
#           install packages; # try to just get apt-utils first, so dconf uses;  # bash `set -x` enables outputting executing cmndz mainly 4Dbuging scrptz;
RUN set                     -x &&  \
    apt-get update             &&  \
    apt-get install         -y     \
       --no-install-recommends     \
    apt-utils                  &&  \
    apt-get install         -y     \
       --no-install-recommends     \
  locales                          \
  build-essential                  \
  libreadline-dev                  \
     readline-common               \
  libreadline8                     \
       expect                      \
   tcl-expect                      \
  perl                             \
  perl-doc                         \
  cpanminus                        \
  liburi-perl                      \
  libexpect-perl                   \
  libpath-tiny-perl                \
  libterm-readline-gnu-perl        \
  libncurses-dev                   \
  ncurses-base                     \
  ncurses-bin                      \
  libdconf-dev                     \
  libdconf1                        \
      bsdmainutils                 \
  pulseaudio-utils                 \
     source-highlight              \
  libsource-highlight4v5           \
  libsource-highlight-common       \
  dconf-gsettings-backend          \
  dconf-service                    \
  dconf-cli                        \
  xbindkeys                        \
  xbindkeys-config                 \
  x11-xserver-utils                \
  tourney-manager                  \
  dreamchess                       \
  glaurung                         \
  gnuchess                         \
  hoichess                         \
  polyglot                         \
  phalanx                          \
  pychess                          \
  chessx                           \
  crafty                           \
  sjeng                            \
  hachu                            \
  tagua                            \
  uci2wb                           \
  xboard                           \
  sjaakii                          \
  fairymax                         \
  stockfish                        \
  p7zip-full                       \
  xz-utils                         \
  screen                           \
  orpie                            \
  bzip2                            \
  aview                            \
  perl6                            \
  scrot                            \
  sudo                             \
  tmux                             \
  yelp                             \
  htop                             \
  curl                             \
  dfc                              \
  zsh                              \
  git                              \
  tio                              \
  vim                              \
  vim-tiny                         \
  vim-common                       \
  vim-runtime                      \
  youtube-dl                       \
  libsmpeg-dev                     \
  libsmpeg0                        \
  libsdl-sge-dev                   \
  libsdl-sge                       \
  libsdl-gfx1.2-dev                \
  libsdl-gfx1.2-5                  \
  libsdl-pango-dev                 \
  libsdl-pango1                    \
  libsdl-console-dev               \
  libsdl-console                   \
  libsdl-kitchensink-dev           \
  libsdl-kitchensink1              \
  libalien-sdl-dev-perl            \
  libalien-sdl-perl                \
  libsdl-perl                      \
  vorbis-tools                     \
  irssi-scripts                    \
  irssi-dev                        \
  irssi                            \
  libflac-dev                      \
  libflac8                         \
     flac                          \
  xdotool                          \
  mpg321                           \
  mpg123                           \
  gst123                           \
  xclip                            \
  most                             \
  dict                             \
  dictd                            \
  dict-wn                          \
  dict-vera                        \
  dict-devil                       \
  dict-gcide                       \
  dict-foldoc                      \
  dict-jargon                      \
  dict-elements                    \
  gnome-terminal                   \
  xfce4-terminal                   \
  mate-terminal                    \
  rxvt-unicode                     \
  terminology                      \
  terminator                       \
  lxterminal                       \
  stterm                           \
  sakura                           \
  s3dvt                            \
  aterm                            \
  pterm                            \
  eterm                            \
  xterm                            \
  termit                           \
  konsole                          \
  lilyterm                         \
  qterminal                        \
  terminal.app                     \
  cool-retro-term              &&  \
  rm  -rf /var/lib/apt/lists/* &&  \
  locale-gen "en_US.UTF-8"
# locale setting;  # above appended long list of terminal emul8or programs which may come in handy, even if Gnome-Terminal is mostly used ahead of altern8z;
# HTTPS://StackOverFlow.Com/a/57158691
ENV      LANG=en_US.UTF-8          \
       LC_ALL=en_US.UTF-8          \
     LANGUAGE=en_US:en             \
 NO_AT_BRIDGE=1
# install 3rd-party Perl5 dependencies;
RUN cpanm  --notest                \
  Time::DaysInMonth                \
  Time::PT                         \
  Text::CSV                        \
  Term::ReadKey                    \
  Color::Similarity                \
  Curses                           \
  Expect                           \
  URI
# Add a unix user (just 'tst' for now [was 'pip' originally from Beppu-san, but probably better as just palindromatic "test" instead for trying out]);
# HTTPS://StackOverFlow.Com/a/27703359   [ -p aaoCFznDGNVHs was with User 'pip' prior to changing to 'tst' && piping through instead chpasswd fine ]
# HTTPS://StackOverFlow.Com/a/1022024
RUN useradd -m      -G sudo      -s /bin/zsh tst && echo tst:test | chpasswd && \
    echo       'export HOST=Oct;cat /etc/motd;'  >> /etc/zsh/zprofile        && \
    echo       'export HHst=Oct;'                >> /etc/zsh/zprofile        && \
    echo                   'Oct'                 >  /etc/hostname
# RUN echo "l8r run: 'sudo hostname Oct' or 'dkrx' then 'hn Oct' ;" # Set what probably came from Oni,Aku,Ryu,orKen to Oct (or whatever HostName you want?);
# Copy core Octology files into: tst's $HOME;  # Above should call host something other than Docker's default hexadecimal name for the container image made;
COPY   --chown=tst:tst .Hrc .Xrc .bashrc .lrc .lsrc \
  .shl.style .vimrc  .zshrc  /home/tst/
COPY         .log/motd .log/asound.conf /etc/
COPY   --chown=tst:tst .log  /home/tst/.log/
COPY   --chown=tst:tst  lib  /home/tst/lib/
COPY   --chown=tst:tst  bin  /home/tst/bin/
COPY   --chown=tst:tst  dvl  /home/tst/dvl/
COPY   --chown=tst:tst  dox  /home/tst/dox/
COPY   --chown=tst:tst  gfx  /home/tst/gfx/
COPY   --chown=tst:tst  gmz  /home/tst/gmz/
COPY   --chown=tst:tst  muz  /home/tst/muz/
COPY   --chown=tst:tst  mvz  /home/tst/mvz/
# install                     vim-plug;
# HTTPS://GitHub.Com/junegunn/vim-plug
# HTTPS://GitHub.Com/junegunn/vim-plug/issues/675
RUN  curl  -sfLo             /home/tst/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim   \
  && chown -R  tst:tst       /home/tst/.vim
# Set a default command for the container;  # Not sure how to best go about running a new container with own login which starts by printing some help text? ;
#    su    -c "vim +'PlugInstall --sync' +qa" tst
CMD  su    -l  tst  -w DISPLAY,NO_AT_BRIDGE
#          -c 'echo "Welcome to PipS Octology! Please try2run: ec \$R Red \$O Orn \$Y Yel \$G Grn \$C Cyn \$B Blu \$M Mgn \$P Prp \$z zero-Reset" '
# Build:  `dkrb`
#   docker build .  -t oct
# Run  :  `dkrun`    # probably `dkrs` prunes system && `dkra` for -all
#   docker   run   -it oct
# Run w/ local directory mounted inside container :        `dkrn`
#   docker run -v type=bind,source=/local/dir,target=/cntnr/dir -it oct
# List   currently   running   docker   containers:        `dkrp`
#   docker ps
# Connect to running docker container by id (found via `docker ps`): `dkre` or `dkrx` (latter zsh function which captures first id from dkrp output list);
#   docker exec   -it $id zsh
