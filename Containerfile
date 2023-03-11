ARG IMAGE_NAME="${IMAGE_NAME:-base-main-custom}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-base-main}"
ARG BASE_IMAGE="ghcr.io/ublue-os/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-37}"
ARG ZFS_KMODS_SOURCE="ghcr.io/mitchejj/zfs-kmods"

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} AS builder

ARG IMAGE_NAME="${IMAGE_NAME}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"

ADD build.sh /tmp/build.sh
# ADD post-install.sh /tmp/post-install.sh
ADD packages.json /tmp/packages.json

COPY --from=${ZFS_KMODS_SOURCE}:${FEDORA_MAJOR_VERSION} /*.rpm /tmp/

RUN /tmp/build.sh
# RUN /tmp/post-install.sh
RUN rm -rf /tmp/* /var/*
RUN ostree container commit
RUN mkdir -p /var/tmp && chmod -R 1777 /var/tmp
