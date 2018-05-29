# Path to Oh My Fish install.
#set -gx OMF_PATH "/Users/darcy/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/darcy/.config/omf"

# Load oh-my-fish configuration.
#source $OMF_PATH/init.fish

export EDITOR=nvim
if test -d $HOME/Dropbox
  set -gx PATH $HOME/Dropbox/Tools/System/bin $PATH
end
if test -d $HOME/.linuxbrew
  set -gx PATH $HOME/.linuxbrew/bin $PATH
end
if test -d /var/lib/snapd/snap/bin
  set -gx PATH /var/lib/snapd/snap/bin $PATH
end

export LC_CTYPE=en_US.UTF-8
# export TERM=xterm-256color
export MAKEFILE_FISH_SHELL=1

set -xU LS_COLORS gxfxcxdxbxegedabagacad

alias v=nvim
alias l="ls -lhFG"
alias ls="ls -lhFG"
alias la="ls -lahFG"
alias rm="rm -i"
alias vi="vim"
alias cdc='cd ~/Work/client'
alias cdd='cd ~/Work/dev'
alias cds='cd ~/Work/scratch'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dev='ssh -A -i ~/.ssh/Workstation-west2.pem  ec2-user@dev.darcybrown.com'
alias gitm="nvim -c MagitOnly"
#git
# alias gm='git merge'
# alias grm='git rebase master'
# alias gb='git branch --color'
# alias gba='git branch --color -a'
# alias gsb='git show-branch'
# alias gfix='git commit --amend'
# alias gc='git commit -v'
# alias gco='git checkout'
# alias gd='git diff'
# alias glog='git log --stat'
# # alias gl='git pull'
# alias glf='git fetch;git rebase --preserve-merges origin/$1'
# alias gp='git push'
# alias gst='git status'
# alias gs='git stash'
# alias gsa='git stash apply'
# alias gclean='git clean -df'
# alias gitrmall='git ls-files --deleted | xargs git rm'
alias git='hub'
alias dcbup='docker-compose stop; docker-compose build; docker-compose -f docker-compose.yml -f docker-compose.local.yml up'
alias dcup='docker-compose stop; docker-compose -f docker-compose.yml -f docker-compose.local.yml up'
alias proxy='docker run -d -p 80:80 -p 443:443 -v /home/ec2-user/.certs:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy'

alias sshw='ssh -A 52.9.249.65'
alias sshfp1n='ssh frontpoint@tm26-s00059  -p 7000'
alias sshfp2n='ssh frontpoint@tm26-s00060  -p 7001'
alias sshfpdb1n='ssh frontpoint@tm26-s00062  -p 7003'
alias sshfpsn='ssh frontpoint@tm26-s00058  -p 7000'
alias top='top -o cpu'

ulimit -n 1024
eval (direnv hook fish)

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
