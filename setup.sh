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
brew 'docker-compose'

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

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use Graphite Appearance
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

# Use Graphite Highlight Color
defaults write NSGlobalDomain AppleHighlightColor -string "0.780400 0.815700 0.858800"
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist || true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set mouse tracking speed to reasonably fast
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Hide Spotlight Icon
#
# To restore the icon, run
#
#     sudo chmod 755 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
#DOESNT WORK ON EL CAPITAN
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Minimal Dock
defaults write com.apple.dock no-glass -bool true
defaults write com.apple.dock autohide -int 1
# Move Dock to the right
defaults write com.apple.dock orientation -string "right"

# Move Dock to the top
defaults write com.apple.dock pinning -string "start"

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

### Spaces

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Set edge-dragging delay to 0.7
defaults write com.apple.dock workspaces-edge-delay -float 1.0

# Hide icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Disable sound effect when changing volume
defaults write -g com.apple.sound.beep.feedback -integer 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Set the icon size of Dock items to 26 pixels
defaults write com.apple.dock tilesize -int 26

# Trackpad: disable tap to click for this user and for the login screen
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
# defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

### Screen Shots

# Move screen shots to ~/Screen Shots
mkdir -p ~/Screen\ Shots
defaults write com.apple.screencapture location ~/Screen\ Shots

defaults write -g NSUserKeyEquivalents '{
"Select Next Tab"="@~\U2192";
"Select Previous Tab"="@~\U2190";
"Show Next Tab"="@~\U2192";
"Show Previous Tab"="@~\U2190";
}'

killall -HUP Dock
killall -HUP Finder
