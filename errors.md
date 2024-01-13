<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Go proxy dns error](#go-proxy-dns-error)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Go proxy dns error

Trying to execute: go mod tidy

lookup golang.org on [::1]:53: read udp [::1]:42796->[::1]:53: read: connection refused

That's why my private vpn and systemd-resolved, set the file /etc/resolv.conf to nameserver ::1
