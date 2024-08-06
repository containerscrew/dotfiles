import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

#mod4 or mod = super key
mod = "mod4"
mod1 = "mod1"
mod2 = "control"
mod3  = "shift"
home = os.path.expanduser('~')
Term2 = "alacritty"
myTerm = "kitty"

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

#############################################
############ SHORTCUTS ######################
#############################################


keys = [
    Key([], "F4", lazy.spawn("rofi -show drun")),
    Key([mod], "d", lazy.spawn("dmenu_run -c -l 15 -i -p 'RUN:'")),


##################################################
################# MEDIA CONTROLS #################
##################################################

# INCREASE/DECREASE/MUTE VOLUME
    # Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    # Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    # Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),

    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),

    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
    # Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 5")),
    # Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 5")),



    # Switch between windows in current stack pane
###################################################
################  SWITCH LAYOUT ###################
###################################################

# TOGGLE FLOATING LAYOUT
    Key([mod, "control"], "a", lazy.window.toggle_floating()),

    # CHANGE FOCUS
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "period",lazy.layout.grow(), lazy.layout.increase_nmaster()),
    Key([mod], "comma", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "w", lazy.window.toggle_fullscreen()),
    Key([mod], "h", lazy.layout.decrease_ratio()),
    Key([mod], "l", lazy.layout.increase_ratio()),

# FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip()),

# MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod], "s", lazy.layout.next()),

#########################################
############### BSPWM ###################
#########################################
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "mod1"], "Down", lazy.layout.flip_down()),
    Key([mod, "mod1"], "Up", lazy.layout.flip_up()),
    Key([mod, "mod1"], "Left", lazy.layout.flip_left()),
    Key([mod, "mod1"], "Right", lazy.layout.flip_right()),
    Key([mod, "control"], "Down", lazy.layout.grow_down()),
    Key([mod, "control"], "Up", lazy.layout.grow_up()),
    Key([mod, "shift"], "l", lazy.layout.grow_left()),
    Key([mod, "shift"], "m", lazy.layout.grow_right()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    # Key([mod], "z", lazy.layout.toggle_split()),
    Key([mod], "z", lazy.spawn("killall zoom")),



# Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "a", lazy.prev_layout()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "q", lazy.shutdown()),
    Key([mod], "c", lazy.restart()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "shift"], "x", lazy.spawn("poweroff")),
##############################################
############## SCREENSHOTS ###################
##############################################

    Key(["shift"], "Print", lazy.spawn("clip")),
    Key([mod], "Print", lazy.spawn("crop")),
    Key([], "Print", lazy.spawn("shot")),

#####################3#########################
############## APPLICATIONS ###################
###############################################

    Key([mod], "space", lazy.spawn(Term2)),
    Key([mod, "shift"], "s", lazy.spawn("spotify")),
    Key([], "XF86Tools", lazy.spawn("spotify")),
    Key([mod, "shift"], "space", lazy.spawn("nautilus")),
    Key([mod, "shift"], "a", lazy.spawn("i3lock -c 000000")),
    Key([mod], "KP_Subtract", lazy.spawn("blurlock")),
    Key([mod], "KP_Add", lazy.spawn("lock")),
    Key([mod], "Return", lazy.spawn(myTerm)),
    Key([mod], "KP_Enter", lazy.spawn(myTerm)),
    Key([mod], "v", lazy.spawn("pavucontrol")),
    Key([], "F9", lazy.spawn("pavucontrol")),
    Key([mod], "e", lazy.spawn("emacs")),

    KeyChord([mod], "i",[
        Key([], "f", lazy.spawn("firefox")),
        Key([], "v", lazy.spawn("vivaldi-stable")),
        Key([], "b", lazy.spawn("brave")),
        Key([], "l", lazy.spawn("librewolf")),
    ]),

### XSS-LOCK
    KeyChord([mod], "t",[
        Key([], "x", lazy.spawn("killall xss-lock")),
        Key([], "r", lazy.spawn("xss-lock --transfer-sleep-lock -- lock --nofork")),
            ]),
### DMSCRIPTS
    KeyChord([mod], "x",[
        Key([], "c", lazy.spawn("bash /home/karttikeya/dmscripts/dmconf")),
        Key([], "p", lazy.spawn("bash /home/karttikeya/dmscripts/dmpy")),
            ]),

