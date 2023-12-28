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
    layout.MonadTall(border_width=3, border_focus=Colors.white, margin=8, border_normal=Colors.blue),
]

# Custom widget class
my_widgets = MyWidgets()


screens = [
    Screen(
        top=bar.Bar(
            [   
                my_widgets.system_logo(),
                widget.Sep(
                    size_percent=60,
                    foreground=Colors.white,
                    padding=10,
                ),
                my_widgets.window_name(),
                widget.Spacer(),
                my_widgets.group_box(),
                widget.Spacer(),
                my_widgets.notifications(),
                my_widgets.vpns(),
                sep(fg=Colors.violet, bg=Colors.background),
                my_widgets.volume(),
                my_widgets.wlan(),
                my_widgets.battery(),
                my_widgets.bluetooth(),
                sep(fg=Colors.blue, bg=Colors.violet),
                my_widgets.launcher(),
                my_widgets.clock(),
                my_widgets.power(),
            ],
            30,
            background=Colors.background,
            margin = [8,20,0,20],
        ),
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
