<!-- START OF TOC !DO NOT EDIT THIS CONTENT MANUALLY-->
**Table of Contents**  *generated with [mtoc](https://github.com/containerscrew/mtoc)*
- [Post Installation](#post-installation)
- [Setup nvidia drivers](#setup-nvidia-drivers)
- [Setup plymouth theme](#setup-plymouth-theme)
- [Display positions using autorandr](#display-positions-using-autorandr)
- [Personal VPN (ProtonVPN using wireguard)](#personal-vpn-(protonvpn-using-wireguard))
- [Work VPN](#work-vpn)
  - [Start connection](#start-connection)
    - [Only once](#only-once)
    - [Automatic start when boot](#automatic-start-when-boot)
    - [Add dommains to search using systemd-resolved](#add-dommains-to-search-using-systemd-resolved)
  - [Stop connection](#stop-connection)
- [Certificates](#certificates)
- [Global gitconfig for internal git servers with self signed certificate](#global-gitconfig-for-internal-git-servers-with-self-signed-certificate)
- [Edit custom zsh functions](#edit-custom-zsh-functions)
- [X11 change keyboard](#x11-change-keyboard)
- [Timezone](#timezone)
- [Setup rustup](#setup-rustup)
- [Set `gnome-keyring` in vscode](#set-`gnome-keyring`-in-vscode)
- [Personal reminders (private content can't be public)](#personal-reminders-(private-content-can't-be-public))
<!-- END OF TOC -->
# Post Installation

Almost all this steps are optional and very personal.

# Setup nvidia drivers

If you have gpu in your laptop/pc, follow this steps. Packages already installed when you executed `installers/packages.sh`.

- https://github.com/korvahannu/arch-nvidia-drivers-installation-guide
- https://wiki.archlinux.org/title/NVIDIA

1. Add MODULES to `mkinitcpio.conf`

```conf
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
sudo mkinitcpio -P
```

2. Edit `/etc/default/grub`

```bash
sudo nvim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1"
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

# Setup plymouth theme

```bash
sudo nvim /etc/mkinitcpio.conf
HOOKS=(base plymouth udev XXXX XXXX ) # add plymouth
sudo mkinitcpio -p linux
sudo plymouth-set-default-theme --list
sudo plymouth-set-default-theme -R theme_name
```

# Display positions using autorandr

Type `autorandr` in your terminal and organize your displays (if you have more than 1 displays connected to your pc/laptop)

```bash
autorandr --save home
autorandr --save office
```

* [Visit the official webpage](https://github.com/phillipberndt/autorandr) for more information.


# Personal VPN (ProtonVPN using wireguard)

Privacy first. I don't really like protonvpn client (gui or cli). I prefer to download wireguard conf file.

* [Official manual](https://protonvpn.com/support/wireguard-manual-linux/)

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

# Edit custom zsh functions

```bash
nvim .my_zsh_functions/custom.sh # for example, change the email address of your company
```

# X11 change keyboard

```shell
$ sudo nvim /etc/X11/xorg.conf.d/00-keyboard.conf
$ localectl set-x11-keymap us default intl
```

# Timezone

```shell
$ timedatectl list-timezones | grep -I "Europe"
$ timedatectl set-timezone Europe/Amsterdam
```

# Setup rustup

```bash
$ rustup default stable
```

# Set `gnome-keyring` in vscode

https://code.visualstudio.com/docs/editor/settings-sync#_troubleshooting-keychain-issues


# Personal reminders (private content can't be public)

* Setup pass
* Export chrome/firefox tabs/config
* Sync ssh keys and configs
* Rsync other files
