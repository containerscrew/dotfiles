
import os
from libqtile.config import Screen 
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from .colors import Colors


xx=15
xf="space mono for powerline bold"

default=[
    widget.Sep(
        padding=5,
        linewidth=0,
        background=Colors.background,
    ),
    widget.TextBox(
        mouse_callbacks={'Button1': lazy.spawn('rofi -show drun -theme ~/.config/rofi/Launcher.rasi')},
        foreground=Colors.blue,
        fontsize=18,
        padding=10,
        text="",
    ),
    widget.TextBox(
        text='|',
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
        highlight_color=Colors.white,
        highlight_method="line",
        this_current_screen_border=Colors.hotpink,
        block_highlight_text_color=Colors.hotpink,
    ),
    widget.TextBox(
        text='|',
        padding=0,
        background=Colors.background,
        foreground=Colors.foreground,
    ),
    widget.WindowName(
        font=xf,
        fontsize=13,
        max_chars=40,
        fontshadow=Colors.darkviolet
    ),
]
#     widget.Spacer(),

#     widget.Sep(
#         padding=6,
#         linewidth=0,
#         background=colors[0],
#     ),
#     widget.Systray(
#         background=colors[0],
#         icons_size=20,
#         padding=4,
#     ),
#     widget.Sep(
#         padding=8,
#         linewidth=0,
#         background=colors[0],
#     ),
#     widget.TextBox(
#         text='\ue0be',
#         fontsize='43',
#         font='space mono for powerline',
#         padding=0,
#         background=colors[0],
#         foreground=colors[10],
#     ),
#     widget.Sep(
#         padding=4,
#         linewidth=0,
#         background=colors[10],
#     ),
#     widget.TextBox(
#         text=" ",
#         foreground=colors[0],
#         background=colors[10],
#         padding=0,
#         fontsize=18
#     ),
#     widget.Memory(
#         background=colors[10],
#         foreground=colors[0],
#         font=xf,
#         fontsize=xx,
#         measure_mem='G',
#         format='{MemUsed: .2f} GB'
#     ),
#     widget.TextBox(
#         text='\ue0be',
#         fontsize='43',
#         font='space mono for powerline',
#         padding=0,
#         background=colors[10],
#         foreground=colors[6],
#     ),
#     widget.Sep(
#         padding=8,
#         linewidth=0,
#         background=colors[6],
#     ),
#     widget.TextBox(
#         text="",
#         foreground=colors[0],
#         background=colors[6],
#         padding=0,
#         fontsize=18
#     ),
#     widget.Memory(
#         background=colors[6],
#         foreground=colors[0],
#         font=xf,
#         fontsize=xx,
#         measure_swap='G',
#         format='{SwapUsed: .2f} GB'
#     ),
#     widget.Sep(
#         padding=8,
#         linewidth=0,
#         background=colors[6],
#     ),
#     widget.TextBox(
#         text='\ue0be',
#         fontsize='43',
#         padding=0,
#         foreground=colors[3],
#         background=colors[6],
#     ),
#     widget.Sep(
#         padding=8,
#         linewidth=0,
#         background=colors[3],
#     ),
#     widget.TextBox(
#         text='\ue0be',
#         fontsize='43',
#         padding=0,
#         background=colors[3],
#         foreground=colors[9],
#     ),
#     widget.PulseVolume(
#         background=colors[9],
#         foreground=colors[0],
#         font=xf,
#         fontsize=xx,
#         mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
#         update_interval=0
#     ),
#     # widget.Sep(
#     #     padding=10,
#     #     linewidth=0,
#     #     background=colors[9],
#     # ),
#     widget.TextBox(
#         text='\ue0be',
#         fontsize='43',
#         padding=0,
#         background=colors[9],
#         foreground=colors[7],
#     ),
#     widget.Sep(
#         padding=6,
#         linewidth=0,
#         background=colors[7],
#     ),
#     widget.TextBox(
#         text=' ',
#         font="icomoon-feather",
#         fontsize=18,
#         padding=0,
#         background=colors[7],
#         foreground=colors[0],
#     ),
#     widget.Clock(
#         font=xf,
#         fontsize=xx,
#         foreground=colors[0],
#         background=colors[7],
#         format='%d %b, %A',
#     ),
#     widget.Sep(
#         padding=6,
#         linewidth=0,
#         background=colors[7],
#     ),
#     widget.TextBox(
#         text='\ue0be',
#         fontsize='43',
#         padding=0,
#         background=colors[7],
#         foreground=colors[2],
#     ),
#     widget.Sep(
#         padding=2,
#         linewidth=0,
#         background=colors[2],
#     ),
#     widget.TextBox(
#         text=' ',
#         fontsize=18,
#         padding=0,
#         background=colors[2],
#         foreground=colors[0],
#     ),
#     widget.Clock(
#         font=xf,
#         fontsize=xx,
#         foreground=colors[0],
#         background=colors[2],
#         format='%I:%M %p'
#     ),
#     widget.Sep(
#         padding=6,
#         linewidth=0,
#         background=colors[2],
#     ),
#     widget.TextBox(
#         text='\ue0be',
#         fontsize='43',
#         padding=0,
#         background=colors[2],
#         foreground=colors[4],
#     ),
#     widget.Sep(
#         padding=0,
#         linewidth=0,
#         background=colors[4],
#     ),
# ]

# if len(os.listdir("/sys/class/power_supply"))==0:
#     default.append(
#         widget.CapsNumLockIndicator(
#             fontsize=xx,
#             font=xf,
#             foreground=colors[0],
#             background=colors[4],
#         )
#     )
# else:
#     default.append(
#         widget.Battery(
#             fontsize=xx,
#             font=xf,
#             foreground=colors[0],
#             low_percentage=0.3,
#             low_background="#0ee9af",
#             background=colors[8],
#             low_foreground=colors[0],
#             show_short_text=False,
#             update_interval=1,
#             charge_char="󰂄",
#             full_char="󱟢",
#             discharge_char="󰁽",
#             empty_char="󰂎",
#             unknown_char="?",
#             format=' {char} {percent:2.0%} ',
#         )
#     )

screens = [
    Screen(
        top=bar.Bar(
            default,
            40,
            background=colors[0],
            foreground=colors[1],
            margin=[5, 10, 0, 10],
        ),
    ),
]
