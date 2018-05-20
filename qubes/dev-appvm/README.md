# AppVM for development

## Script / setup overview

- Checks out repo to ~/setup
- updates /rw/config/rc.local to run setup.sh and start docker with images in user dir


## Install

```
ssh-keygen -t rsa -b 4096 -C "darcy@darcybrown.com"
[add new key to github]
git clone git@github:darcy/setup.git
sudo ln -nsf ~/setup/qubes/dev-appvm/rc.local /rw/config/rc.local
sudo /rc/config/rc.local
```

