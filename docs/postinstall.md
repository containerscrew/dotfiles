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

If you have gpu in your laptop/pc, follow this steps:

- https://github.com/korvahannu/arch-nvidia-drivers-installation-guide
- https://wiki.archlinux.org/title/NVIDIA

# Setup plymouth theme

# Display positions using autorandr

```bash
autorandr --save xxxx
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
