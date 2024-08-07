
import os
from libqtile.config import Screen 
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy

colors =  [
        ["#292d3e", "#292d3e"], # color 0
        ["#A8A8A8", "#A8A8A8"], # color 1
        ["#f99db3", "#f99db3"], # color 2
        ["#B9BCDF", "#B9BCDF"], # color 3
        ["#F98DA6", "#F98DA6"], # color 4
        ["#ffffff", "#ffffff"], # color 5
        ["#C7CAEF", "#C7CAEF"], # color 6
        ["#F9A9BC", "#F9A9BC"], # color 7
        ["#b79feb", "#b79feb"], # color 8
        ["#bbebca", "#bbebca"], # color 9
        ["#DCDEFC"], # color 10
        ["#66B2FF"]] # color 11 


xx=15
xf="space mono for powerline bold"
default=[
    widget.Sep(
        padding=5,
        linewidth=0,
        background=colors[0],
    ),
    # widget.CurrentLayoutIcon(
    #     custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
    #     scale=0.45,
    #     padding=0,
    #     background=colors[0],
    # ),
    widget.TextBox(
        mouse_callbacks={'Button1': lazy.spawn('rofi -show drun -theme ~/.config/rofi/Launcher.rasi')},
        foreground=colors[11],
        fontsize=18,
        padding=10,
        text="",
    ),
    widget.TextBox(
        text='|',
        padding=5,
        background=colors[0],
        foreground=colors[5],
    ),
    widget.GroupBox(
        font=xf,
        fontsize=xx,
        margin_y=4,
        margin_x=4,
        padding_y=5,
        padding_x=3,
        borderwidth=7,
        inactive=colors[6],
        active=colors[4],
        rounded=True,
        highlight_color=colors[0],
        highlight_method="block",
        this_current_screen_border=colors[6],
        block_highlight_text_color=colors[0],
    ),
    widget.Prompt(
        background=colors[8],
        foreground=colors[0],
        font=xf,
        fontsize=xx,
    ),


    widget.Chord(
        chords_colors={
            'launch': ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),

    widget.TextBox(
        text='|',
        padding=0,
        background=colors[0],
        foreground=colors[5],
    ),

    widget.WindowName(
        font=xf,
        fontsize=13,
    ),

    widget.Spacer(),

    widget.Sep(
        padding=6,
        linewidth=0,
        background=colors[0],
    ),
    widget.Systray(
        background=colors[0],
        icons_size=20,
        padding=4,
    ),
    widget.Sep(
        padding=8,
        linewidth=0,
        background=colors[0],
    ),
    widget.TextBox(
        text='\ue0be',
        fontsize='43',
        font='space mono for powerline',
        padding=0,
        background=colors[0],
        foreground=colors[10],
    ),
    widget.Sep(
        padding=4,
        linewidth=0,
        background=colors[10],
    ),
    widget.TextBox(
        text=" ",
        foreground=colors[0],
        background=colors[10],
        padding=0,
        fontsize=18
    ),
    widget.Memory(
        background=colors[10],
        foreground=colors[0],
        font=xf,
        fontsize=xx,
        measure_mem='G',
        format='{MemUsed: .2f} GB'
    ),
    widget.TextBox(
        text='\ue0be',
        fontsize='43',
        font='space mono for powerline',
        padding=0,
        background=colors[10],
        foreground=colors[6],
    ),
    widget.Sep(
        padding=8,
        linewidth=0,
        background=colors[6],
    ),
    widget.TextBox(
        text="",
        foreground=colors[0],
        background=colors[6],
        padding=0,
        fontsize=18
    ),
    widget.Memory(
        background=colors[6],
        foreground=colors[0],
        font=xf,
        fontsize=xx,
        measure_swap='G',
        format='{SwapUsed: .2f} GB'
    ),
    widget.Sep(
        padding=8,
        linewidth=0,
        background=colors[6],
    ),
    widget.TextBox(
        text='\ue0be',
        fontsize='43',
        padding=0,
        foreground=colors[3],
        background=colors[6],
    ),
    widget.Sep(
        padding=8,
        linewidth=0,
        background=colors[3],
    ),
    widget.TextBox(
        text=" ",
        font="novamono for powerline bold",
        foreground=colors[0],
        background=colors[3],
        padding=0,
        fontsize=22
    ),
    widget.CPU(
        background=colors[3],
        foreground=colors[0],
        font=xf,
        fontsize=xx,
        format='CPU: {load_percent}%'
    ),
    widget.Sep(
        padding=8,
        linewidth=0,
        background=colors[3],
    ),
    widget.TextBox(
        text='\ue0be',
        fontsize='43',
        padding=0,
        background=colors[3],
        foreground=colors[9],
    ),
    widget.PulseVolume(
        background=colors[9],
        foreground=colors[0],
        font=xf,
        fontsize=xx,
        mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
        update_interval=0
    ),
    # widget.Sep(
    #     padding=10,
    #     linewidth=0,
    #     background=colors[9],
    # ),
    widget.TextBox(
        text='\ue0be',
        fontsize='43',
        padding=0,
        background=colors[9],
        foreground=colors[7],
    ),
    widget.Sep(
        padding=6,
        linewidth=0,
        background=colors[7],
    ),
    widget.TextBox(
        text=' ',
        font="icomoon-feather",
        fontsize=18,
        padding=0,
        background=colors[7],
        foreground=colors[0],
    ),
    widget.Clock(
        font=xf,
        fontsize=xx,
        foreground=colors[0],
        background=colors[7],
        format='%d %b, %A',
    ),
    widget.Sep(
        padding=6,
        linewidth=0,
        background=colors[7],
    ),
    widget.TextBox(
        text='\ue0be',
        fontsize='43',
        padding=0,
        background=colors[7],
        foreground=colors[2],
    ),
    widget.Sep(
        padding=2,
        linewidth=0,
        background=colors[2],
    ),
    widget.TextBox(
        text=' ',
        fontsize=18,
        padding=0,
        background=colors[2],
        foreground=colors[0],
    ),
    widget.Clock(
        font=xf,
        fontsize=xx,
        foreground=colors[0],
        background=colors[2],
        format='%I:%M %p'
    ),
    widget.Sep(
        padding=6,
        linewidth=0,
        background=colors[2],
    ),
    widget.TextBox(
        text='\ue0be',
        fontsize='43',
        padding=0,
        background=colors[2],
        foreground=colors[4],
    ),
    widget.Sep(
        padding=0,
        linewidth=0,
        background=colors[4],
    ),
]

if len(os.listdir("/sys/class/power_supply"))==0:
    default.append(
        widget.CapsNumLockIndicator(
            fontsize=xx,
            font=xf,
            foreground=colors[0],
            background=colors[4],
        )
    )
else:
    default.append(
        widget.Battery(
            fontsize=xx,
            font=xf,
            foreground=colors[0],
            low_percentage=0.3,
            low_background="#0ee9af",
            background=colors[4],
            low_foreground=colors[0],
            update_interval=1,
            charge_char='',
            discharge_char='',
            format=' {char} {percent:2.0%} ',
        ),
    )

screens = [
    Screen(
        top=bar.Bar(
            default,
            30,
            background=colors[0],
            foreground=colors[1],
            margin=[20, 20, 0, 20],
            # margin=[4,6,8,6],
        ),
    ),
]
