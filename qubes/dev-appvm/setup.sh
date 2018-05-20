#!/bin/bash

set -e

HOME=/home/user
FROM=/home/user/setup/common

# mkdir -p $HOME/.config/nvim/autoload $HOME/.config/fish/functions $HOME/.config/fish/completions
mkdir -p $HOME/Work/client $HOME/Work/dev $HOME/Work/scratch
sudo chown user:user $HOME/Work/client
sudo chown user:user $HOME/Work/dev
sudo chown user:user $HOME/Work/scratch

[ -f $HOME/.config/nvim/autoload/plug.vim ] || \
  curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
[ -f $HOME/.config/fish/functions/fisher.fish ] || \
  curl -fLo $HOME/config/fish/functions/fisher.fish --create-dirs \
    https://git.io/fisher
[ -f $HOME/.tmux/plugins/tpm ] || \
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

ln -nsf $FROM/gitconfig $HOME/.gitconfig
ln -nsf $FROM/tmux.conf $HOME/.tmux.conf
ln -nsf $FROM/config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -nsf $FROM/config/fish/config.fish $HOME/.config/fish/config.fish
ln -nsf $FROM/config/fish/functions/fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish
ln -nsf $FROM/config/fish/completions/tmuxinator.fish $HOME/.config/fish/completions/tmuxinator.fish

nvim +PlugInstall +qall

#ln -nsf $FROM/config/omf $HOME/.config/omf

