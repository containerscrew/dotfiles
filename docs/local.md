<!-- START OF TOC !DO NOT EDIT THIS CONTENT MANUALLY-->
**Table of Contents**  *generated with [mtoc](https://github.com/containerscrew/mtoc)*
- [Copy dotfiles from another computer](#copy-dotfiles-from-another-computer)
- [Only copy ~/.config files](#only-copy-~/.config-files)
- [Sync ~/.config files in your local](#sync-~/.config-files-in-your-local)
<!-- END OF TOC -->
# Copy dotfiles from another computer

In the origin computer:

```bash
cd dotfiles/
make remote-sync IP=192.168.X.X USER=bob
```
> Replace the ip and the user. Both values are those of the target computer, where you are installing these settings. To know the ip run on the target pc:

```bash
$ ip a
```

* You need to start sshd in the target computer `sudo systemctl enable sshd --now`
* You need to install `rsync` in the origin and target computer. `sudo pacman -Sy rsync`

# Only copy ~/.config files

```bash
cd dotfiles/
rsync -avzhu config/* username@192.168.X.X:/home/username/.config/
# Or locally
rsync -avzhu config/* /home/username/.config/
```

# Sync ~/.config files in your local

```bash
cd dotfiles/
make sync-local-config
```
