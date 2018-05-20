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

First, enable net on the template vm for setup, then can disable. In dom0 run:

```
qvm-prefs --set fedora-26-dev netvm sys-firewall
```

```
sudo yum groupinstall -y 'Development Tools'
sudo dnf update -y
curl -s https://raw.githubusercontent.com/darcy/setup/master/qubes/dev-templatevm/setup.sh | sh
```

Now disable netvm
```
qvm-prefs --set fedora-26-dev netvm ''
```
