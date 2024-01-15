<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [X11 change keyboard](#x11-change-keyboard)
- [Timezone](#timezone)
- [DNS configuration](#dns-configuration)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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

# DNS configuration

Edit `/etc/systemd/resolved.conf`:


```
[Resolve]

DNS=1.1.1.1
FallbackDNS=1.1.1.1#cloudflare-dns.com 9.9.9.9#dns.quad9.net 8.8.8.8#dns.google 2606:4700:4700::1111#cloudflare-dns.com 2620:fe::9#dns.quad9.net 2001:4860:4860::8888#dns.google
#Domains=
DNSSEC=no
```
