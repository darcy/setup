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
alias gitm="nvim -c MagitOnly"
alias dcbup='docker-compose stop; docker-compose build; docker-compose -f docker-compose.yml -f docker-compose.local.yml up'
alias dcup='docker-compose stop; docker-compose -f docker-compose.yml -f docker-compose.local.yml up'
alias proxy='docker run -d -p 80:80 -p 443:443 -v /home/ec2-user/.certs:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy'

ulimit -n 1024
eval (direnv hook fish)

ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
# if test -z (pgrep ssh-agent)
#   eval (ssh-agent -c)
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#   set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#   set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
# end
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.fish ]; and . ~/.config/tabtab/__tabtab.fish; or true

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/darcy/Work/scratch/cndc/create-stack/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/darcy/Work/scratch/cndc/create-stack/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/darcy/Work/scratch/cndc/create-stack/node_modules/tabtab/.completions/sls.fish ]; and . /Users/darcy/Work/scratch/cndc/create-stack/node_modules/tabtab/.completions/sls.fish
