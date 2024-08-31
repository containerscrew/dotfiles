from libqtile import layout
from libqtile.config import Drag, Click
from libqtile.lazy import lazy
from .colors import Colors
from configs.keys import mod

layouts = [
    layout.MonadTall(
        border_width=3,
        border_focus=Colors.background,
        margin=8,
        border_normal=Colors.background,
    ),
]

# Mouse layouts
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
