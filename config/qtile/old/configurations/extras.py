from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration, BorderDecoration, RectDecoration
from configurations.colors import Colors

powerline = {
    "decorations": [
        PowerLineDecoration(
            path="zig_zag",
            colour=Colors.blue,
        )
    ]
}

border_decoration = {
    "decorations": [
        BorderDecoration(
            colour=Colors.blue,
            border_width = [0, 0, 2, 0]
        )
    ]
}

decoration_group = {
    "decorations": [
        RectDecoration(colour=Colors.background, radius=10, filled=True, padding_y=4, group=True)
    ],
    "padding": 10,
}

def window_name():
    return widget.WindowName(
        background=Colors.background, 
        **border_decoration,
    )


def group_box():
    return widget.GroupBox(
        margin_x=0,
        borderwidth=2,
        active=Colors.grey,
        inactive=Colors.white,
        rounded=False,
        highlight_method='block',
        urgent_alert_method='block',
        urgent_border=Colors.background,
        this_current_screen_border=Colors.green,
        this_screen_border=Colors.green,
        disable_drag=True,
        **decoration_group
    )