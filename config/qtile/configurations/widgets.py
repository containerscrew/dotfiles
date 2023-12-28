from libqtile import widget
from configurations.colors import Colors
from libqtile.lazy import lazy

def widget_base(fs=14, f="JetBrainsMono Nerd Font", p=6, bg=Colors.background, fg=Colors.white): 
    return {
        'font': f,
        'fontsize': fs,
        'padding': p,
        'background': bg,
        'foreground': fg
    }

def sep(bg=Colors.background, fg=Colors.white, text=""):
    return  widget.TextBox(
                background=bg,
                foreground=fg,
                text=text, # nf-oct-triangle_left
                fontsize=37,
                padding=-2
            )


widget_defaults = dict(
    **widget_base(),
)


class MyWidgets:
    def __init__(self) -> None:
        # Declare some default values
        pass
    def group_box(self):
        return  widget.GroupBox(
                    **widget_base(f="FontAwesome"),
                    margin_y=3,
                    #fmt="󰮯",
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

    def bluetooth(self):
        return  widget.TextBox(
                    **widget_base(),
                    mouse_callbacks={'Button1': lazy.spawn('blueman-manager')},
                    text = "󰂯",
                )

    def launcher(self):
        return widget.TextBox(
                    **widget_base(bg=Colors.blue, fg=Colors.black),
                    mouse_callbacks={'Button1': lazy.spawn('rofi -show drun -theme ~/.config/rofi/Launcher.rasi')},
                    text = "󰍉",
                )

    def clock(self):
        return  widget.Clock(
                    **widget_base(fs=11,bg=Colors.blue, fg=Colors.black),
                    #https://help.gnome.org/users/gthumb/stable/gthumb-date-formats.html.en
                    format='%a %d %b %H:%M ',
                    mouse_callbacks={'Button1': lazy.spawn('gnome-calendar')},
                )


extension_defaults = widget_defaults.copy()