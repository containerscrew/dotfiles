import subprocess
import netifaces as ni
import requests
from libqtile.config import Screen
from libqtile import bar, widget
from libqtile.lazy import lazy
from .colors import Colors


xx = 16
xf = "space mono for powerline bold"


def diagonal_sep(fg: str, bg: str):
    return widget.TextBox(
        text="\ue0be",
        fontsize="43",
        font="space mono for powerline",
        padding=0,
        background=bg,
        foreground=fg,
    )


# Wlan interface
wlan_interface = None

# Get the name of the wlan interface
interfaces = ni.interfaces()
for iface in interfaces:
    if iface.startswith("wl"):
        wlan_interface = iface
        break


# Get public ipv4
def get_public_ip_and_country():
    try:
        ip = requests.get("https://ifconfig.co/ip").text.strip()
        country = requests.get("https://ifconfig.co/country").text.strip()
        return f"Connected to {ip} ({country})"
    except Exception:
        return "Error"


def send_notification(message):
    icon_path = "/usr/share/icons/Papirus-Dark/16x16/actions/network-disconnect.svg"
    subprocess.run(["dunstify", "-i", icon_path, "Public IP", message])


default = [
    widget.Sep(
        padding=5,
        linewidth=0,
        background=Colors.background,
    ),
    widget.TextBox(
        mouse_callbacks={
            "Button1": lazy.spawn("rofi -show drun -theme ~/.config/rofi/Launcher.rasi")
        },
        foreground=Colors.blue,
        fontsize=20,
        padding=10,
        text="",
    ),
    widget.TextBox(
        text="|",
        padding=5,
        background=Colors.background,
        foreground=Colors.foreground,
    ),
    widget.GroupBox(
        font=xf,
        fontsize=xx,
        margin_x=0,
        padding=10,
        borderwidth=3,
        inactive=Colors.lightblue,
        active=Colors.darkviolet,
        rounded=True,
        center_aligned=True,
        highlight_color=Colors.white,
        highlight_method="line",
        this_current_screen_border=Colors.hotpink,
        block_highlight_text_color=Colors.hotpink,
    ),
    widget.TextBox(
        text="|",
        padding=0,
        background=Colors.background,
        foreground=Colors.foreground,
    ),
    widget.WindowName(font=xf, fontsize=13, max_chars=40, fontshadow=Colors.darkviolet),
    widget.Spacer(),
    diagonal_sep(fg=Colors.blue, bg=Colors.background),
    widget.Clock(
        font=xf,
        fontsize=xx,
        foreground=Colors.background,
        background=Colors.blue,
        # format='%I:%M %p %d %b, %A'
        format="%H:%M %A, %d %b",
    ),
    diagonal_sep(fg=Colors.background, bg=Colors.blue),
    widget.Spacer(),
    widget.NvidiaSensors(
        format="GPU {temp} °C",
        font=xf,
        fontsize=xx,
        foreground=Colors.white,
    ),
    diagonal_sep(fg=Colors.pink, bg=Colors.background),
    widget.DoNotDisturb(
        disabled_icon="󰂚",
        enabled_icon="󰂛",
        background=Colors.pink,
        foreground=Colors.black,
        font=xf,
        fontsize=xx,
    ),
    diagonal_sep(fg=Colors.lightblue, bg=Colors.pink),
    widget.Memory(
        background=Colors.lightblue,
        foreground=Colors.black,
        font=xf,
        fontsize=xx,
        measure_mem="G",
        format=" {MemFree: .2f} GB",
    ),
    diagonal_sep(fg=Colors.violet, bg=Colors.lightblue),
    widget.CPU(
        background=Colors.violet,
        foreground=Colors.black,
        font=xf,
        fontsize=xx,
        format="   {load_percent} %",
    ),
    diagonal_sep(fg=Colors.lightblue, bg=Colors.violet),
    widget.WidgetBox(
        font=xf,
        fontsize=xx,
        text_closed="",
        text_open="",
        foreground=Colors.background,
        background=Colors.lightblue,
        padding=10,
        widgets=[
            widget.TextBox(
                foreground=Colors.background,
                background=Colors.lightblue,
                text="🌐",
                font=xf,
                fontsize=xx,
                mouse_callbacks={
                    "Button1": lazy.function(
                        lambda qtile: send_notification(get_public_ip_and_country())
                    )
                },
            ),
            widget.Wlan(
                foreground=Colors.background,
                background=Colors.lightblue,
                format="{essid} {percent:2.0%}",
                interface=wlan_interface,
                font=xf,
                fontsize=xx,
            ),
        ],
    ),
    diagonal_sep(fg=Colors.pink, bg=Colors.lightblue),
    widget.WidgetBox(
        font=xf,
        fontsize=xx,
        text_closed="",
        text_open="",
        foreground=Colors.background,
        background=Colors.pink,
        padding=10,
        widgets=[
            widget.Bluetooth(
                foreground=Colors.background,
                background=Colors.pink,
                font=xf,
                fontsize=xx,
                default_text="{connected_devices}",
                mouse_callbacks={"Button1": lazy.spawn("blueman-manager")},
                text="󰂯",
            ),
        ],
    ),
    diagonal_sep(fg=Colors.lightblue, bg=Colors.pink),
    widget.PulseVolume(
        background=Colors.lightblue,
        foreground=Colors.background,
        emoji=True,
        font=xf,
        fontsize=xx,
        emoji_list=["", "", "", ""],
        # mouse_callbacks={'Button1': lazy.spawn('pavucontrol')},
    ),
    diagonal_sep(fg=Colors.violet, bg=Colors.lightblue),
    widget.Battery(
        background=Colors.violet,
        foreground=Colors.black,
        padding=10,
        font=xf,
        fontsize=xx,
        charge_char="󰂄",
        full_char="󱟢",
        discharge_char="󰁽",
        empty_char="󰂎",
        unknown_char="?",
        format="{char}  {percent:2.0%}",
        show_short_text=False,
        hide_crash=True,
        low_foreground=Colors.red,
        update_interval=1,
    ),
    widget.TextBox(
        background=Colors.black,
        foreground=Colors.red,
        font=xf,
        padding=10,
        fontsize=xx,
        mouse_callbacks={
            "Button1": lazy.spawn(
                "eww -c /home/dcr/.config/eww open powermenu --toggle --duration 5s"
            )
        },
        text="󰐥",
    ),
]

screens = [
    Screen(
        top=bar.Bar(
            default,
            30,
            background=Colors.background,
            foreground=Colors.foreground,
            margin=[5, 10, 0, 10],
        ),
    ),
]
