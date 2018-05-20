#!/bin/bash
set -e

sudo yum groupinstall -y 'Development Tools'
sudo dnf update -y
sudo dnf config-manager --add-repo http://download.opensuse.org/repositories/shells:fish:release:2/Fedora_25/shells:fish:release:2.repo
#sudo dnf -y copr enable dperson/neovim
sudo dnf install -y curl wget git irb python-setuptools ruby zsh tmux htop node npm the_silver_searcher \
  gcc-c++ perl-Thread-Queue gperf go go-md2man hub python3 dnf-plugins-core neovim fish direnv \
  util-linux-user tmuxinator fzf
sudo pip install --upgrade pip
#sudo pip install neovim
sudo npm install -g coffee-script eslint
curl -fsSL https://get.docker.com/ | sh
#sudo systemctl enable docker.service
sudo usermod -aG docker user
#sudo systemctl start docker
sudo pip install docker-compose --upgrade --user
sudo pip install awscli --upgrade --user
curl -L http://get.oh-my.fish > install; fish install --noninteractive; rm -f install
sudo mkdir -p /usr/share/fonts/inconsolata && cd /usr/share/fonts/inconsolata && \
  sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf
sudo fc-cache -s

