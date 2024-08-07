# containerscrew dotfiles

My dotfiles using Arch Linux. Just for the time it takes to document this repository and configurations, **this repo deserves one star!**

> [!WARNING]
> The documentation is not yet well finished. There are still things to document and configure. However, I hope the configuration files can help you.

![current-desktop](./assets/example-desktop.png)

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
    - [Option 1: Download dotfiles from git](#option-1-download-dotfiles-from-git)
    - [Option 2: Copy dotfiles from another computer](#option-2-copy-dotfiles-from-another-computer)
    - [Only copy ~/.config files](#only-copy-config-files)
- [Run setup.sh](#run-setupsh)
- [Post install](#post-install)
- [BIOS settings](#bios-settings)
- [Shortcuts](#shortcuts)
- [Tips](#tips)
- [MISC documentation](#misc-documentation)
- [Links](#links)
- [Credits](#credits)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


# Disclaimer ⚠️

It is my personal setup, the way I like it, with configurations that are comfortable for me, applications... etc. Use it if you want as a template, as a guide. I will update it as I need to add new packages, configs...etc.

> [!IMPORTANT]
> There are still many things to configure, I will do it as I go. Mouse, trackpad, eww widgets... etc

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

| Setting                   | Configuration                       |
|---------------------------|-------------------------------------|
| Locales/Language/Keyboard | US                                  |
| Mirrors                   | Netherlands                         |
| Bootloader                | Grub                                |
| Disk Encryption           | ALWAYS                              |
| Disk Filesystem           | BTRFS                               |
| Swap                      | True                                |
| Profile                   | Minimal                             |
| Root password             | Yes                                 |
| User sudoer               | Yes                                 |
| Audio                     | Pipewire                            |
| Kernels                   | Linux                               |
| Additional packages       | rsync,python3,openssh,neovim,curl,git, wget |
| Network                   | NetworkManager                      |
| UTC                       | Europe/Amsterdam                    |
| Optional repos            | multilib                            |

> The installer will ask if you want to chroot into the system. Type yes and enable ssh (for rsync). `systemctl enable sshd`

## After installation

First setps after installation. Remove the usb from your computer and restart. Grub will launch the new archlinux distro, and a basic prompt (black window) will appear.


### Connect the computer to the internet

```shell
$ nmcli device wifi list
$ nmcli device wifi connect SSID_or_BSSID password SSID/BSSID-PASSWORD
# or use
$ nmcli device wifi connect -a
$ history -c
```

### Option 1: Download dotfiles from git

```shell
$ cd /tmp
$ git clone https://github.com/containerscrew/dotfiles.git
$ cd dotfiles
$ bash setup.sh
```

### Option 2: Copy dotfiles from another computer

```shell
$ cd /tmp
$ git clone https://github.com/containerscrew/dotfiles.git
$ rsync -avzh --exclude='.git/' dotfiles/ username@192.168.X.X:/tmp/dotfiles/
# Then login to the server and execute the script setup.sh
ssh username@ip
bash /tmp/dotfiles/setup.sh
```
> openssh must be enabled

### Only copy ~/.config files

```shell
cd dotfiles/
rsync -avzhu config/* username@192.168.X.X:/home/username/.config/
# Or locally
rsync -avzhu config/* /home/username/.config/
```

# Run setup.sh

[setup.sh](./setup.sh) will install main packages using `pacman` and `paru`. Also, will copy all config files in user home, will set some basic configs like `firewall`, `lightdm` theme...etc. Take a look!

> All installation scripts are in the `installers` folder

# Post install

Post intallation setps. Some work settings, and other stuff.

See [postinstall.md](./docs/postinstall.md)


# BIOS settings

Pending to write documentation of BIOS settings. By the moment, protect BIOS settings with admin password.

# Shortcuts

See [shortcuts](./docs/shortcuts.md) documentation.

# Tips

Some tips about archlinux configurations.

[Tips](./docs/tips.md) documentation

# MISC documentation

[Misc documentation](./docs/misc.md)

# Links

* [wireguard logs](https://www.procustodibus.com/blog/2021/03/wireguard-logs/)
* [change mac address without macspoof](https://wiki.archlinux.org/title/Network_configuration)
* [touchpad configuration](https://wiki.archlinux.org/title/Libinput)
* [fish ssh agent](https://github.com/ivakyb/fish_ssh_agent)


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
* https://github.com/newmanls/rofi-themes-collection
* [Grub theme](https://www.gnome-look.org/p/2076542)
* [Conky theme](https://www.gnome-look.org/p/1831404)

# License

[LICENSE](./LICENSE)
