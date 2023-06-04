#!/bin/sh

set -ouex pipefail

systemctl enable --now sshd.socket
systemctl enable systemd-timesyncd.service
