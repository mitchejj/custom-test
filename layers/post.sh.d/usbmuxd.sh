#!/bin/sh

set -ouex pipefail

echo "adding usbmuxd user/group"
useradd -r -d / -s /sbin/nologin -c "usbmuxd user" -u 113 usbmuxd

systemctl enable usbmuxd.service
