<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Setup some things for company](#setup-some-things-for-company)
- [Custom certificates for internal endpoints](#custom-certificates-for-internal-endpoints)
- [Setup your .ssh/ credentials with private keys](#setup-your-ssh-credentials-with-private-keys)
- [Setup your .ssh/config file](#setup-your-sshconfig-file)
- [Chrome, brave or firefox bookmarks and theme](#chrome-brave-or-firefox-bookmarks-and-theme)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Setup some things for company

1. Setup private VPN using VPNC (CISCO VPN)

`/etc/vpnc/work.conf`

```
IPSec gateway XXX
IPSec ID XXX
IPSec secret XXXX
Xauth username XXXX
Xauth password XXXX
Local Port 5050
```

`sudo vpnc work`

Enable service:

sudo systemctl enable vpnc@work.service --now

```shell
   1   # https://linux.die.net/man/8/vpnc
   2   [Unit]
   3   Description=VPNC connection to %i
   4   After=network.target
   5
   6   [Service]
   7   Type=forking
   8   ExecStart=/usr/bin/vpnc --pid-file=/run/vpnc@%i.pid /etc/vpnc/%i.conf --ifname tun1
   9   PIDFile=/run/vpnc@%i.pid
  10   Restart=always
  11
  12   [Install]
  13   WantedBy=multi-user.target
```

resolvectl

resolvectl domain tun0 foo bar x1 x2 x3

# Custom certificates for internal endpoints

cp certificate.crt /etc/ca-certificates/trust-source/anchors/
update-ca-trust
(close browser to reload certs)


# Setup your .ssh/ credentials with private keys
# Setup your .ssh/config file
# Chrome, brave or firefox bookmarks and theme
