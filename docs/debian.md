<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Commands](#commands)
- [https://docs.qtile.org/en/latest/manual/install/ubuntu.html](#httpsdocsqtileorgenlatestmanualinstallubuntuhtml)
- [Links](#links)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Commands

# https://docs.qtile.org/en/latest/manual/install/ubuntu.html

```shell
su -
apt-get update
apt-get install lightdm sudo git qtile python3-pip python3 xorg xserver-xorg python3-venv xinit libpangocairo-1.0-0 python3-xcffib python3-cairocffi -y
pip3 install qtile --break-system-packages
usermod -aG sudo YOUR_USER
systemctl enable lightdm --now
```

# Links

https://www.reddit.com/r/qtile/comments/1699j3o/installing_qtile_on_debian_12_bookworm_guide/
