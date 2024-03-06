#!/bin/bash

# sudo apt install acpid
#root@dummy:~# cat /etc/acpi/events/lid_close
#event=button/lid LID close
#action=/etc/acpi/autoarange.sh
# systemctl restart acpid
# acpi_listen

#if xrandr | grep -q "connected"; then
#    for monitor in $(xrandr -q | grep -w 'connected' | cut -d' ' -f1); do
#      xrandr XXXX
#    done
#else
#    echo "XXXXXXXXX"
#    exit 1
#fi

#!/bin/bash

sudo -u dcr xrandr -display :0.0 --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-2 --mode 1920x1080 --pos 3840x0 --rotate normal --output DP-3 --off | tee -a >> /tmp/xrandr.log 2>&1