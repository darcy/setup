# Qubes Template VM setup

These scripts handle installing base core packages for development. Configuration of the packages is all done in the AppVM

Packages include:
- tmux
- nvim/vim
- zsh/fish
- git
- node/python/ruby/go
- npm/pip
- docker (disabled on start)
- wget/curl


## Installation

In dom0 run:


```
cat > ~/update-dev-template.sh <<EOF
#!/bin/bash
set -e

DEV_TEMPLATE=fedora-26-develop
BASE_TEMPLATE=fedora-26

qvm-ls --raw-list | grep -x $DEV_TEMPLATE || qvm-clone $BASE_TEMPLATE $DEV_TEMPLATE
qvm-start --skip-if-running $DEV_TEMPLATE
qvm-prefs --set $DEV_TEMPLATE netvm sys-firewall
set +e
qvm-run $DEV_TEMPLATE "curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/darcy/setup/master/qubes/dev-templatevm/setup.sh | sh"
set -e
qvm-prefs --set $DEV_TEMPLATE netvm ''
qvm-shutdown $DEV_TEMPLATE
EOF
chmod 755 ~/update-dev-template.sh
./update-dev-template.sh
```
