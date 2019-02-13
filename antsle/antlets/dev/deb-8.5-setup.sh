#!/bin/bash
set -e

apt-get update
apt-get install -y sudo wget software-properties-common curl

echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_8.0/ /' >> /etc/apt/sources.list.d/fish.list
apt-get update
wget -qO - http://download.opensuse.org/repositories/shells:fish:release:2/Debian_8.0/Release.key | apt-key add -
apt-get update

adduser user
usermod -aG sudo user

apt-get install -y build-essential

apt-get install -y git python-setuptools zsh htop silversearcher-ag \
        direnv python3 python3-pip gperf xclip file fish gawk golang-go

# newer tmux
echo 'deb http://ftp.debian.org/debian jessie-backports main' >> /etc/apt/sources.list
apt-get update
apt-get -t jessie-backports install -y tmux

#upgrade python
wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz
tar xvf Python-3.6.3.tgz
cd Python-3.6.3 && ./configure --enable-optimizations && make -j8 && sudo make altinstall
ln -nfs /usr/local/bin/python3.6 /usr/local/bin/python3 
rm -rf Python*

# install node
curl -sl https://deb.nodesource.com/setup_10.x | sudo bash -
apt-get install -y nodejs
npm install -g coffeescript eslint localtunnel eslint-plugin-prettier babel-eslint eslint-config-prettier \
        eslint-config-airbnb eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-import prettier

# install ruby
apt-get install -y zlib1g-dev libssl-dev libreadline-dev libgdbm-dev openssl
mkdir RUBY
cd RUBY
wget https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.8.tar.gz
tar xvfz ruby-2.3.8.tar.gz
cd ruby-2.3.8 && ./configure && make && sudo make install
rm -rf RUBY
gem install tmuxinator

# verify pip is up to date
[ -f /usr/bin/pip3 ] || apt-get reinstall -y python3-pip
pip3 install --upgrade pip

# install neovim
apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
git clone https://github.com/neovim/neovim.git
 UseKeychain yes
cd neovim && git checkout v0.3.2 && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
# setup neovim with python for fzf
pip3 install --upgrade neovim

#  perl-Thread-Queue gperf go go-md2man hub python3 sudo apt-get-plugins-core neovim fish direnv \
#  util-linux-user tmuxinator fzf xclip bind-utils

# setup docker
#[ -f /usr/bin/docker ] || \
#  (curl -fsSL https://get.docker.com/ | sh)
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-get install -y docker-ce=17.09.1~ce-0~debian
pip3 install docker-compose --upgrade

# add aws cli for good measure
pip3 install awscli --upgrade --ignore-installed

# install fonts
[ -d /usr/share/fonts/inconsolata ] || \
  (mkdir -p /usr/share/fonts/inconsolata && cd /usr/share/fonts/inconsolata && \
  wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf)

usermod -aG docker user
grep -q -F 'fish' /etc/passwd || bash -c "chsh -s `which fish` user"

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

#nvim +PlugInstall +qall

