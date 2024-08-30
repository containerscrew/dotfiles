import netifaces as ni
from libqtile import widget

from .colors import Colors
from libqtile.lazy import lazy

wlan_interface = None

# Get the name of the wlan interface
interfaces = ni.interfaces()
for iface in interfaces:
    if iface.startswith('wl'):
        wlan_interface = iface
        break


def widget_base(fs=14, f="JetBrainsMono Nerd Font", p=6, bg=Colors.background, fg=Colors.white):
    return {
        'font': f,
        'fontsize': fs,
        'padding': p,
        'background': bg,
        'foreground': fg
    }


def sep(bg=Colors.background, fg=Colors.white, text="", padding=-4):
    return widget.TextBox(
        background=bg,
        foreground=fg,
        text=text,
        fontsize=40,
        padding=padding
    )


widget_defaults = dict(
    **widget_base(),
)

apps_data = [
    # Add your logo img and command here
    ('~/.config/qtile/icon-apps/brave-logo.png', 'brave'),
    ('~/.config/qtile/icon-apps/signal-logo.png', 'signal-desktop'),
    ('~/.config/qtile/icon-apps/chrome-logo.png', 'chromium'),
    ('~/.config/qtile/icon-apps/slack-logo.png', 'slack'),
    ('~/.config/qtile/icon-apps/spotify-logo.png', 'spotify-launcher'),
    ('~/.config/qtile/icon-apps/pycharm-logo.png', 'jetbrains-toolbox'),
    ('~/.config/qtile/icon-apps/alacritty-logo.png', 'alacritty'),
]


class MyWidgets:
    def __init__(self) -> None:
        # Declare some default values
        pass

    def space(self):
        return widget.TextBox(
            **widget_base(fs=12),
            text="",
        )

    def system_logo(self):
        return widget.TextBox(
            **widget_base(fs=18, p=10, fg=Colors.blue, bg=Colors.background),
            mouse_callbacks={'Button1': lazy.spawn('rofi -show drun -theme ~/.config/rofi/Launcher.rasi')},
            text="",
        )

    def window_name(self):
        return widget.WindowName(**widget_base(fs=10, p=5), max_chars=40)

    def group_box(self):
        return widget.GroupBox(
            **widget_base(f="FontAwesome", p=4),
            margin_x=0,
            borderwidth=2,
            active=Colors.grey,
            inactive=Colors.foreground,
            rounded=False,
            highlight_method='line',
            urgent_alert_method='line',
            urgent_border=Colors.background,
            this_current_screen_border=Colors.green,
            this_screen_border=Colors.green,
            disable_drag=True
        )

    def pomodoro(self):
        return widget.Pomodoro(
            color_inactive=Colors.orange,
            prefix_inactive="󱫠",
            prefix_paused="󱫞",
            prefix_active="󱤥  ",
            foreground=Colors.violet,
        )

    def notifications(self):
        return widget.DoNotDisturb(
            disabled_icon='󱇥',
            enabled_icon='󱏧',
            foreground=Colors.lightblue,
            fontsize=15,
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

    def package_updates(self):
        return widget.CheckUpdates(
            background=Colors.blue,
            colour_have_updates=Colors.green,
            colour_no_updates=Colors.background,
            no_update_string='  0',
            display_format='  {updates}',
            update_interval=120,
            distro='Arch_paru',
            mouse_callbacks={'Button1': lazy.spawn('alacritty --hold --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e paru -Qu')}
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
            interface=wlan_interface,
            mouse_callbacks={'Button1': lazy.spawn(
                'alacritty --class FloaTerm,Alacritty -o window.dimensions.lines=22 window.dimensions.columns=90 -e nmcli device wifi list')},
        )

    def battery(self):
        return widget.Battery(
            **widget_base(bg=Colors.violet, fg=Colors.background),
            charge_char="󰂄",
            full_char="󱟢",
            discharge_char="󰁽",
            empty_char="󰂎",
            unknown_char="?",
            format='{percent:2.0%} {char}',
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

    def create_image_widgets(self):
        image_widgets = []
        for filename, command in apps_data:
            image_widget = widget.Image(
                background=Colors.background,
                filename=filename,
                margin=5,
                padding=0,
                mouse_callbacks={'Button1': lazy.spawn(command)},
            )
            image_widgets.append(image_widget)

        return image_widgets

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
            mouse_callbacks={'Button1': lazy.spawn('eww -c /home/dcr/.config/eww open powermenu --toggle --duration 5s')},
            text="󰐥",
        )


extension_defaults = widget_defaults.copy()
