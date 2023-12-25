# Containers Crew
# https://github.com/containerscrew

from libqtile.config import Key, Group
from libqtile.command import lazy
from .keys import mod, alt, keys

# Number of workspaces
groups = [Group(i) for i in [
    "1", "2", "3", "4", "5", "6" ]]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N
        Key([mod], actual_key, lazy.group[group.name].toscreen()),
        # Send window to workspace N
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])