### REDSHIFT
    KeyChord([mod], "r",[
        Key([], "1", lazy.spawn("redshift -O 6000")),
        Key([], "2", lazy.spawn("redshift -O 5000")),
        Key([], "3", lazy.spawn("redshift -O 4500")),
        Key([], "4", lazy.spawn("redshift -O 4250")),
        Key([], "5", lazy.spawn("redshift -O 4000")),
        Key([], "6", lazy.spawn("redshift -O 3500")),
        Key([], "x", lazy.spawn("redshift -x")),
            ]),
    ]

groups= [
    Group("1",
          label="I",
          ),

    Group("2",
          label="II",
          # spawn='vivaldi',
          matches=[Match(wm_class=["Vivaldi-stable"]),
                   Match(wm_class=["Icecat"]),
                   Match(wm_class=["Brave-browser"]),
                   Match(wm_class=["firefox"]),
                   ],
          ),

    Group("3",
          label="III",
          matches=[Match(wm_class=["Zathura"]),
                   Match(wm_class=["Evince"]),
                   ],
          ),

    Group("4",
          label="IV",
          matches=[Match(wm_class=["discord"]),
                   Match(wm_class=["Signal Beta"]),
                   ],
          ),

    Group("5",
          label="V",
          layout="max",
          matches=[Match(wm_class=["Firefox"]),
                   Match(wm_class=["Mplayer"]),
                   ],
          ),

    Group("6",
          label="VI",
          matches=[Match(wm_class=["pcmanfm"]),
                   Match(wm_class=["Org.gnome.Nautilus"]),
                   Match(wm_class=["qBittorrent"]),
                   ],
          ),

    Group("7",
          label="VII",
          layout="bsp",
          ),

    Group("8",
          label="VIII",
          matches=[Match(wm_class=["emacs"]),
                   ],
          ),

    Group("9",
          label="IX",
          layout="max",
          matches=[Match(wm_class=["zoom"]),
                   Match(wm_class=["Microsoft Teams - Preview"]),
                   Match(wm_class=["pavucontrol"]),
                   ],
          ),

    Group("0",
          label="X"),
          # label=""),
]

for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=False),
            desc="Switch to & move focused window to group {}".format(i.name)),
        Key([mod1, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
    ])
# LAYOUTS
layouts = [
    layout.Tile     (margin=8, border_width=0, border_focus="#bb94cc", border_normal="#4c566a", ratio=0.55, shift_windows=True),
    layout.MonadTall(margin=15, border_width=0, border_focus="#bb94cc", border_normal="#4c566a", ratio=0.55),
    layout.Bsp      (margin=8, border_width=0, border_focus="#bb94cc", border_normal="#4c566a", fair=False),
    layout.Max(),
]

colors =  [
        ["#00000000", "#00000000", "#00000000"],     # color 0
        ["#2e3440", "#2e3440", "#2e3440"], # color 1
        ["#B591B0", "#B591B0", "#B591B0"], # color 2
        ["#A480B2", "#A480B2", "#A480B2"], # color 3
        ["#aed1dc", "#98B7C0", "#aed1dc"], # color 4
        ["#f3f4f5", "#f3f4f5", "#f3f4f5"], # color 5
        ["#bb94cc", "#AB87BB", "#bb94cc"], # color 3
        ["#81658C", "#81658C", "#81658C"], # color 6
        ["#614C69", "#614C69", "#614C69"], # color 8
        ["#0ee9af", "#0ee9af", "#0ee9af"]] # color 9
        # ["#5aec79", "#5aec79", "#5aec79"]] # color 9

# colors =  [
#         ["#00000000", "#00000000", "#00000000"],     # color 0
#         ["#4D5568", "#4D5568", "#414858"],           # color 1
#         ["#65bdd8", "#65bdd8", "#65bdd8"],           # color 2
#         ["#f3f4f5", "#f3f4f5", "#f3f4f5"],           # color 3
#         ["#aed1dc", "#98B7C0", "#aed1dc"],           # color 4
#         ["#000000", "#000000", "#000000"],           # color 5
#         ["#C09ABB", "#C09ABB", "#C09ABB"],           # color 6
#         ["#D8DEE9", "#D8DEE9", "#D8DEE9"],           # color 7
#         ["#CFD5E0", "#CFD5E0", "#CFD5E0"],           # color 8
#         ["#2E3440", "#2E3440", "#2E3440"]]           # color 0


