# L43MEANS:Dockerfile crE8d by JohnBeppu-san <Beppu@CPAN.Org> for Pip's GitHub Octology;my $d8VS='L46M64CJ';
# Use a big desktop distro (Ubuntu) as base, so that graphical && audio packages are available in container;
FROM ubuntu:20.04
# Force TZ to avoid interactive configur8ion; Also TERM BlO mAy quell warnings;
# HTTPS://Dev.To/setevoy/docker-configure-tzdata-and-timezone-during-build-20bk
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime &&  echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm-256color     \
    XKBMODEL=pc105          \
    XKBLAYOUT=us            \
    XKBVARIANT=""           \
    XKBOPTIONS=""           \
    BACKSPACE=guess
#           install packages; # try to just get apt-utils first, so dconf uses;  # bash `set -x` enables outputting executing cmndz mainly 4Dbuging scrptz;
RUN set               -x && \
    apt-get update       && \
    apt-get install      -y \
    --no-install-recommends \
    apt-utils            && \
    apt-get install      -y \
    --no-install-recommends \
  locales                   \
  build-essential           \
  libreadline-dev           \
  readline-common           \
  libreadline8              \
  perl                      \
  perl-doc                  \
  cpanminus                 \
  libpath-tiny-perl         \
  libterm-readline-gnu-perl
RUN apt-get install      -y \
    --no-install-recommends \
  libncurses-dev            \
  ncurses-base              \
  ncurses-bin               \
  libdconf-dev              \
  libdconf1                 \
  bsdmainutils              \
  pulseaudio-utils          \
   source-highlight          \
  libsource-highlight4v5     \
  libsource-highlight-common \
  dconf-gsettings-backend   \
  dconf-service             \
  dconf-cli                 \
  xbindkeys                 \
  xbindkeys-config          \
  tourney-manager           \
  dreamchess                \
  glaurung                  \
  gnuchess                  \
  hoichess                  \
  polyglot                  \
  phalanx                   \
  pychess                   \
  chessx                    \
  crafty                    \
  sjeng                     \
  hachu                     \
  tagua                     \
  uci2wb                    \
  xboard                    \
  sjaakii                   \
  fairymax                  \
  stockfish                 \
  p7zip-full                \
  xz-utils                  \
  screen                    \
  orpie                     \
  bzip2                     \
  aview                     \
  perl6                     \
  scrot                     \
  sudo                      \
  tmux                      \
  yelp                      \
  htop                      \
  curl                      \
  dfc                       \
  zsh                       \
  git                       \
  tio                       \
  vim                       \
  vim-tiny                  \
  vim-common                \
  vim-runtime               \
  youtube-dl                \
  libsmpeg-dev              \
  libsmpeg0                 \
  libsdl-sge-dev            \
  libsdl-sge                \
  libsdl-gfx1.2-dev         \
  libsdl-gfx1.2-5           \
  libsdl-pango-dev          \
  libsdl-pango1             \
  libsdl-console-dev        \
  libsdl-console            \
  libsdl-kitchensink-dev    \
  libsdl-kitchensink1       \
  libalien-sdl-dev-perl     \
  libalien-sdl-perl         \
  libsdl-perl               \
  vorbis-tools              \
  irssi-scripts             \
  irssi-dev                 \
  irssi                     \
  libflac-dev               \
  libflac8                  \
     flac                   \
  xdotool                   \
  mpg321                    \
  mpg123                    \
  gst123                    \
  xclip                     \
  most                      \
  dict                      \
  dictd                     \
  dict-wn                   \
  dict-vera                 \
  dict-devil                \
  dict-gcide                \
  dict-foldoc               \
  dict-jargon               \
  dict-elements             \
  gnome-terminal            \
  xfce4-terminal            \
  mate-terminal             \
  rxvt-unicode              \
  terminology               \
  terminator                \
  lxterminal                \
  stterm                    \
  sakura                    \
  s3dvt                     \
  aterm                     \
  pterm                     \
  eterm                     \
  xterm                     \
  termit                    \
  konsole                   \
  lilyterm                  \
  qterminal                 \
  terminal.app              \
  cool-retro-term           \
  && rm -rf /var/lib/apt/lists/* && \
  locale-gen "en_US.UTF-8"
# locale setting;  # above appended long list of terminal emul8or programs which may come in handy, even if Gnome-Terminal is mostly used ahead of altern8z;
# HTTPS://StackOverFlow.Com/a/57158691
ENV      LANG=en_US.UTF-8   \
       LC_ALL=en_US.UTF-8   \
     LANGUAGE=en_US:en
# install 3rd-party Perl dependencies;
RUN cpanm  --notest         \
  Time::DaysInMonth         \
  Time::PT                  \
  Text::CSV                 \
  Term::ReadKey             \
  Curses                    \
  Color::Similarity
# Add a unix user;
# HTTPS://StackOverFlow.Com/a/27703359
# HTTPS://StackOverFlow.Com/a/1022024
RUN useradd -m -G sudo -s /bin/zsh -p aaoCFznDGNVHs pip
# Copy core Octology files into: pip's $HOME;
COPY --chown=pip:pip .Hrc .Xrc .bashrc .lrc .lsrc \
  .shl.style .vimrc .zshrc /home/pip/
COPY --chown=pip:pip .log  /home/pip/.log/
COPY --chown=pip:pip  lib  /home/pip/lib/
COPY --chown=pip:pip  bin  /home/pip/bin/
COPY --chown=pip:pip  dvl  /home/pip/dvl/
COPY --chown=pip:pip  dox  /home/pip/dox/
COPY --chown=pip:pip  gfx  /home/pip/gfx/
COPY --chown=pip:pip  gmz  /home/pip/gmz/
COPY --chown=pip:pip  muz  /home/pip/muz/
COPY --chown=pip:pip  mvz  /home/pip/mvz/
# install                     vim-plug;
# HTTPS://GitHub.Com/junegunn/vim-plug
# HTTPS://GitHub.Com/junegunn/vim-plug/issues/675
RUN  curl  -sfLo      /home/pip/.vim/autoload/plug.vim --create-dirs  \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  && chown -R pip:pip /home/pip/.vim
ENV  NO_AT_BRIDGE=1
# Set a default command for the container;
#    su    -c "vim +'PlugInstall --sync' +qa" pip
CMD  su    -l pip  -w DISPLAY,NO_AT_BRIDGE  -c 'echo "Welcome to Pip's Octology! Please try: en $R Red $o orn $Y Yel $G Grn $C Cyn $B Blu $M Mgn $p prp $z;"'
# Build:  `dkrb`
#   docker build . -t oct
# Run  :  `dkrun`
#   docker run    -it oct
# Run w/ local directory mounted inside container :        `dkrn`
#   docker run -v type=bind,source=/local/dir,target=/cntnr/dir -it oct
# List   currently   running   docker   containers:        `dkrp`
#   docker ps
# Connect to running docker container by id (found via `docker ps`): `dkre` or `dkrx` (latter zsh function which captures first id from dkrp output list);
#   docker exec   -it $id zsh
