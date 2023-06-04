#!/bin/sh

set -ouex pipefail

# enable tty1
systemctl enable getty@tty1.service

