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

# cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/atim/bottom/repo/fedora-$(rpm -E %fedora)/atim-bottom-fedora-$(rpm -E %fedora).repo
cd /etc/yum.repos.d/ && curl -LO https://pkgs.tailscale.com/stable/fedora/tailscale.repo
cd /etc/yum.repos.d/ && curl -LO https://cli.github.com/packages/rpm/gh-cli.repo 

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

if [[ -d /tmp/"$RELEASE" ]]; then
  ls -lah /tmp/"$RELEASE"
  rmp-ostree install /tmp/"$RELEASE"/*.rpm
else
  ls -lah /tmp
  echo "no zfs"
fi


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

systemctl enable sshd.socket
systemctl enable tailscaled.service
