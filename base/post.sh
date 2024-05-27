#!/bin/sh

set -ouex pipefail

systemctl enable flatpak-system-update.timer 
systemctl enable remote-fs.target

sed -i 's|^#AutomaticUpdatePolicy=none|AutomaticUpdatePolicy=stage|' /etc/rpm-ostreed.conf
#sed -i 's/^#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/'/etc/rpm-ostreed.conf
systemctl enable rpm-ostreed-automatic.timer
systemctl enable sshd.service
systemctl enable systemd-timesyncd.service
fc-cache -f /usr/share/fonts

rm -rf /var/*
rm -rf /tmp/*
