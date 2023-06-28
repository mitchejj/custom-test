#!/bin/sh

set -ouex pipefail

systemctl enable flatpak-system-update.timer 
systemctl enable remote-fs.target
systemctl enable rpm-ostreed-automatic.timer
systemctl enable sshd.service
systemctl enable systemd-timesyncd.service
fc-cache -f /usr/share/fonts

#/tmp/post.sh.d/usbmuxd.sh
rm -rf /var/*
rm -rf /tmp/*
