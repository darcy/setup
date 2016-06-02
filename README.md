# Install

```
curl -s https://raw.githubusercontent.com/darcy/laptop/master/setup.sh | sh
```

## Linux Notes (Ubuntu)

### need to script adding user (via packer?)
`VISUAL="vim" EDITOR="vim" sudo -E visudo`

add to bottom of visudo
`darcy ALL=(ALL) NOPASSWD:ALL`
then...
`sudo service sudo restart`

### After Zsh install, change shell
``chsh -s `which zsh```
