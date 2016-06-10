# Path to Oh My Fish install.
#set -gx OMF_PATH "/Users/darcy/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/darcy/.config/omf"

# Load oh-my-fish configuration.
#source $OMF_PATH/init.fish

export EDITOR=nvim
set -gx PATH $HOME/Dropbox/Tools/System/bin $PATH
export LC_CTYPE=en_US.UTF-8
# export TERM=xterm-256color

alias v=nvim
alias l="ls -l"
alias ls="ls -l"
alias la="ls -la"
alias rm="rm -i"
alias vi="vim"
alias cdc='cd ~/Work/client'
alias cdd='cd ~/Work/dev'
alias cds='cd ~/Work/scratch'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

#git
alias gm='git merge'
alias grm='git rebase master'
alias gb='git branch --color'
alias gba='git branch --color -a'
alias gsb='git show-branch'
alias gfix='git commit --amend'
alias gc='git commit -v'
alias gco='git checkout'
alias gd='git diff'
alias glog='git log --stat'
# alias gl='git pull'
alias glf='git fetch;git rebase --preserve-merges origin/$1'
alias gp='git push'
alias gst='git status'
alias gs='git stash'
alias gsa='git stash apply'
alias gclean='git clean -df'
alias gitrmall='git ls-files --deleted | xargs git rm'

ulimit -n 1024
eval (direnv hook fish)

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
