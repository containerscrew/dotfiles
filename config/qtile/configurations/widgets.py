from libqtile import widget
from configurations.colors import Colors
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

decoration_group = {
    "decorations": [
        RectDecoration(colour="#708491", radius=10, filled=True, group=True, padding_y=4)
    ],
}


def widget_base(fs=14, f="JetBrainsMono Nerd Font", p=6, bg=Colors.background, fg=Colors.white):
    return {
        'font': f,
        'fontsize': fs,
        'padding': p,
        'background': bg,
        'foreground': fg
    }


def sep(bg=Colors.background, fg=Colors.white, text=""):
    return widget.TextBox(
        background=bg,
        foreground=fg,
        text=text,  # nf-oct-triangle_left
        fontsize=40,
        padding=-4
    )


widget_defaults = dict(
    **widget_base(),
)


class MyWidgets:
    def __init__(self) -> None:
        # Declare some default values
        pass

    def system_logo(self):
        return widget.TextBox(
            **widget_base(fs=18, p=10, fg=Colors.lightblue),
            mouse_callbacks={'Button1': lazy.spawn('eww open --toggle profilecard --duration 5s')},
            text="󰣇",
        )

    def window_name(self):
        return widget.WindowName(**widget_base(fs=10, p=5), max_chars=40)

    def group_box(self):
        return widget.GroupBox(
            **widget_base(f="FontAwesome"),
            margin_y=3,
            # fmt="󰮯",
            margin_x=0,
            borderwidth=0,
            active=Colors.darkviolet,
            inactive=Colors.lightblue,
            rounded=False,
            highlight_method='block',
            urgent_alert_method='block',
            urgent_border=Colors.background,
            this_current_screen_border=Colors.background,
            this_screen_border=Colors.background,
            other_current_screen_border=Colors.background,
            other_screen_border=Colors.background,
            disable_drag=True
        )

    def notifications(self):
        return widget.WidgetBox(
            **widget_base(fg=Colors.blue),
            text_closed="󰮯",
            text_open="󰊠",
            widgets=[
                widget.Systray(),
                widget.StatusNotifier(
                    icon_theme="Papirus-Dark"
                ),
                widget.GenPollCommand(
                    **widget_base(),
                    cmd="dunstctl is-paused",
                    shell=True,
                    fmt="Notifications Paused: {}",
                    update_interval=2,
                    mouse_callbacks={'Button1': lazy.spawn('dunstctl set-paused true'),
                                     'Button3': lazy.spawn('dunstctl set-paused false')},
                ),
            ]
        )

    def vpns(self):
        return widget.WidgetBox(
            **widget_base(fg=Colors.blue),
            text_closed="󱘖",
            text_open="󰴽",
            widgets=[
                widget.GenPollCommand(
                    **widget_base(),
                    cmd="systemctl is-active wg-quick@protonvpn.service",
                    shell=True,
                    fmt="ProtonVPN: {}",
                    update_interval=2,
                    mouse_callbacks={'Button1': lazy.spawn(
                        'alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e systemctl start wg-quick@protonvpn.service'),
                                     'Button3': lazy.spawn(
                                         'alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e systemctl stop wg-quick@protonvpn.service')},
                ),
            ]
        )

    def volume(self):
        return widget.PulseVolume(
            **widget_base(bg=Colors.violet, fg=Colors.background, f="FontAwesome"),
            emoji=True,
            emoji_list=['', '', '', ''],
        )

    def wlan(self):
        return widget.Wlan(
            **widget_base(bg=Colors.violet, fg=Colors.background),
            format=" ",
            interface="wlp2s0",
            mouse_callbacks={'Button1': lazy.spawn(
                'alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e nmcli device wifi list')},
        )

    def battery(self):
        return widget.Battery(
            **widget_base(bg=Colors.violet, fg=Colors.background),
            # charge_char="",
            # full_char="",
            # discharge_char="",
            # empty_char="",
            format="󰂄 {percent:2.0%}",
            show_short_text=False,
            low_foreground=Colors.red,
            update_interval=1,
        )

    def bluetooth(self):
        return widget.TextBox(
            **widget_base(bg=Colors.violet, fg=Colors.background),
            mouse_callbacks={'Button1': lazy.spawn('blueman-manager')},
            text="󰂯",
        )

    def launcher(self):
        return widget.TextBox(
            **widget_base(bg=Colors.blue, fg=Colors.black),
            mouse_callbacks={'Button1': lazy.spawn('rofi -show drun -theme ~/.config/rofi/Launcher.rasi')},
            text="󰍉",
        )

    def rfkill_block(self):
        return widget.TextBox(
            **widget_base(bg=Colors.blue, fg=Colors.red),
            mouse_callbacks={'Button1': lazy.spawn('alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e sudo rfkill block all'),
                             'Button3': lazy.spawn('alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e sudo rfkill unblock all')},
            text="",
        )

    def clock(self):
        return widget.Clock(
            **widget_base(fs=11, bg=Colors.blue, fg=Colors.background),
            # https://help.gnome.org/users/gthumb/stable/gthumb-date-formats.html.en
            format='%a %d %b %H:%M ',
            mouse_callbacks={'Button1': lazy.spawn('gnome-calendar')},
        )

    def power(self):
        return widget.TextBox(
            **widget_base(bg=Colors.background, fg=Colors.red, p=10),
            mouse_callbacks={'Button1': lazy.spawn('eww open --toggle powermenu --duration 3s')},
            text="󰐥",
        )


extension_defaults = widget_defaults.copy()
