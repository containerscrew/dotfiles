# import os
# from libqtile.config import Click, Drag, KeyChord
# from libqtile.lazy import lazy
# from libqtile.config import Key

# mod = "mod4"
# mod1 = "mod1"
# mod2 = "control"
# mod3  = "shift"
# home = os.path.expanduser('~')
# Term2 = "alacritty"
# myTerm = "kitty"

# # if qtile.core.name=='x11':
# #     launcher="dmenu_run -i -h 25 -p 'RUN:'"
# # elif qtile.core.name=='wayland':
#     # launcher="bemenu-run -i -H 30 --fn 'Space mono for powerline 11' --nb '#2e3440' --nf '#ffffff' --hb '#aaeedd' --hf '#000000' --sb '#aaeedd' --sf '#000000' -p 'RUN:' --tb '#aaeedd' --tf '#000000' --fb '#000000' --ff '#aaeedd'"

# # a=subprocess.Popen('echo $HOME', shell=True, stdout=subprocess.PIPE)
# # user=a.communicate()[0].decode().strip()

# @lazy.function
# def window_to_prev_group(qtile):
#     if qtile.currentWindow is not None:
#         i = qtile.groups.index(qtile.currentGroup)
#         qtile.currentWindow.togroup(qtile.groups[i - 1].name)

# @lazy.function
# def window_to_next_group(qtile):
#     if qtile.currentWindow is not None:
#         i = qtile.groups.index(qtile.currentGroup)
#         qtile.currentWindow.togroup(qtile.groups[i + 1].name)

# #############################################
# ############ SHORTCUTS ######################
# #############################################


# keys = [
#     Key([], "F4", lazy.spawn("launcher")),
#     Key([mod], "d", lazy.spawn("dmenu_run -i -h 25 -p 'RUN'")),


# ##################################################
# ################# MEDIA CONTROLS #################
# ##################################################

# # INCREASE/DECREASE/MUTE VOLUME
#     # Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
#     # Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
#     # Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),

#     Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
#     Key([], "XF86AudioMicMute", lazy.spawn("mictoggle")),
#     Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
#     Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),

#     Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
#     Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
#     Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
#     Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
#     # Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 5")),
#     # Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 5")),
#     Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 5")),
#     Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 5")),



#     # Switch between windows in current stack pane
# ###################################################
# ################  SWITCH LAYOUT ###################
# ###################################################

# # TOGGLE FLOATING LAYOUT
#     Key([mod, "control"], "a", lazy.window.toggle_floating()),

#     # CHANGE FOCUS
#     Key([mod], "Up", lazy.layout.up()),
#     Key([mod], "Down", lazy.layout.down()),
#     Key([mod], "Left", lazy.layout.left()),
#     Key([mod], "Right", lazy.layout.right()),
#     Key([mod], "k", lazy.layout.up()),
#     Key([mod], "j", lazy.layout.down()),
#     Key([mod], "period",lazy.layout.grow(), lazy.layout.increase_nmaster()),
#     Key([mod], "comma", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
#     Key([mod], "n", lazy.layout.normalize()),
#     Key([mod], "w", lazy.window.toggle_fullscreen()),
#     Key([mod], "h", lazy.layout.decrease_ratio()),
#     Key([mod], "l", lazy.layout.increase_ratio()),

# # FLIP LAYOUT FOR MONADTALL/MONADWIDE
#     Key([mod, "shift"], "f", lazy.layout.flip()),

# # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
#     Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
#     Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
#     Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
#     Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
#     Key([mod, "shift"], "Left", lazy.layout.swap_left()),
#     Key([mod, "shift"], "Right", lazy.layout.swap_right()),
#     Key([mod], "s", lazy.layout.next()),

