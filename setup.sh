#!/bin/sh

set -e

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    export PATH="/usr/local/bin:$PATH"
fi

fancy_echo "Updating Homebrew formulae ..."
brew update
brew tap Homebrew/bundle
brew tap caskroom/cask
brew bundle --file=- <<EOF

brew "git"
brew "heroku-toolbelt"
brew "imagemagick"
brew 's3cmd'
brew 'wget'
brew 'mackup'
brew 'direnv'

tap 'codekitchen/dinghy'
brew 'dinghy'
brew 'docker'
brew 'docker-machine'

cask 'adobe-creative-cloud'
cask 'atom'
cask 'dropbox'
cask 'evernote'
cask 'flux'
cask 'fluid'
cask 'garmin-basecamp'
cask 'github-desktop'
cask 'google-chrome'
cask 'harvest'
cask 'ipvanish-vpn'
cask 'lastpass'
cask 'skype'
cask 'slack'
cask 'spotify'
cask 'screenhero'
cask 'spectacle'
cask 'sonos'
cask 'transmit'
cask 'vmware-fusion'

EOF

mkdir -p ~/Work/client ~/Work/scratch ~/Work/dev

if [ -d "$HOME/Dropbox/Mackup" ]; then
  fancy_echo "Updating from mackup"
  mackup restore
fi
source $HOME/.bashrc
