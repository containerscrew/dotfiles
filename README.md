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


