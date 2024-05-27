# Quarks

Base |
[![bunsen-builder](https://github.com/mitchejj/ostree-quarks/actions/workflows/sway-build.yml/badge.svg)](https://github.com/mitchejj/ostree-quarks/actions/workflows/sway-build.yml)
|
[![beaker-builder](https://github.com/mitchejj/ostree-quarks/actions/workflows/ng-build.yml/badge.svg)](https://github.com/mitchejj/ostree-quarks/actions/workflows/ng-build.yml)

In the spring of 2023, I became enamored with what would become Fedora Atomic
and Universal Blue; which would utilizes a composable build system. The
foundation of the principles for my builds was inspired by Universal Blue at the
time. At the time, I felt the Fedora Atomic was better naming scheme, so I
decided to hedge my bets and go with the quarks name for my build project. The
end result is a simple system system tailored to my expectations, needs and
wants.

## Images

Three images are ~~produced~~ planned:

And the builds are scheduled to start at 9:45 UTC, here is a
[UTC Clock](https://time.is/UTC).

### quark-common

This is the common base image built ontop
[fedora-ostree-desktops/base](https://quay.io/repository/fedora-ostree-desktops/base?tab=tags&tag=latest).
The quark-comman image is the used as the base of the hypr and sway images.

The purpose of having a common base image is twofold:

    - Most of the 'quark' changes exist inside this common image. Using a common base image reduces the aggerated CPU time spent on duplicated work.

    - The initial motivation for this approach was to mitigate issues when
      proving the good hardware drivers, `mesa-vdpau-drivers-freeworld` & `intel-media-driver`, due to conflits with the `mesa-filesystems`. This image still allows for a up-to-date compositor.

However, this approach has a drawback:

- If a conflict exists for a few days and a common package is updated, the new
  version of the common package will be held back until the conflict with mesa
  is resolved. The base image exists mostly because it provides a bridge when
  certain packages (like mesa) have conflicts between Fedora and RPM Fusion.

##### quark changes

Some of the highlights provided in the common image:

- Remove -guest VM support
- Added
  - mesa hardware codes (AMD & Intel)
  - iOS support (libmobiledevices)
  - Tailscale
  - cockpit
  - git (and GitHub CLI client)
  - zellij
  - Fonts - fira-code - google-noto - ibm-plex - jetbrains-mono - mozilla-fira -
    nerd-fots - powerline-fonts

### hypr (hyprland)

This is a Hyprland build and receives the most focus as it receives more
frequent releases and is what I use daily.

I offer two builds stable and rawhide. The Hyprland support is provided via
[copr:solopasha/hyprland](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/)
([git repo](https://github.com/solopasha/hyprlandRPM)); rawhide builds also
contain hyprland-git.

#### Similar

- [Hyprgreen](https://github.com/hyprgreen/main)

### sway

** **SWAY BUILDS ARE NOT ENABLED YET** **

Built twice a week (Tuesday and
Friday); the sway image is fairly basic, quark-common with sway. When I first
started the quarks build this was my daily driver. I keep the build around
in case I need to mover of Hyprland.

### zfs

[![build-zfs-kmods](https://github.com/mitchejj/ostree-zfs-kmod/actions/workflows/build.yml/badge.svg)](https://github.com/mitchejj/ostree-zfs-kmod/actions/workflows/build.yml)

Both have hypr and sway have an 'extended' build with zfs support denoted with
\*-zed.

ZFS support is only built against the latest stable Fedora release.

Due to ongoing issues with integration between the Linux kernel and zfs
sometimes the zfs version may not always be up-to-date.

The default mountpoint for a newly created zpool `tank` is `/tank` since the
root filesystem is immutable the directory cannot be created. A new mount point
needs to be selected. I would suggest `/mnt/tank`

## IMPORTANT CHANGES

When Feodra updates to a new stable version I will continue to build the the
prior (stable -1) version for roughly a month after release.

I've decided with the release of F40 I will scale the Sway (Bunsen) build to a I
am also thinking about changing the images names back to a sane naming scheme
with the name of the compositor in the title.

## How to use these:

Rebase from an existing Fedora Atomic Desktop

#### Hyprland

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/hypr:40

or

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/hypr-zed:40

#### Sway

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/sway:40

or

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/sway-zed:40

## Other

[Fedora Atomic Desktop Cheat Sheet](https://docs.fedoraproject.org/en-US/fedora-silverblue/_attachments/silverblue-cheatsheet.pdf)

## Verification

These images are signed with sisgstore's
[cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the
signature by downloading the `cosign.pub` key from this repo and running the
following command:

    cosign verify --key cosign.pub ghcr.io/mitchejj/<image name>
