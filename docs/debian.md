<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [After installation](#after-installation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# After installation

```shell
su -
apt-get update
apt-get install sudo openssh-server -y
usermod -aG sudo dcr
systemctl start sshd
```



```

# Links

https://www.reddit.com/r/qtile/comments/1699j3o/installing_qtile_on_debian_12_bookworm_guide/


sudo rm /usr/lib/python3.11/EXTERNALLY-MANAGED
