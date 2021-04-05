# Use a big desktop distro as a base, so graphical and audio packages are available.
FROM ubuntu:20.04
# Force TZ to avoid interactive configuration.
# HTTPS://Dev.To/setevoy/docker-configure-tzdata-and-timezone-during-build-20bk
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Install packages.
RUN apt-get update  && \
    apt-get install -y \
  locales              \
  build-essential      \
  perl                 \
  perl-doc             \
  cpanminus            \
  libsdl-perl          \
  sudo                 \
  bzip2                \
  git                  \
  gst123               \
  ncurses-base         \
  ncurses-bin          \
  vim-nox              \
  curl                 \
  zsh                  \
  && rm -rf /var/lib/apt/lists/* && \
  locale-gen "en_US.UTF-8"
# Set locale.
# HTTPS://StackOverFlow.Com/a/57158691
ENV      LANG=en_US.UTF-8 \
       LC_ALL=en_US.UTF-8 \
     LANGUAGE=en_US:en
# Install 3rd party Perl dependencies.
RUN cpanm --notest  \
  Time::DaysInMonth \
  Time::PT          \
  Color::Similarity::RGB
# Add a unix user.
# HTTPS://StackOverFlow.Com/a/27703359
# HTTPS://StackOverFlow.Com/a/1022024
RUN useradd -m -G sudo -s /bin/zsh -p aaoCFznDGNVHs pip
# Copy Octology files into pip's $HOME.
COPY --chown=pip:pip .Hrc .Xrc .bashrc .lrc .lsrc \
  .shl.style .vimrc .zshrc /home/pip/
COPY --chown=pip:pip .log  /home/pip/.log/
COPY --chown=pip:pip  lib  /home/pip/lib/
COPY --chown=pip:pip  dvl  /home/pip/dvl/
COPY --chown=pip:pip  dox  /home/pip/dox/
COPY --chown=pip:pip  gfx  /home/pip/gfx/
COPY --chown=pip:pip  muz  /home/pip/muz/
COPY --chown=pip:pip  mvz  /home/pip/mvz/
COPY --chown=pip:pip  bin  /home/pip/bin/
# Install vim-plug.
# HTTPS://GitHub.Com/junegunn/vim-plug
# HTTPS://GitHub.Com/junegunn/vim-plug/issues/675
RUN curl -sfLo     /home/pip/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
  chown -R pip:pip /home/pip/.vim
# su -c "vim +'PlugInstall --sync' +qa" pip
# Set a default command for the container.
CMD su - pip
# Build:    dkrb
#   docker build . -t octology
# Run  :    dkrn
#   docker run    -it octology
# Run w/ local directory mounted inside container
#   docker run --mount type=bind,source=/local/dir,target=/container/dir -it octology
# List currently running docker containers
#   docker ps
# Connect to running docker container by id (found via `docker ps`)
#   docker exec   -it $id zsh
