from libqtile.config import Key
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
    # Qtile config, restart, and shutdown
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, alt], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Audio and backlight
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
    Key([], "XF86AudioMicMute", lazy.spawn("mictoggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
    # Applications
    Key(
        [mod],
        "space",
        lazy.spawn("rofi -show drun -theme ~/.config/rofi/Launcher.rasi"),
        desc="Run applications launcher",
    ),
    Key(["control", alt], "l", lazy.spawn("dm-tool lock"), desc="Lock screen"),
    Key([mod, alt], "f", lazy.spawn("firefox"), desc="Open brave browser"),
    Key([mod, alt], "g", lazy.spawn("chromium"), desc="Open chrome browser"),
    Key([mod, alt], "f", lazy.spawn("firefox"), desc="Open firefox browser"),
    Key(
        [mod, alt],
        "s",
        lazy.spawn("flameshot gui"),
        desc="Flameshot for desktop screenshots",
    ),
    Key([mod, alt], "c", lazy.spawn("code"), desc="Open IDE vscode"),
    Key(
        [mod, alt],
        "p",
        lazy.spawn("feh -z --no-fehbg --bg-scale /usr/share/backgrounds"),
        desc="Change wallpapers using feh",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(
        ["control", alt],
        "b",
        lazy.spawn("eww open bar --toggle --duration 3s"),
        desc="Open eww apps bar",
    ),
    Key(
        [mod, alt],
        "Return",
        lazy.spawn(
            "alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90"
        ),
        desc="Launch floatterminal",
    ),  # Floatting terminal
    # Key([mod, alt], "n", lazy.spawn(""), desc="Launch floatterminal"), #Floatting terminal
    # https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Windows
    Key(
        [mod, "shift"],
        "m",
        minimize_all(),
        desc="Toggle hide/show all windows on current group",
    ),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod, "shift"],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window",
    ),
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod],
        "Tab",
        lazy.screen.toggle_group(),
        desc="Switch window focus to previous window in group",
    ),
    Key(
        [mod, "shift"],
        "Tab",
        lazy.spawn("rofi -show window"),
        desc="Switch opened windows",
    ),
    Key(["control", alt], "h", lazy.spawn("clipcat-menu"), desc="clipcat menu"),
    # Organize windows using zrandr
    Key(
        ["control", alt],
        "w",
        lazy.spawn("bash ~/.config/qtile/displays.sh"),
        desc="Execute displays script",
    ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
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
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
]
