#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
INCLUDED_PACKAGES=($(jq -r "[(.all.include | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".include | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /tmp/packages.json))
EXCLUDED_PACKAGES=($(jq -r "[(.all.exclude | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[]), \
                             (select(.\"$FEDORA_MAJOR_VERSION\" != null).\"$FEDORA_MAJOR_VERSION\".exclude | (.all, select(.\"$IMAGE_NAME\" != null).\"$IMAGE_NAME\")[])] \
                             | sort | unique[]" /tmp/packages.json))


if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    EXCLUDED_PACKAGES=($(rpm -qa --queryformat='%{NAME} ' ${EXCLUDED_PACKAGES[@]}))
fi

# wget -P /tmp/rpms \
#     https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm \
#     https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASE}.noarch.rpm

cd /etc/yum.repos.d/ && curl -LO https://pkgs.tailscale.com/stable/fedora/tailscale.repo
cd /etc/yum.repos.d/ && curl -LO https://cli.github.com/packages/rpm/gh-cli.repo 
cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/atim/bottom/repo/fedora-$(rpm -E %fedora)/atim-bottom-fedora-$(rpm -E %fedora).repo

## Hyprland related
cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/repo/fedora-$(rpm -E %fedora)/solopasha-hyprland-fedora-$(rpm -E %fedora).repo
cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/axeld/eww/repo/fedora-38/axeld-eww-fedora-$(rpm -E %fedora).repo

if [[ "${#INCLUDED_PACKAGES[@]}" -gt 0 && "${#EXCLUDED_PACKAGES[@]}" -eq 0 ]]; then
    rpm-ostree install \
        ${INCLUDED_PACKAGES[@]}


elif [[ "${#INCLUDED_PACKAGES[@]}" -eq 0 && "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    rpm-ostree override remove \
        ${EXCLUDED_PACKAGES[@]}

elif [[ "${#INCLUDED_PACKAGES[@]}" -gt 0 && "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    rpm-ostree override remove \
        ${EXCLUDED_PACKAGES[@]} \
        $(printf -- "--install=%s " ${INCLUDED_PACKAGES[@]})

else
    echo "No packages to install."
fi

###
ls /tmp
# if [[ "$RELEASE" -eq 37 ]] ; then
# #   # wget -P /tmp/rpms \
# #   #   https://zfsonlinux.org/fedora/zfs-release-2-2$(rpm --eval "%{dist}").noarch.rpm
#   ls -lah /tmp/f37/
#   rpm-ostree install /tmp/f37/*.rpm 
# elif if [[ "$RELEASE" -eq 38 &&  ]] ; then
#   ls -lah /tmp/f38/
#   rpm-ostree install /tmp/f38/*.rpm 
# fi


if [[ "$IMAGE_NAME" == 'base-main' ]] ; then
  if [[ -d /tmp/f"$RELEASE" ]]; then
    ls -lah /tmp/f"$RELEASE"
    rpm-ostree install /tmp/f"$RELEASE"/*.rpm
  else
    ls -lah /tmp
    echo "no zfs"
  fi
elif [[ "$IMAGE_NAME" == 'sericea-main' ]] ; then
  echo 'we have sericea, no zfs needed'
else
  echo 'We have?....'
  echo $IMAGE_NAME

fi

systemctl enable sshd.socket
systemctl enable tailscaled.service
timedatectl set-ntp true
# systemctl disable bolt.service
# systemctl disable mdmonitor.service
# systemctl disable fprintd.service
# systemctl disable iscsid.socket
# systemctl disable raid-check.timer
# systemctl disable iscsi-starter
# systemctl disable iscsi-onboot.service
