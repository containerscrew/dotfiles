from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

powerline = {
    "decorations": [
        PowerLineDecoration()
    ]
}


def decoration():
    return widget.widget.GroupBox2(**powerline)
