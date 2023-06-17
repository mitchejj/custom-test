#!/bin/sh

set -ouex pipefail

echo "adding usbmuxd user/group"
groupadd -r usbmuxd -g 113
useradd -r -g usbmuxd -d / -s /sbin/nologin \
	-c "usbmuxd user" -u 113 usbmuxd

#systemctl enable usbmuxd.service
