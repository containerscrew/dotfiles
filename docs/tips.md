<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [X11 change keyboard](#x11-change-keyboard)
- [Timezone](#timezone)

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
