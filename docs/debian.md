<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [After installation](#after-installation)
- [Metasploit](#metasploit)
- [Install kali sources list](#install-kali-sources-list)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# After installation

```shell
su -
apt-get install sshpass sudo binutils build-essential dnsutils -y
usermod -aG sudo USER_NAME
```


```

# Links

https://www.reddit.com/r/qtile/comments/1699j3o/installing_qtile_on_debian_12_bookworm_guide/


sudo rm /usr/lib/python3.11/EXTERNALLY-MANAGED


```
sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

```
mkdir -p ~/.config/autostart
cp /etc/xdg/autostart/light-locker.desktop ~/.config/autostart
```

https://wiki.debian.org/Suspend
https://wiki.debian.org/ScreenLockingOnSleep
https://manpages.debian.org/unstable/xscreensaver/xscreensaver.1.en.html

add this:

```
deb https://deb.debian.org/debian testing main
deb https://deb.debian.org/debian unstable main
```

# Setup network manager and restart wpa_supplicant
https://wiki.debian.org/NetworkManager

# CONTROL FILES THAT DON'T NEED TO BE OVERWRITEN


# Get certificate from private endpoint

```shell
openssl s_client -connect ejemplo.com:443 -showcerts </dev/null 2>/dev/null | openssl x509 -outform PEM > servidor.crt
```

# Metasploit

```shell
curl -fsSL https://apt.metasploit.com/metasploit-framework.gpg.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/metasploit.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/metasploit.gpg] https://apt.metasploit.com/ buster main" | sudo tee /etc/apt/sources.list.d/metasploit.list
sudo apt update
sudo apt install metasploit-framework
```

# Install kali sources list

```shell
deb http://http.kali.org/kali kali-rolling main contrib non-free in /etc/apt/sources.list

```
