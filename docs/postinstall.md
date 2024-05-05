# DEPRECATED! I NEED TO REWRITE THIS CONFIGURATION

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Personal VPN (ProtonVPN using wireguard)](#personal-vpn-protonvpn-using-wireguard)
- [Work VPN](#work-vpn)
  - [Start connection](#start-connection)
    - [Only once](#only-once)
    - [Automatic start when boot](#automatic-start-when-boot)
    - [Add dommains to search using systemd-resolved](#add-dommains-to-search-using-systemd-resolved)
    - [Make it permanent](#make-it-permanent)
  - [Stop connection](#stop-connection)
- [Certificates](#certificates)
- [SSH KEYS AND CONFIGS](#ssh-keys-and-configs)
- [Browsers](#browsers)
- [Custom git configs](#custom-git-configs)
- [Oh my fish and plugins](#oh-my-fish-and-plugins)
- [Sign in](#sign-in)
- [Create some work scripts or binaries in ~/.local/bin/](#create-some-work-scripts-or-binaries-in-localbin)
- [/etc/systemd/logind.conf](#etcsystemdlogindconf)
- [Pass store](#pass-store)
- [Install your SDDM theme](#install-your-sddm-theme)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


# Personal VPN (ProtonVPN using wireguard)

Privacy first. I don't really like protonvpn client (gui or cli). I prefer to download wireguard conf file.

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
Interface name tun1
```

## Start connection

### Only once

```shell
$ sudo chmod 700 /etc/vpnc/work.conf
$ sudo vpnc work
```

### Automatic start when boot

```shell
$ sudo systemctl enable vpnc@work.service --now
```

### Add dommains to search using systemd-resolved

```shell
sudo resolvectl domain tun1 mydomain1.custom mycompany.internal hello.test # change interface name if needed
```

### Make it permanent

```shell
$ echo "sudo resolvectl domain tun1 mydomain1.custom mycompany.internal hello.test" >> ~/.local/bin/work-vpn
$ sudo work-vpn
```

> `work-vpn` is a [custom script](../bin/work-vpn)

## Stop connection

```shell
sudo vpnc-disconnect
```

# Certificates

```shell
openssl s_client -showcerts -connect example.com:443 -servername example.com < /dev/null 2>/dev/null | openssl x509 -outform PEM > /tmp/certificate.crt
```

```shell
# Download first certificates
sudo cp /tmp/certificate.crt /etc/ca-certificates/trust-source/anchors/
sudo update-ca-trust
# Close browser to reload certs
```

# SSH KEYS AND CONFIGS

1. Set up your `$HOME/.ssh/` credentials with private keys
2. Set up your `$HOME/.ssh/config` file
3. `ssh-add` your keys if needed for `ssh-agent`. SSH agent will be started in `fish config`.

https://github.com/ivakyb/fish_ssh_agent

# Browsers

1. Setup firefox as a default browser for work links and apps
2. Setup brave as a personal browser, for your personal github, gmail account...etc
3. Check security and history settings for each browser, privacy first.
4. Import bookmarks

> [!IMPORTANT]
> This custom configurations and settings about browsers, will be automated.

# Custom git configs

I have a lot of configs for git. For example, git config for work, 2 personal github accounts...etc I have a custom function to set the git config when I'm in a repository (insead of using a global).

Edit file located in `~/.config/fish/functions/git-work.fish` and replace `user.name` or `user.email` for each configuration. Same for `git-containerscrew.fish`, in this case replace the name `git-containerscrew` with your personal github account.

# Oh my fish and plugins

Install oh my fish:

```shell
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

Also install fisher as a plugin manager:

```shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

Install `omf` plugins:

Run [fish-plugins.sh](./scripts/fish-plugins.sh) script.

# Sign in

* Jetbrains toolbox: download your favourite IDE. In my case, I use Goland, Pycharm Professional and Rustover (I have license).
* Bitwarden
* Spotify launcher
* Signal desktop
* Discord
* Other apps

# Create some work scripts or binaries in ~/.local/bin/

I can't paste this for security and privacy reasons of my company :) Just as a reminder.

# /etc/systemd/logind.conf

Parameters to change (can be automated with sed command):

* **IdleAction=lock**
* **HandleLidSwitch=ignore**
* others...

```shell
sudo systemctl restart systemd-logind
```

# Pass store

Setup [pass](https://wiki.archlinux.org/title/Pass) store if needed.

# Install your SDDM theme

https://store.kde.org/s/KDE%20Store/p/1312658

cp your-theme/ `/usr/share/sddm/themes/`


# Global gitconfig for internal git servers with self signed certificate

In my case, using terraform and downloading custom terraform modules from internal git servers with self signed certificates, I need to setup this configuration to avoid SSL errors.

```toml
[http "https://gitlab.server.internal"]
  ##################################
  # Self Signed Server Certificate #
  ##################################

  sslCAInfo = /path/to/your/certificate.crt
  #sslCAPath = /path/to/selfCA/
  sslVerify = true

```