import os
from libqtile.config import Group, Key
from libqtile.lazy import lazy
from .keys import keys

mod = "mod4"
alt = "mod1"
terminal = "alacritty"
mod2 = "control"
mod3  = "shift"
home = os.path.expanduser('~')

groups= [
    Group("1", # firefox
          label="",
          ),
    Group("2",
          label="", # chromium
          ),
    Group("3",# slack
          label="",
          ),
    Group("4",
          label="", # alacritty
          ),
    Group("5", # code
          label="",
          ),
    Group("6", # spotify
          label="",
          ),
    Group("7", # nautilus
          label="",
          ),
    Group("8", # discord
          label="",
          ),
    Group("9", # free
          label="",
    )
]

for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N
        Key([mod], actual_key, lazy.group[group.name].toscreen()),
        # Send window to workspace N
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])

# for i in groups:
#     keys.extend([
#         Key([mod], i.name, lazy.group[i.name].toscreen(),
#             desc="Switch to group {}".format(i.name)),
#         Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False),
#             desc="Switch to & move focused window to group {}".format(i.name)),
#         Key([alt, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
#             desc="Switch to & move focused window to group {}".format(i.name)),
#         Key([mod], "[", lazy.screen.prev_group(skip_empty=False)), # cycle left
#         Key([mod], "]", lazy.screen.next_group(skip_empty=False)), #cycle right
#     ])

### ScratchPad
# groups.append(ScratchPad('Scratchpad',[
#     DropDown("sig", "signal-desktop", height=0.6, width=0.5, x=0.25, y=0.225,
#              opacity=1),
#     DropDown("term", "kitty", height=0.6, opacity=1),
#     DropDown("editor", "emacs",
#              x=0.05, y=0.35, width=0.9, height=0.65, opacity=1,
#              on_focus_lost_hide=True),
#     DropDown("fmger", "thunar", height=0.7, opacity=1,
#              width=0.7, x=0.15, y=0.10 ),
#     DropDown("spotify", "spotify", height=0.7, opacity=0.9,
#              width=0.7, x=0.15, y=0.15 ),
#     DropDown("fm", 'kitty -e ranger', height=0.7, opacity=1,
#              width=0.7, x=0.15, y=0.125),
#     DropDown("hitop", 'kitty -e htop', height=0.7, opacity=1,
#              width=0.7, x=0.15, y=0.125),
#     DropDown("dc", 'kitty -e gord', height=0.7, opacity=1,
#              width=0.7, x=0.15, y=0.125),
#     DropDown("top", 'kitty -e btop', height=0.7, opacity=1,
#              width=0.7, x=0.15, y=0.125),
# ]))