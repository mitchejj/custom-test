ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"
FROM quay.io/fedora-ostree-desktops/base:${FEDORA_MAJOR_VERSION} as common-quarks

COPY --from=ghcr.io/ublue-os/config:latest /rpms/ublue-os-update-services.noarch.rpm /tmp/ublue-os-update-services.noarch.rpm

COPY ./base /tmp

RUN /tmp/build.sh
RUN /tmp/post.sh

RUN ostree container commit

#############################################
###   Start -zed build
###     adding zfs support
#############################################
# FROM common-quarks AS common-quarks-zed

# # ARG IMAGE_NAME="${IMAGE_NAME}"

# COPY --from=ghcr.io/mitchejj/zfs-kmods:39 *.rpm /tmp/zfs/
# COPY ./zed /tmp
# RUN /tmp/zfs-install.sh && \
#   cp /tmp/etc/sysctl.d/*.conf /etc/sysctl.d/

# RUN rm -rf /tmp/* /var/* && \
#     ostree container commit
