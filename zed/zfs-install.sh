#!/bin/sh

set -ouex pipefail


KERNEL="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"

ls -lah /var
rpm-ostree install /tmp/zfs/*.rpm
depmod -A ${KERNEL}
