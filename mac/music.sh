#!/bin/bash

set -e
sudo echo "starting" #get a password if needed
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# if [[ -L "$HOME/Music/iTunes" && -d "$HOME/Music/iTunes" ]]
# then
#   echo "iTunes already linked"
# else
#   read -p "Replace w/ iTunes Library from Dropbox?(y/N)" -n 1 -r
#   echo    # (optional) move to a new line
#   if [[ $REPLY =~ ^[Yy]$ ]]
#   then
#     echo "linking iTunes Library"
#     rm -rf $HOME/Music/iTunes
#     ln -s $HOME/Dropbox/Music/iTunes $HOME/Music/iTunes
#   else
#     echo "skipping.."
#   fi
# fi
if [[ -L "$HOME/Library/Pioneer/rekordbox" && -d "$HOME/Library/Pioneer/rekordbox" ]]
then
  echo "Pioneer already linked"
else
  read -p "Replace w/ Pioneer Library from Dropbox?(y/N)" -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "linking Pioneer Library"
    rm -rf $HOME/Library/Pioneer/rekordbox
    mkdir -p $HOME/Library/Pioneer
    ln -s $HOME/Dropbox/Music/DJ/Pioneer/rekordbox $HOME/Library/Pioneer/rekordbox
  else
    echo "skipping.."
  fi
fi

brew bundle --file=- <<EOF
brew 'ffmpeg'
brew 'eyeD3'
cask 'rekordbox'
cask 'ableton-live'
EOF


