# archordie
Setup your archlinux for your day in life


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
* Add more shortcuts in sxhkd
* Install GTK theme
* Declare good colors for polybar
* keyboard shortcuts for audio volume
* grub theme
* starship prompt
* install a clipboard
* config.fish full aliases and setup
* pending to install correctly brave browser
* permanent wg-quick setup
* permanent macchanger 
* automatic setup omf plugins (git, kubectl...etc)
* fix arch logo polybar padding + margin
* add custom vpn status polybar for company vpn


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

DNS=1.1.1.1
sudo systemctl restart systemd-resolved