widget_defaults = dict(
    font='novamono for Powerline',
    fontsize=15,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper='/home/karttikeya/Pictures/Wallpapers/anime.jpg',
        wallpaper_mode='fill',
        # bottom=bar.Bar(
        top=bar.Bar(
        [
            widget.TextBox(
                text="\ue0b6",
                fonts="droid sans mono for powerline",
                foreground=colors[8],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.TextBox(
                text="",
                fonts="novamono for powerline bold",
                foreground=colors[5],
                background=colors[8],
                padding=0,
                fontsize=28
            ),
            widget.Sep(
                background=colors[8],
                padding=8,
                linewidth=0,
            ),
            widget.Clock(
                font="novamono for powerline bold",
                fontsize=16,
                foreground=colors[5],
                background=colors[8],
                format='%d %b, %A'
            ),
            widget.TextBox(
                text="\ue0b4",
                fonts="droid sans mono for powerline",
                foreground=colors[8],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.Sep(
                background=colors[0],
                padding=10,
                linewidth=0,
            ),
            widget.TextBox(
                text="\ue0b6",
                fonts="droid sans mono for powerline",
                foreground=colors[7],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.TextBox(
                text="",
                foreground=colors[5],
                background=colors[7],
                padding=0,
                fontsize=33
            ),
            widget.Memory(
                background=colors[7],
                foreground=colors[5],
                font="novamono for powerline bold",
                fontsize=16,
                measure_mem='G',
                measure_swap='G',
                format='{MemUsed: .2f} GB',
            ),
            widget.TextBox(
                text="\ue0b4",
                fonts="droid sans mono for powerline",
                foreground=colors[7],
                padding=0,
                fontsize=38
            ),
            widget.Sep(
                background=colors[0],
                padding=10,
                linewidth=0,
            ),
            widget.TextBox(
                text="\ue0b6",
                fonts="droid sans mono for powerline",
                foreground=colors[3],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.TextBox(
                text="",
                foreground=colors[5],
                background=colors[3],
                padding=0,
                fontsize=33
            ),
            widget.Memory(
                background=colors[3],
                foreground=colors[5],
                font="novamono for powerline bold",
                fontsize=16,
                measure_mem='G',
                measure_swap='G',
                format='{SwapUsed: .2f} GB',
            ),
            widget.TextBox(
                text="\ue0b4",
                fonts="droid sans mono for powerline",
                foreground=colors[3],
                padding=0,
                fontsize=38
            ),
            widget.Sep(
                background=colors[0],
                padding=10,
                linewidth=0,
            ),
            widget.TextBox(
                text="\ue0b6",
                fonts="droid sans mono for powerline",
                foreground=colors[3],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.CurrentLayout(
                background=colors[3],
                foreground=colors[5],
                font="novamono for powerline bold",
                fontsize=15,
            ),
            widget.TextBox(
                text="\ue0b4",
                fonts="droid sans mono for powerline",
                foreground=colors[3],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.CurrentLayoutIcon(
                custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
                scale=0.45,
                padding=0,
                background=colors[0],
            ),

            widget.Spacer(),

            # widget.TextBox(
            #      text="\ue0b6",
            #      fonts="droid sans mono for powerline",
            #      foreground=colors[1],
            #      background=colors[0],
            #      padding=0,
            #      fontsize=38
            # ),
            widget.GroupBox(
                font="space mono for powerline",
                fontsize=14,
                margin_y=4,
                margin_x=4,
                padding_y=5,
                padding_x=3,
                borderwidth=7,
                inactive=colors[2],
                active=colors[9],
                rounded=True,
                highlight_color=colors[0],
                highlight_method="block",
                this_current_screen_border=colors[2],
                block_highlight_text_color=colors[1],
                background=colors[1],
            ),

            widget.Spacer(),

            widget.Systray(
                background=colors[0],
                foreground=colors[8],
                icon_size=20,
                padding=4,
            ),
            # widget.TextBox(
            #     text="\uE0B4",
            #     fonts="droid sans mono for powerline",
            #     foreground=colors[6],
            #     background=colors[0],
            #     padding=0,
            #     fontsize=38
            # ),
            widget.Sep(
                background=colors[0],
                padding=10,
                linewidth=0,
            ),
            widget.TextBox(
                text="\uE0B6",
                fonts="droid sans mono for powerline",
                foreground=colors[2],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.TextBox(
                text="",
                fonts="droid sans mono for powerline",
                foreground=colors[5],
                background=colors[2],
                padding=0,
                fontsize=30
            ),
            widget.Sep(
                background=colors[2],
                padding=8,
                linewidth=0,
            ),
            widget.Volume(
                background=colors[2],
                foreground=colors[5],
                font="novamono for powerline bold",
                fontsize=16,
                mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
                update_interval=0.001,
            ),
            widget.TextBox(
                text="\uE0B4",
                fonts="droid sans mono for powerline",
                foreground=colors[2],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.Sep(
                background=colors[0],
                padding=10,
                linewidth=0,
            ),
            widget.TextBox(
                text="\uE0B6",
                fonts="droid sans mono for powerline",
                foreground=colors[3],
                padding=0,
                fontsize=38
            ),
            widget.TextBox(
                text="",
                foreground=colors[5],
                background=colors[3],
                padding=0,
                fontsize=38
            ),
            widget.CPU(
                background=colors[3],
                foreground=colors[5],
                format=' {load_percent}%',
                font='novamono for powerline bold',
                fontsize=16
            ),
            widget.Sep(
                background=colors[3],
                padding=6,
                linewidth=0,
            ),
            widget.TextBox(
                text="\uE0B4",
                fonts="droid sans mono for powerline",
                foreground=colors[3],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.Sep(
                background=colors[0],
                padding=10,
                linewidth=0,
            ),
            widget.TextBox(
                text="\uE0B6",
                fonts="droid sans mono for powerline",
                foreground=colors[7],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.Sep(
                background=colors[7],
                padding=3,
                linewidth=0,
            ),
            widget.Battery(
                foreground=colors[5],
                background=colors[7],
                fontsize=24,
                low_percentage=0.2,
                low_foreground=colors[5],
                font="lekton nerd font",
                update_interval=1,
                format='{char}',
                charge_char='ﮣ',
                discharge_char=' ',
            ),
            widget.Sep(
                background=colors[7],
                padding=2,
                linewidth=0,
            ),
            widget.Battery(
                background=colors[7],
                foreground=colors[5],
                charge_char='↑',
                discharge_char='↓',
                font="novamono for powerline bold",
                fontsize=16,
                update_interval=1,
                format='{percent:2.0%}'
            ),
            widget.TextBox(
                text="\uE0B4",
                fonts="droid sans mono for powerline",
                foreground=colors[7],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            widget.Sep(
                background=colors[0],
                padding=8,
                linewidth=0,
            ),
            widget.TextBox(
                text="\uE0B6",
                fonts="droid sans mono for powerline",
                foreground=colors[8],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
            # widget.Sep(
            #     background=colors[8],
            #     padding=6,
            #     linewidth=0,
            # ),
            widget.TextBox(
                text="",
                fonts="novamono for powerline bold",
                foreground=colors[5],
                background=colors[8],
                padding=0,
                fontsize=28
            ),
            widget.Sep(
                background=colors[8],
                padding=8,
                linewidth=0,
            ),
            widget.Clock(
                background=colors[8],
                foreground=colors[5],
                font="novamono for powerline bold",
                fontsize=16,
                format='%I:%M %p',
            ),
            widget.TextBox(
                text="\ue0b4",
                fonts="droid sans mono for powerline",
                foreground=colors[8],
                background=colors[0],
                padding=0,
                fontsize=38
            ),
        ],
            43,
            background=colors[0],
            margin=[10,6,4,6],
            # margin=[4,4,6,4],
            # opacity=0.79,
        ),
    ),
]
#############################################
#############################################
############# AUTOSTART #####################
#############################################
@hook.subscribe.startup_once
def autostart():
    processes = [
        ['libinput-gestures'],
    ]

    for p in processes:
        subprocess.Popen(p)


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=0,
    border_focus="#bb94cc",
    border_normal="#4c566a",
    float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