# #########################################
# ############### BSPWM ###################
# #########################################
#     Key([mod], "Down", lazy.layout.down()),
#     Key([mod], "Up", lazy.layout.up()),
#     Key([mod], "Left", lazy.layout.left()),
#     Key([mod], "Right", lazy.layout.right()),
#     Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
#     Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
#     Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
#     Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
#     Key([mod, "mod1"], "Down", lazy.layout.flip_down()),
#     Key([mod, "mod1"], "Up", lazy.layout.flip_up()),
#     Key([mod, "mod1"], "Left", lazy.layout.flip_left()),
#     Key([mod, "mod1"], "Right", lazy.layout.flip_right()),
#     Key([mod, "control"], "Down", lazy.layout.grow_down()),
#     Key([mod, "control"], "Up", lazy.layout.grow_up()),
#     Key([mod, "shift"], "l", lazy.layout.grow_left()),
#     Key([mod, "shift"], "m", lazy.layout.grow_right()),
#     Key([mod, "shift"], "n", lazy.layout.normalize()),
#     # Key([mod], "z", lazy.layout.toggle_split()),
#     Key([mod], "z", lazy.spawn("killall zoom")),

#     Key([mod], "b", lazy.hide_show_bar()),
#     Key([mod], "Tab", lazy.next_layout()),
#     Key([mod], "a", lazy.prev_layout()),
#     Key([mod], "q", lazy.window.kill()),
#     Key([mod, "shift"], "q", lazy.shutdown()),
#     Key([mod], "c", lazy.restart()),
#     Key([mod], "r", lazy.spawncmd()),
#     Key([mod, "shift"], "x", lazy.spawn("poweroff")),
# ##############################################
# ############## SCREENSHOTS ###################
# ##############################################

#     Key(["shift"], "Print", lazy.spawn("clip")),
#     Key(["control"], "Print", lazy.spawn("vmcrop")),
#     Key([mod], "Print", lazy.spawn("crop")),
#     Key([], "Print", lazy.spawn("shot")),

# #####################3#########################
# ############## APPLICATIONS ###################
# ###############################################

#     Key([mod], "space", lazy.spawn(Term2)),
#     Key([mod, "shift"], "a", lazy.spawn("i3lock -c 000000")),
#     Key([mod], "KP_Subtract", lazy.spawn("i3lock -c 00000000")),
#     Key([mod], "KP_Add", lazy.spawn("lock")),
#     Key([mod], "Return", lazy.spawn(myTerm)),
#     Key([mod], "KP_Enter", lazy.spawn(myTerm)),
#     Key([mod], "z", lazy.spawn(myTerm+" -e fish")),
#     Key([mod], "v", lazy.spawn("pavucontrol")),
#     Key([], "F9", lazy.spawn("pavucontrol")),
#     Key([mod, "shift"], 'd', lazy.spawn('dunstop')),

#     KeyChord([mod], "i",[
#         Key([], "f", lazy.spawn("firefox-bin")),
#         Key([], "v", lazy.spawn("vivaldi-stable")),
#         Key([], "b", lazy.spawn("brave-bin")),
#         Key([], "l", lazy.spawn("librewolf")),
#     ]),
# ### EDITORS
#     KeyChord([mod], "e",[
#         Key([], "e", lazy.spawn("emacs")),
#         Key([], "v", lazy.spawn("vscodium")),
#         Key([], "k", lazy.spawn("kitty -e nvim")),
#     ]),
# ### XSS-LOCK
#     KeyChord([mod], "t",[
#         Key([], "x", lazy.spawn("killall xss-lock")),
#         Key([], "r", lazy.spawn("xss-lock --transfer-sleep-lock -- i3lock -c 00000000 --nofork")),
#             ]),
# ### DMSCRIPTS
#     KeyChord([mod], "x",[
#         Key([], "c", lazy.spawn("bash /home/karttikeya/dmscripts/dmconf")),
#         Key([], "x", lazy.spawn("powermenu")),
#         Key([], "p", lazy.spawn("bash /home/karttikeya/dmscripts/dmpy")),
#         Key([], "f", lazy.spawn("bash /home/karttikeya/dmscripts/dmfeh")),
#             ]),

