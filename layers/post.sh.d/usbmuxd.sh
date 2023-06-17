#!/bin/sh

set -ouex pipefail

getent group usbmuxd >/dev/null || groupadd -r usbmuxd -g 113
getent passwd usbmuxd >/dev/null || \
useradd -r -g usbmuxd -d / -s /sbin/nologin \
	-c "usbmuxd user" -u 113 usbmuxd

systemctl enable usbmuxd.service
