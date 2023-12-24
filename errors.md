# Go proxy dns error

Trying to execute: go mod tidy

lookup golang.org on [::1]:53: read udp [::1]:42796->[::1]:53: read: connection refused

That's why my private vpn and systemd-resolved, set the file /etc/resolv.conf to nameserver ::1