# ### REDSHIFT
#     KeyChord([mod], "r",[
#         Key([], "1", lazy.spawn("redshift -O 6000")),
#         Key([], "2", lazy.spawn("redshift -O 5000")),
#         Key([], "3", lazy.spawn("redshift -O 4500")),
#         Key([], "4", lazy.spawn("redshift -O 4250")),
#         Key([], "5", lazy.spawn("redshift -O 4000")),
#         Key([], "6", lazy.spawn("redshift -O 3500")),
#         Key([], "x", lazy.spawn("redshift -x")),
#             ]),
#     ]
from libqtile.config import Key, Drag, Click
from libqtile.lazy import lazy

mod = "mod4"
alt = "mod1"
terminal = "alacritty"

# A function for hide/show all the windows in a group
@lazy.function
def minimize_all(qtile):
    for win in qtile.current_group.windows:
        if hasattr(win, "toggle_minimize"):
            win.toggle_minimize()

keys = [
    # Custom config
    Key([mod], "space", lazy.spawn("rofi -show drun -theme ~/.config/rofi/Launcher.rasi"), desc='Run applications launcher'),
    Key(["control", alt], "l", lazy.spawn("dm-tool lock"), desc='Lock screen'),
    Key([mod, alt], "b", lazy.spawn("brave"), desc='Open brave browser'),
    Key([mod, alt], "g", lazy.spawn("google-chrome-stable"), desc='Open chrome browser'),
    Key([mod, alt], "f", lazy.spawn("firefox"), desc='Open firefox browser'),
    Key([mod, alt], "s", lazy.spawn("flameshot gui"), desc='Flameshot for desktop screenshots'),
    Key([mod, alt], "c", lazy.spawn("code"), desc='Open IDE vscode'),
    Key([mod, alt], "p", lazy.spawn("feh -z --no-fehbg --bg-scale /usr/share/backgrounds"), desc='Change wallpapers using feh'),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(["control", alt], "b", lazy.spawn("eww open bar --toggle --duration 3s"), desc="Open eww apps bar"),
    Key([mod, alt], "Return", lazy.spawn("alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90"), desc="Launch floatterminal"), #Floatting terminal
    #Key([mod, alt], "n", lazy.spawn(""), desc="Launch floatterminal"), #Floatting terminal



    # https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Windows
    Key([mod, "shift"], "m", minimize_all(), desc="Toggle hide/show all windows on current group"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod, "shift"], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "Tab", lazy.screen.toggle_group(), desc="Switch window focus to previous window in group"),
    Key([mod, "shift"], "Tab", lazy.spawn("rofi -show window"), desc='Switch opened windows'),
    Key(["control", alt], "h", lazy.spawn("diodon"), desc='Open clipboard manager'),
    # Organize windows using zrandr
    Key(["control", alt], "w", lazy.spawn("bash ~/.config/qtile/displays.sh"), desc='Execute displays script'),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Toggle between different layouts as defined below
    # Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),

    # Qtile config, restart, and shutdown
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, alt], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),


    # Volume
    # $ xmodmap -pke | grep Audio
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    Key([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    )),
    # Key([], "XF86AudioNext", lazy.spawn(
    #     "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    # )),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
]

# Mouse layouts
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

# keys.extend([
#     Key([mod, 'shift'], "v", lazy.group['Scratchpad'].dropdown_toggle('sig')),
#     Key([mod], "p", lazy.group['Scratchpad'].dropdown_toggle('term')),
#     Key([mod], "o", lazy.group['Scratchpad'].dropdown_toggle('editor')),
#     Key([mod, "shift"], "s", lazy.group['Scratchpad'].dropdown_toggle("spotify")),
#     Key([mod, "shift"], "d", lazy.group['Scratchpad'].dropdown_toggle("dc")),
#     Key(['control'], 'space', lazy.group['Scratchpad'].dropdown_toggle('fm')),
#     Key([alt], 'space', lazy.group['Scratchpad'].dropdown_toggle('top')),
#     Key([alt, 'shift'], 'space', lazy.group['Scratchpad'].dropdown_toggle('hitop')),
#     Key([mod, 'shift'], 'space', lazy.group['Scratchpad'].dropdown_toggle('fmger')),
# ])