# AppVM for development

## Script / setup overview

- Checks out repo to ~/setup
- updates /rw/config/rc.local to run setup.sh and start docker with images in user dir


## Install

```
ssh-keygen -t rsa -b 4096 -C "darcy@darcybrown.com"
[add new key to github]
git clone git@github.com:darcy/setup.git
sudo ln -nsf ~/setup/qubes/dev-appvm/rc.local /rw/config/rc.local
sudo /rw/config/rc.local
```

