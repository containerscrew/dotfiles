# https://github.com/containerscrew

import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from configurations.colors import Colors


mod = "mod4"
alt = "mod1"
terminal = "alacritty"

keys = [
    # Custom config
    Key([mod], "space", lazy.spawn("rofi -show drun -theme ~/.config/rofi/Launcher.rasi"), desc='Run applications launcher'),
    Key(["control", alt], "l", lazy.spawn("dm-tool lock"), desc='Lock screen'),
    Key([mod, alt], "b", lazy.spawn("brave"), desc='Open brave browser'),
    Key([mod, alt], "g", lazy.spawn("google-chrome-stable"), desc='Open chrome browser'),
    Key([mod, alt], "f", lazy.spawn("firefox"), desc='Open firefox browser'),
    Key([mod, alt], "s", lazy.spawn("flameshot gui"), desc='Flameshot for desktop screenshots'),
    Key([mod, alt], "c", lazy.spawn("code"), desc='Open IDE vscode'),
    Key([mod, alt], "w", lazy.spawn("bash ~/.local/bin/changewallpaper"), desc='Change wallpapers using feh'),
    
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod, "shift"], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    Key([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    )),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
]


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

layouts = [
    layout.MonadTall(border_width=2, border_focus=Colors.blue, margin=8),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=10,
    padding=6,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [   
                widget.TextBox(
                    fontsize= 18,
                    padding=10, 
                    foreground=Colors.blue,
                    mouse_callbacks={'Button1': lazy.spawn('rofi -show drun -theme ~/.config/rofi/Launcher.rasi')},
                    text = "",
                ),
                ### start main apps
                widget.TextBox(
                    fontsize= 18,
                    padding=0,
                    foreground=Colors.lightviolet, 
                    text = "|",
                ),
                widget.TextBox(
                    fontsize= 18,
                    foreground=Colors.orange,
                    mouse_callbacks={'Button1': lazy.spawn('firefox')},
                    text = "",
                ),
                widget.TextBox(
                    fontsize= 18,
                    foreground=Colors.brown,
                    mouse_callbacks={'Button1': lazy.spawn('alacritty')},
                    text = "",
                ),
                widget.TextBox(
                    fontsize= 18,
                    foreground=Colors.hotpink,
                    mouse_callbacks={'Button1': lazy.spawn('slack')},
                    text = "󰒱",
                ),
                #### end main apps
                widget.TextBox(
                    fontsize= 18,
                    padding=0,
                    foreground=Colors.lightviolet, 
                    text = "|",
                ),
                widget.WindowName(),
                widget.Spacer(),
                widget.GroupBox(
                    background=Colors.background,
                    foreground=Colors.white,
                    fontsize=15,
                    font="sans",
                    margin_y=3,
                    fmt="󰮯",
                    margin_x=0,
                    padding=10,
                    borderwidth=0,
                    active=Colors.blue,
                    inactive=Colors.violet,
                    rounded=False,
                    highlight_method='block',
                    urgent_alert_method='block',
                    urgent_border=Colors.darkgreen,
                    this_current_screen_border=Colors.background,
                    this_screen_border=Colors.background,
                    other_current_screen_border=Colors.background,
                    other_screen_border=Colors.background,
                    disable_drag=True
                ),
                widget.Spacer(),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.TextBox(
                    background=Colors.black,
                    foreground=Colors.white,
                    text="", # Icon: nf-oct-triangle_left
                    fontsize=37,
                    padding=-2
                ),
                widget.CheckUpdates(
                    colour_have_updates=Colors.black,
                    background=Colors.white,
                    foreground=Colors.black,
                    colour_no_updates=Colors.black,
                    no_update_string='󰑓 0',
                    display_format='󰑓: {updates}',
                    update_interval=1800,
                    custom_command='checkupdates',
                ),
                widget.TextBox(
                    background=Colors.white,
                    foreground=Colors.black,
                    text="", # Icon: nf-oct-triangle_left
                    fontsize=37,
                    padding=-2
                ),
                widget.Memory(
                   background=Colors.black,
                   foreground=Colors.white,
                   format='MEM{MemUsed: .0f}{mm}/{MemTotal:.0f}{mm}'
                ),
                widget.TextBox(
                    background=Colors.black,
                    foreground=Colors.white,
                    text="", # Icon: nf-oct-triangle_left
                    fontsize=37,
                    padding=-2
                ),
                widget.CPU(
                   background=Colors.white,
                   foreground=Colors.black, 
                ),
                widget.TextBox(
                    background=Colors.white,
                    foreground=Colors.black,
                    text="", # Icon: nf-oct-triangle_left
                    fontsize=37,
                    padding=-2
                ),
                widget.Wlan(
                    format=" {essid}",
                    background=Colors.black,
                    foreground=Colors.white,
                    interface="wlp58s0"
                ),
                widget.TextBox(
                    background=Colors.black,
                    foreground=Colors.white,
                    text="", # Icon: nf-oct-triangle_left
                    fontsize=37,
                    padding=-2
                ),
                widget.Clock(
                    background=Colors.white, 
                    foreground=Colors.black,
                    format='󰥔 %d/%m/%Y - %H:%M '
                ),
                #widget.QuickExit(),
            ],
            30,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
