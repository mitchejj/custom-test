#!/bin/sh

set -ouex pipefail


KERNEL="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
RELEASE="$(rpm -q kernel --queryformat '-%{RELEASE}')"
ls -lah /tmp/zfs
rpm-ostree install /tmp/zfs/*${KERNEL}.rpm
depmod -A ${KERNEL}
