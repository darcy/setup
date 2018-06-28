#!/bin/bash
set -e

sudo yum groupinstall -y 'Development Tools'
sudo dnf update -y
sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/shells:fish:release:2/Fedora_25/shells:fish:release:2.repo

sudo dnf install -y curl wget git irb python-setuptools ruby zsh tmux htop node npm the_silver_searcher \
  gcc-c++ perl-Thread-Queue gperf go go-md2man hub python3 dnf-plugins-core neovim fish direnv \
  util-linux-user tmuxinator fzf xclip bind-utils weechat

#h264
sudo dnf config-manager --set-enabled rpmfusion-free rpmfusion-nonfree
sudo dnf upgrade --refresh -y
sudo dnf install ffmpeg-libs -y
# sudo dnf install compat-ffmpeg28 fedora28

# verify pip is up to date
[ -f /usr/bin/pip3 ] || \
  sudo dnf reinstall -y python3-pip
sudo pip3 install --upgrade pip

# setup docker
[ -f /usr/bin/docker ] || \
  (curl -fsSL https://get.docker.com/ | sh)
sudo usermod -aG docker user
sudo pip3 install docker-compose --upgrade

[ -d /home/user/.local/share/omf ] || \
  (curl -L http://get.oh-my.fish > install; fish install --noninteractive; rm -f install)

# setup neovim with python for fzf
sudo pip3 install --upgrade neovim

# websocket for weechat
sudo pip2 install websocket-client

# add aws cli for good measure
sudo pip3 install awscli --upgrade --ignore-installed

# install fonts
[ -d /usr/share/fonts/inconsolata ] || \
  (sudo mkdir -p /usr/share/fonts/inconsolata && cd /usr/share/fonts/inconsolata && \
  sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf && \
  sudo fc-cache -s)

# install snap
sudo dnf install -y snapd
sudo ln -nfs /var/lib/snapd/snap /snap
sudo snap install htop gimp hello
sudo snap install --classic slack
sudo snap refresh

sudo npm install -g coffee-script eslint

# change to fish shell
grep -q -F 'fish' /etc/passwd || sudo bash -c "chsh -s `which fish` user"

