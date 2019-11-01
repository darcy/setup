#!/bin/bash
set -e

adduser user
usermod -aG sudo user

apt-get update
apt-get install -y sudo wget software-properties-common curl

apt-get install -y build-essential

apt-get install -y git vim python-setuptools zsh htop silversearcher-ag \
        direnv python3 python3-pip gperf xclip file fish gawk golang-go tmux

# setup docker
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
apt-get update
apt-cache madison docker-ce
apt-get install -y docker-ce=17.09.1~ce-0~debian
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker user
# https://github.com/docker/compose/issues/6931
sudo apt install -y haveged

# install node
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
apt-get install nodejs -y
npm install -g coffeescript eslint localtunnel eslint-plugin-prettier babel-eslint eslint-config-prettier \
        eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-import prettier

apt-get install -y zlib1g-dev libssl-dev libreadline-dev libgdbm-dev openssl

# verify pip is up to date
apt-get install -y python3-pip
pip3 install --upgrade pip

#yarn 
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt update
apt install -y yarn

# install neovim
apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
git clone https://github.com/neovim/neovim.git
cd neovim && git checkout v0.3.2 && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
# setup neovim with python for fzf
pip3 install --upgrade neovim

#  perl-Thread-Queue gperf go go-md2man hub python3 sudo apt-get-plugins-core neovim fish direnv \
#  util-linux-user tmuxinator fzf xclip bind-utils

# add aws cli for good measure
pip3 install awscli --upgrade --ignore-installed

# install fonts
[ -d /usr/share/fonts/inconsolata ] || \
  (mkdir -p /usr/share/fonts/inconsolata && cd /usr/share/fonts/inconsolata && \
  wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf)


HOME=/home/user
FROM=/home/user/setup/common

cd $HOME && git clone https://github.com/darcy/setup.git

mkdir -p $HOME/.config/nvim/autoload \
  $HOME/.config/fish/functions \
  $HOME/.config/fish/completions \
  $HOME/.config/fontconfig/conf.d \
  $HOME/.local/share/fonts \
  $HOME/Work/client \
  $HOME/Work/dev \
  $HOME/Work/scratch

[ -f $HOME/.config/nvim/autoload/plug.vim ] || \
  curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
[ -f $HOME/.config/fish/functions/fisher.fish ] || \
  curl -fLo $HOME/.config/fish/functions/fisher.fish --create-dirs \
  https://git.io/fisher
[ -d $HOME/.tmux/plugins/tpm ] || \
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

if [ -f $HOME/.local/share/fonts/emojione-android.ttf ];then
  cd $HOME/.local/share/fonts && wget https://github.com/emojione/emojione-assets/releases/download/3.1.4/emojione-android.ttf
  cd $HOME/.config/fontconfig/conf.d && wget https://aur.archlinux.org/cgit/aur.git/plain/70-emojione-color.conf?h=ttf-emojione
fi

ln -nsf $FROM/gitconfig $HOME/.gitconfig
ln -nsf $FROM/gitignore $HOME/.gitignore
ln -nsf $FROM/tmux.conf $HOME/.tmux.conf
ln -nsf $FROM/config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -nsf $FROM/config/fish/config.fish $HOME/.config/fish/config.fish
ln -nsf $FROM/config/fish/functions/fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish
ln -nsf $FROM/config/fish/completions/tmuxinator.fish $HOME/.config/fish/completions/tmuxinator.fish


[ -d /home/user/.local/share/omf ] || \
  (curl -L http://get.oh-my.fish > install; fish install --noninteractive; rm -f install)

ln -nsf $FROM/config/omf $HOME/.config/omf

chown -R user:user $HOME

#grep -q -F 'fish' /etc/passwd || bash -c "chsh -s `which fish` user"
#nvim +PlugInstall +qall
