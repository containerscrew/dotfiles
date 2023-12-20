# Setup some things for company

1. Setup private VPN using VPNC (CISCO VPN)

`/etc/vpnc/company.conf`

```
IPSec gateway XXX
IPSec ID XXX
IPSec secret XXXX
Xauth username XXXX
Xauth password XXXX
Local Port 5050
```

`sudo vpnc company`

Enable service:

sudo systemctl enable vpnc@company.service --now

resolvectl

resolvectl domain tun0 foo bar x1 x2 x3

# Custom certificates for internal endpoints

cp certificate.crt /etc/ca-certificates/trust-source/anchors/
update-ca-trust
(close browser to reload certs)
