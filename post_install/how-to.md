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

