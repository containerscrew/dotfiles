from libqtile import widget
from configurations.colors import Colors
from libqtile.lazy import lazy

def widget_base(fs=14): 
    return {
        'font': "JetBrainsMono Nerd Font",
        'fontsize': fs,
        'padding': 6
    }

def sep(bg, fg):
    return  widget.TextBox(
                background=bg,
                foreground=fg,
                text="", # Icon: nf-oct-triangle_left
                #fontsize=37,
                padding=-2
            )



widget_defaults = dict(
    **widget_base(),
    background=Colors.background,
    foreground=Colors.white,
)


class MyWidgets:
    def __init__(self) -> None:
        # Declare some default values
        pass
    def left_apps(self):
        pass
    def group_box(self):
        return  widget.GroupBox(
                    **widget_base(),
                    margin_y=3,
                    fmt="󰮯",
                    margin_x=0,
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
                )

    def clock(self):
        return  widget.Clock(
                    **widget_base(fs=11),
                    #https://help.gnome.org/users/gthumb/stable/gthumb-date-formats.html.en
                    format='%a %d %b %H:%M ',
                    mouse_callbacks={'Button1': lazy.spawn('gnome-calendar')},
                )






extension_defaults = widget_defaults.copy()