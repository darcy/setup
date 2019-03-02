#!/bin/bash

set -e
sudo echo "starting" #get a password if needed
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

export PATH="/usr/local/bin:$PATH"
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

fancy_echo "Updating Homebrew formulae ..."
brew update
brew update #run twice to fix linuxbrew issues
brew tap Homebrew/bundle
set +e
brew install ruby
brew install vim
set -e
brew bundle --file=- <<EOF

brew "git"
brew "awscli"
brew 'wget'
brew 'direnv'
brew 'tmux'
brew 'python'
brew 'the_silver_searcher'
brew 'fzf'
brew 'fish'
tap 'neovim/neovim'
brew 'neovim'
brew 'node'
brew 'python3'
brew 'hub'
brew 'htop'
brew 'docker'
brew 'docker-machine'
brew 'docker-compose'
tap 'codekitchen/dinghy'
brew 'dinghy'
brew docker-machine-driver-xhyve
EOF
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
dinghy create --memory=12288 --cpus=3 --disk=100000 --provider=xhyve

pip3 install neovim
npm install -g coffee-script
npm install -g eslint

mkdir -p ~/Work/client ~/Work/scratch ~/Work/dev


  cd ~/Library/Fonts && curl -fLo "Inconsolata Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf
  cd -

  #source $HOME/.bashrc

  fancy_echo "Use AirDrop over every interface."
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

  fancy_echo "Enable full keyboard access for all controls"
  # (e.g. enable Tab in modal dialogs)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  fancy_echo "Use Graphite Appearance"
  defaults write NSGlobalDomain AppleAquaColorVariant -int 6

  fancy_echo "Use Graphite Highlight Color"
  defaults write NSGlobalDomain AppleHighlightColor -string "0.780400 0.815700 0.858800"

  fancy_echo "Expand save panel by default"
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

  fancy_echo "Expand print panel by default"
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

  fancy_echo "Save to disk (not to iCloud) by default"
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  fancy_echo "Stop iTunes from responding to the keyboard media keys"
  launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist || true

  fancy_echo "Disable press-and-hold for keys in favor of key repeat"
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  fancy_echo "Set a blazingly fast keyboard repeat rate"
  defaults write NSGlobalDomain KeyRepeat -int 0.02

  fancy_echo "turn off opening and closing windows and popovers animations"
  # defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

  fancy_echo "Disable auto-correct"
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  fancy_echo "Set mouse tracking speed to reasonably fast"
  defaults write NSGlobalDomain com.apple.mouse.scaling -float 2

  fancy_echo "Use list view in all Finder windows by default"
  # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
  defaults write com.apple.finder FXPreferredViewStyle Nlsv

  fancy_echo "Finder: allow text selection in Quick Look"
  defaults write com.apple.finder QLEnableTextSelection -bool true

  fancy_echo "Disable the warning when changing a file extension"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  fancy_echo "Display full POSIX path as Finder window title"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  fancy_echo "Automatically quit printer app once the print jobs complete"
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

  fancy_echo "Disable the \"Are you sure you want to open this application?\" dialog"
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  fancy_echo "Disable automatic termination of inactive apps"
  defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

  fancy_echo "Empty Trash securely by default"
  defaults write com.apple.finder EmptyTrashSecurely -bool true

  fancy_echo "Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  fancy_echo "Show status bar in Finder"
  defaults write com.apple.finder ShowStatusBar -bool true

  fancy_echo "Show path bar in Finder"
  defaults write com.apple.finder ShowPathbar -bool true

  fancy_echo "Speed up Mission Control animations"
  defaults write com.apple.dock expose-animation-duration -float 0.1

  fancy_echo "Show the ~/Library folder"
  chflags nohidden ~/Library

  fancy_echo "Enable Safari’s debug menu"
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  fancy_echo "Set Safari’s home page to 'about:blank' for faster loading"
  defaults write com.apple.Safari HomePage -string "about:blank"

  fancy_echo "Prevent Safari from opening ‘safe’ files automatically after downloading"
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

  fancy_echo "Remove useless icons from Safari’s bookmarks bar"
  defaults write com.apple.Safari ProxiesInBookmarksBar "()"

  fancy_echo "Make Safari’s search banners default to Contains instead of Starts With"
  defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

  fancy_echo "Reset Launchpad"
  find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete

  fancy_echo "Disable the Ping sidebar in iTunes"
  defaults write com.apple.iTunes disablePingSidebar -bool true

  fancy_echo "Disable all the other Ping stuff in iTunes"
  defaults write com.apple.iTunes disablePing -bool true


  # Change minimize/maximize window effect
  defaults write com.apple.dock mineffect -string "scale"

  #fancy_echo "Hide Spotlight Icon"
  #sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
  fancy_echo "Rebuild Spotlight"
  defaults write com.apple.spotlight orderedItems -array \
  	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
  	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
  	'{"enabled" = 1;"name" = "PDF";}' \
    '{"enabled" = 1;"name" = "CONTACT";}' \
  	'{"enabled" = 0;"name" = "FONTS";}' \
  	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
  	'{"enabled" = 0;"name" = "MESSAGES";}' \
  	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
  	'{"enabled" = 0;"name" = "IMAGES";}' \
  	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
  	'{"enabled" = 0;"name" = "MUSIC";}' \
  	'{"enabled" = 0;"name" = "MOVIES";}' \
  	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  	'{"enabled" = 0;"name" = "SOURCE";}'
  fancy_echo "Load new settings before rebuilding the index"
  set +e
  killall mds > /dev/null 2>&1
  fancy_echo "Make sure indexing is enabled for the main volume"
  sudo mdutil -i on / > /dev/null
  fancy_echo "Rebuild the index from scratch"
  sudo mdutil -E / > /dev/null
  set -e

  fancy_echo "Don’t animate opening applications from the Dock"
  defaults write com.apple.dock launchanim -bool false

  fancy_echo "Minimal Dock"
  defaults write com.apple.dock no-glass -bool true
  defaults write com.apple.dock autohide -int 1
  fancy_echo "Move Dock to the right"
  defaults write com.apple.dock orientation -string "right"

  # Move Dock to the top
  defaults write com.apple.dock pinning -string "start"

  fancy_echo "Remove the auto-hiding Dock delay"
  defaults write com.apple.dock autohide-delay -float 0

  fancy_echo "Remove the animation when hiding/showing the Dock"
  defaults write com.apple.dock autohide-time-modifier -float 0

  fancy_echo "Automatically hide and show the Dock"
  defaults write com.apple.dock autohide -bool true

  fancy_echo "Clear everything from Dock"
  set +e
  defaults delete com.apple.dock persistent-apps
  defaults delete com.apple.dock persistent-others
  set -e

  fancy_echo "When performing a search, search the current folder by default"
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  ### Spaces

  fancy_echo "Don’t automatically rearrange Spaces based on most recent use"
  defaults write com.apple.dock mru-spaces -bool false

  fancy_echo "Set edge-dragging delay to 0.7"
  defaults write com.apple.dock workspaces-edge-delay -float 1.0

  fancy_echo "Hide icons for hard drives, servers, and removable media on the desktop"
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

  fancy_echo "Disable sound effect when changing volume"
  defaults write -g com.apple.sound.beep.feedback -integer 0

  fancy_echo "Avoid creating .DS_Store files on network volumes"
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  fancy_echo "Set the icon size of Dock items to 26 pixels"
  defaults write com.apple.dock tilesize -int 26

  # Trackpad: disable tap to click for this user and for the login screen
  # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
  # defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
  # defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

  ### Screen Shots

  fancy_echo "Move screen shots to ~/Screen Shots"
  mkdir -p ~/Screen\ Shots
  defaults write com.apple.screencapture location ~/Screen\ Shots

  fancy_echo "Set Prev/Next Tab Shortcuts"
  defaults write -g NSUserKeyEquivalents '{
    "Select Next Tab"="@~\U2192";
    "Select Previous Tab"="@~\U2190";
    "Show Next Tab"="@~\U2192";
    "Show Previous Tab"="@~\U2190";
  }'

  fancy_echo "Set Sidebar Shortcut for Evernote"
  defaults write com.evernote.Evernote NSUserKeyEquivalents '{
    "Show Sidebar" = "@\\";
    "Hide Sidebar" = "@\\";
  }'

  fancy_echo "Set Sidebar Shortcut for Calendar"
  defaults write com.apple.iCal NSUserKeyEquivalents '{
    "Show Calendar List" = "@\\";
    "Hide Calendar List" = "@\\";
  }'

  fancy_echo "Set Sidebar Shortcut for Spotify"
  defaults write com.spotify.client NSUserKeyEquivalents '{
    "Friend Feed" = "@\\";
  }'

  fancy_echo "Only use UTF-8 in Terminal.app"
  defaults write com.apple.terminal StringEncodings -array 4

  fancy_echo "Show the main window when launching Activity Monitor"
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  fancy_echo "Visualize CPU usage in the Activity Monitor Dock icon"
  defaults write com.apple.ActivityMonitor IconType -int 5

  fancy_echo "Show all processes in Activity Monitor"
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  fancy_echo "Sort Activity Monitor results by CPU usage"
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0

  fancy_echo "Use plain text mode for new TextEdit documents"
  defaults write com.apple.TextEdit RichText -int 0
  fancy_echo "Open and save files as UTF-8 in TextEdit"
  defaults write com.apple.TextEdit PlainTextEncoding -int 4
  defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

  fancy_echo "Enable the WebKit Developer Tools in the Mac App Store"
  defaults write com.apple.appstore WebKitDeveloperExtras -bool true
  fancy_echo "Enable Debug Menu in the Mac App Store"
  defaults write com.apple.appstore ShowDebugMenu -bool true

  killall -HUP Dock
  killall -HUP Finder
  killall -HUP SystemUIServer
  killall cfprefsd

# mkdir -p ~/.vim/bundle
# if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
#   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
# fi
if [ ! -d "$HOME/.local/share/omf" ]; then
  curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
fi
#omf install fzf
if [ ! -d "$HOME/.config/fish/functions/fisher.fish" ]; then
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
fi
#fisher z fzf pure

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/fish/functions

if [ ! -d "$HOME/.config/darcy-setup" ]; then
  git clone git://github.com/darcy/setup.git $HOME/.config/darcy-setup
fi

HOME=/Users/darcy
FROM=/Users/darcy/.config/darcy-setup/common

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
  fc-cache -f
fi

ln -nsf $FROM/gitconfig $HOME/.gitconfig
ln -nsf $FROM/gitignore $HOME/.gitignore
ln -nsf $FROM/tmux.conf $HOME/.tmux.conf
ln -nsf $FROM/config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -nsf $FROM/config/fish/config.fish $HOME/.config/fish/config.fish
ln -nsf $FROM/config/fish/functions/fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish
ln -nsf $FROM/config/fish/completions/tmuxinator.fish $HOME/.config/fish/completions/tmuxinator.fish

nvim +PlugInstall +qall

fancy_echo "All DONE - might need to restart"
