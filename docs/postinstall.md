<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Personal VPN (ProtonVPN using wireguard)](#personal-vpn-protonvpn-using-wireguard)
- [Work VPN](#work-vpn)
  - [Start connection](#start-connection)
  - [Add dommains to search](#add-dommains-to-search)
- [Certificates](#certificates)
- [SSH KEYS AND CONFIGS](#ssh-keys-and-configs)
- [Browsers](#browsers)
- [Custom git configs](#custom-git-configs)
- [Oh my fish and plugins](#oh-my-fish-and-plugins)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


# Personal VPN (ProtonVPN using wireguard)

Privacy first. I don't really like protonvpn client (gui or cli) of protonvpn. I prefer to download wireguard conf file.

* [Official manual](https://protonvpn.com/support/wireguard-manual-linux/)
* Download wireguard conf file from [here](https://account.protonvpn.com/downloads)

After download wireguard config:

```shell
$ sudo mv protonvpn.conf to /etc/wireguard/protonvpn.conf
$ sudo systemctl enable wg-quick@protonvpn.service --now
$ curl ifconfig.me
```

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
4. Import bookmarks

> [!IMPORTANT]
> This custom configurations and settings about browsers, will be automated.

# Custom git configs

I have a lot of configs for git. For example, git config for work, 2 personal github accounts...etc I have a custom function to set the git config when I'm in a repository (insead of using a global).

Edit file located in `~/.config/fish/functions/git-work.fish` and replace `user.name` or `user-email` for each configuration. Same for `git-containerscrew.fish`, in this case replace the name `git-containerscrew` with your personal github account.

# Oh my fish and plugins

Install oh my fish:

```shell
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

Install `omf` plugins:

Run [fish-plugins.sh](./scripts/fish-plugins.sh) script.
