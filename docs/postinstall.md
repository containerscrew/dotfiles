<!-- START OF TOC !DO NOT EDIT THIS CONTENT MANUALLY-->
**Table of Contents**  *generated with [mtoc](https://github.com/containerscrew/mtoc)*
- [Post Installation](#post-installation)
- [Setup nvidia drivers](#setup-nvidia-drivers)
- [Setup plymouth theme](#setup-plymouth-theme)
- [Display positions using autorandr](#display-positions-using-autorandr)
- [X11 change keyboard](#x11-change-keyboard)
- [Timezone](#timezone)
- [Setup rustup](#setup-rustup)
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
* Download wireguard conf file from [here](https://account.protonvpn.com/downloads)

After download wireguard config:

```shell
$ sudo mv protonvpn.conf to /etc/wireguard/protonvpn.conf
$ sudo systemctl enable wg-quick@protonvpn.service --now
$ curl ifconfig.me
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
