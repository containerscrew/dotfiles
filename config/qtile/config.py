import os
import subprocess
from libqtile import layout, hook 
from libqtile.config import Match
from typing import List  # noqa: F401
# Custom configuration imported from configs folder
from configs.groups import groups
from configs.screens import screens
from configs.layouts  import layouts
# from configs.keys import keys


border=dict(
    border_focus="#aaeedd",
    border_normal="#4c566a"
)

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    border_width=2,
    **border,
    float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='Tk'),  # ssh-askpass
    Match(wm_class='Signal Beta'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"

# Script for displays position, always execute if you reload QTILE config
@hook.subscribe.startup
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.local/bin/autoarrange'])


# Only start once, even if you restart QTILE config
@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])