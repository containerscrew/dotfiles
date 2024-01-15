# containerscrew dotfiles

My dotfiles using Arch Linux.

![desktop](./assets/desktop.png)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Disclaimer ⚠️](#disclaimer-)
- [Arch Linux installation](#arch-linux-installation)
  - [Before installation using archinstall](#before-installation-using-archinstall)
    - [Connect to the internet](#connect-to-the-internet)
    - [Considerations in archinstall](#considerations-in-archinstall)
  - [After installation](#after-installation)
    - [Connect the computer to the internet](#connect-the-computer-to-the-internet)
    - [Install initial packages](#install-initial-packages)
    - [Option 1: Download dotfiles from git](#option-1-download-dotfiles-from-git)
    - [Option 2: Copy dotfiles from another computer](#option-2-copy-dotfiles-from-another-computer)
- [DOTFILES installation](#dotfiles-installation)
  - [Change wlan interface in QTILE config](#change-wlan-interface-in-qtile-config)
  - [Run installer.sh](#run-installersh)
- [Post install](#post-install)
- [BIOS settings](#bios-settings)
- [Credits](#credits)
- [iwd](#iwd)
- [First steps after installation](#first-steps-after-installation)
- [TO DO](#to-do)
- [Connect protonvpn](#connect-protonvpn)
- [X11 change keyboard](#x11-change-keyboard)
- [Timezone](#timezone)
- [Setup my custom vpn (PROTONVPN) using wireguard protocol](#setup-my-custom-vpn-protonvpn-using-wireguard-protocol)
- [CHange mac address of your interface permanently](#change-mac-address-of-your-interface-permanently)
- [Change /etc/systemd/resolved.conf](#change-etcsystemdresolvedconf)
- [Some examples of DNS servers which may be used for DNS= and FallbackDNS=:](#some-examples-of-dns-servers-which-may-be-used-for-dns-and-fallbackdns)
- [Cloudflare: 1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 2606:4700:4700::1001#cloudflare-dns.com](#cloudflare-1111cloudflare-dnscom-1001cloudflare-dnscom-2606470047001111cloudflare-dnscom-2606470047001001cloudflare-dnscom)
- [Google:     8.8.8.8#dns.google 8.8.4.4#dns.google 2001:4860:4860::8888#dns.google 2001:4860:4860::8844#dns.google](#google-----8888dnsgoogle-8844dnsgoogle-2001486048608888dnsgoogle-2001486048608844dnsgoogle)
- [Quad9:      9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net](#quad9------9999dnsquad9net-149112112112dnsquad9net-2620fefednsquad9net-2620fe9dnsquad9net)
- [ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf](#ln--sf-runsystemdresolvestub-resolvconf-etcresolvconf)
- [GTK THEME](#gtk-theme)
- [Setup EBPF tools](#setup-ebpf-tools)
- [Setup touchpad](#setup-touchpad)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


# Disclaimer ⚠️

It is my personal setup, the way I like it, with configurations that are comfortable for me, applications... etc. Use it if you want as a template, as a guide. I will update it as I need to add new packages, configs...etc. Don't use [installer.sh](./installer.sh) every time as it can break your current setup.

And yes... all my commits in this repo you will see that they are called **Wip** 😀

# Arch Linux installation

The installation of Arch Linux has been carried out using [archinstall](https://wiki.archlinux.org/title/archinstall).
The [official installation page](https://wiki.archlinux.org/title/Installation_guide) is also very complete, everything and that using archinstall is more comfortable and makes the process easier.

## Before installation using archinstall

Pre-flight checks 🚀

### Connect to the internet

Once the usb is booted, connect the laptop to your local network (if not using ethernet cable).

```shell
iwctl station wlan0 get-networks # change wlan0 interface if needed. Type `$ ip a` if you don't know the name
iwctl station wlan0 connect SSID # put the SSID/BSSID with your corresponding local network
ping -c 1 1.1.1.1 # test connectivity
archinstall # start installation
```

> [iwd](https://wiki.archlinux.org/title/Iwd) official documentation

### Considerations in archinstall

| Setting         | Configuration |
|-----------------|---------------|
| Locales/Language/Mirros         |US           |
| Bootloader      | Grub          |
| Disk Encryption | ALWAYS        |
| Disk Filesystem | BTRFS         |
| Swap            | True          |
| Profile         | Minimal       |
| User sudoer     | Yes           |
| Audio           | Pipewire          |
| Kernels         | Linux          |
| Additional packages | rsync,openssh,neovim        |
| Network         | NetworkManager          |
| UTC             | Europe/Amsterdam          |
| Optional repos  | None          |


## After installation

First setps after installation. Remove the usb from your computer and restart. Grub will launch the new archlinux distro, and a basic prompt (black window) will appear.


### Connect the computer to the internet

```shell
$ nmcli device wifi connect SSID_or_BSSID password SSID/BSSID-PASSWORD
$ history -c
```

### Install initial packages

```shell
$ sudo pacman -Syu openssh rsync neovim --noconfirm
```

### Option 1: Download dotfiles from git

```shell
$ cd /tmp
$ git clone https://github.com/containerscrew/dotfiles.git
$ cd dotfiles
$ ./installer.sh
```

### Option 2: Copy dotfiles from another computer

```shell
# Clone first the repo dotfiles from your other laptop.
# Then, copy the folder dotfiles to the remote laptop
$ sudo systemctl start sshd
$ rsync -avzh --exclude='.git/' dotfiles/ username@192.168.X.X:/tmp/
```

# DOTFILES installation

Let's install all **my necessary packages and configs**

## Change wlan interface in QTILE config

Inside [widgets.py](./config/qtile/configurations/widgets.py).

```python
def wlan(self):
    return widget.Wlan(
                **widget_base(bg=Colors.violet, fg=Colors.background),
                format=" ",
                interface="wlp2s0", # change here
                mouse_callbacks={'Button1': lazy.spawn('alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e nmcli device wifi list')},
            )
```

Check your interface name:

```shell
$ ip link
```

> [!NOTE]
> You can automate this process for sure using python code (checking wlan interface name). Well, wlan or ethernet. At the end I'm using a laptop using wifi.


## Run installer.sh

[installer.sh](./installer.sh) will install main packages using `pacman` and `paru`. Also will copy all config files in user home, will set some basic configs like `firewall` `lightdm` theme...etc Take a look!


# Post install

Post intallation setps. Some work settings, and other stuff.

See [postinstall.md]()


# BIOS settings

Pending to write documentation of BIOS settings. By the moment, protect BIOS settings with admin password.



# Credits

* https://github.com/rxyhn/tokyo/tree/main
* https://github.com/gh0stzk/dotfiles/tree/master
* https://github.com/NoiSek/Aether
* https://github.com/adi1090x/polybar-themes
* https://github.com/ART3MISTICAL/dotfiles/tree/main
* [The Bible](https://wiki.archlinux.org/)
* [Polybar Setup](https://www.youtube.com/watch?v=tOBDUBEMAKM)
* https://github.com/antoniosarosi/dotfiles
* https://gitlab.com/dwt1/dotfiles

# iwd
https://wiki.archlinux.org/title/Iwd

iwctl station wlan0 get-networks
iwctl stations wlan0 connect SSID
pacman -S openssh neovim
archinstall
nmcli device wifi connect SSID_or_BSSID password password



# First steps after installation

* nmcli device wifi connect SSID_or_BSSID password password
* sudo pacman -S rsync
* rsync -avzh --exclude='.git/' dotfiles/ elliot@192.168.0.30:/home/elliot


#  TO DO

* Bluetooth
* loadkeys en
* mouse natural scrolling
* Install GTK theme
* grub theme
* starship prompt
* install a clipboard
* config.fish full aliases and setup
* permanent wg-quick setup
* automatic setup omf plugins (git, kubectl...etc)
* some widgets using eww
* tmux config
* neovim configuration and plugins

tcpdump wireguard connection: https://www.procustodibus.com/blog/2021/03/wireguard-logs/

# Connect protonvpn

```shell
protonvpn-cli connect --fastest --protocol udp
```

# X11 change keyboard

sudo nvim /etc/X11/xorg.conf.d/00-keyboard.conf

localectl set-x11-keymap us default intl

# Timezone

timedatectl set-timezone Europe/Amsterdam
timedatectl list-timezones | grep -I "Europe"

# Setup my custom vpn (PROTONVPN) using wireguard protocol

https://protonvpn.com/support/wireguard-manual-linux/

download wireguad config

sudo mv X.conf to /etc/wireguard/protonvpn.conf
sudo systemctl enable wg-quick@protonvpn.service --now
curl ifconfig.me

# CHange mac address of your interface permanently

Pending to rename iface

https://wiki.archlinux.org/title/Network_configuration

`/etc/systemd/network/10-net0.link`

```
[Match]
PermanentMACAddress=2e:62:28:d5:a7:fb
Name=wlp58s0


[Link]
Name=wlan0
PermanentMACAddress=82:8d:c4:ce:94:ba
```
* remember to change te iface name if needed

By the moment this task was done using macchanger with a custom systemd service


# Change /etc/systemd/resolved.conf

Put:

[Resolve]
# Some examples of DNS servers which may be used for DNS= and FallbackDNS=:
# Cloudflare: 1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 2606:4700:4700::1001#cloudflare-dns.com
# Google:     8.8.8.8#dns.google 8.8.4.4#dns.google 2001:4860:4860::8888#dns.google 2001:4860:4860::8844#dns.google
# Quad9:      9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net 2620:fe::fe#dns.quad9.net 2620:fe::9#dns.quad9.net
DNS=1.1.1.1
FallbackDNS=1.1.1.1#cloudflare-dns.com 9.9.9.9#dns.quad9.net 8.8.8.8#dns.google 2606:4700:4700::1111#cloudflare-dns.com 2620:fe::9#dns.quad9.net 2001:4860:4860::8888#dns.google
#Domains=
DNSSEC=no

sudo systemctl restart systemd-resolved
# ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# GTK THEME
material black blueberry: https://www.pling.com/p/1316887/


# Setup EBPF tools
https://aya-rs.dev/book/start/development/#ebpf-program-constraints


# Setup touchpad
https://wiki.archlinux.org/title/Libinput
