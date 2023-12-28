# Containers Crew
# https://github.com/containerscrew

import os
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Match, Screen
from libqtile.lazy import lazy
from configurations.colors import Colors
from configurations.keys import keys, mod
from configurations.groups import groups
from configurations.widgets import MyWidgets, sep


layouts = [
    layout.MonadTall(border_width=2, border_focus=Colors.blue, margin=8),
]

def widget_base(fontsize=14): 
    return {
        'font': "JetBrainsMono Nerd Font",
        'fontsize': fontsize,
        'padding': 6
    }

widget_defaults = dict(
    **widget_base(),
    background=Colors.background,
    foreground=Colors.white,
)

my_widgets = MyWidgets()

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [   
                widget.TextBox(
                    fontsize= 18,
                    padding=10, 
                    foreground=Colors.blue,
                    #mouse_callbacks={'Button1': lazy.spawn('rofi -show drun -theme ~/.config/rofi/Launcher.rasi')},
                    text = "",
                ),
                widget.Spacer(),
                my_widgets.group_box(),
                widget.Spacer(),
                # WLAN module
                widget.Wlan(
                    **widget_base(),
                    format=" ",
                    interface="wlp58s0",
                    mouse_callbacks={'Button1': lazy.spawn('alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e nmcli device wifi list')},
                ),
                widget.Battery(
                    **widget_base(),
                    # charge_char="",
                    # full_char="",
                    # discharge_char="",
                    # empty_char="",
                    format="󰂄 {percent:2.0%}",
                    show_short_text=False,
                    low_foreground=Colors.red,
                    update_interval=1,
                ),
                my_widgets.bluetooth(),
                sep(fg=Colors.blue, bg=Colors.background),
                my_widgets.launcher(),
                my_widgets.clock(),
            ],
            30,
            background=Colors.background,
            margin = [8,20,0,20],
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
        Match(wm_class="FloaTerm"),
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
