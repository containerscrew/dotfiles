<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Work VPN](#work-vpn)
  - [Start connection](#start-connection)
  - [Add dommains to search](#add-dommains-to-search)
- [Certificates](#certificates)
- [SSH KEYS AND CONFIGS](#ssh-keys-and-configs)
- [Browsers](#browsers)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Work VPN

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

```shell
$ sudo vpnc work
```

## Start connection

```shell
$ sudo systemctl start vpnc@work.service
```
## Add dommains to search


```shell
resolvectl domain tun0 mydomain1.custom mycompany.internal hello.test
```

# Certificates

```shell
# Download first certificates
cp certificate.crt /etc/ca-certificates/trust-source/anchors/
update-ca-trust
# Close browser to reload certs
```

# SSH KEYS AND CONFIGS

1. Setup your `$HOME/.ssh/` credentials with private keys
2. Setup your `$HOME/.ssh/config` file

# Browsers

1. Setup firefox as a default browser for work links and apps
2. Setup brave as a personal browser, for your personal github, gmail account...etc
3. Check security and history settings for each browser, privacy first.

> [!IMPORTANT]
> This custom configurations and settings about browsers, will be automated.
