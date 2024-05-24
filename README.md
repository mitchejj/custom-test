# Main
[![bunsen-builder](https://github.com/mitchejj/ostree-quarks/actions/workflows/sway-build.yml/badge.svg)](https://github.com/mitchejj/ostree-quarks/actions/workflows/sway-build.yml)
[![beaker-builder](https://github.com/mitchejj/ostree-quarks/actions/workflows/ng-build.yml/badge.svg)](https://github.com/mitchejj/ostree-quarks/actions/workflows/ng-build.yml)

A custom spin on the Fedora Atomic [OCI/Docker](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStabley). Images are scheduled to build at 9:45 UTC, here is a [UTC Clock](https://time.is/UTC).

## What is this?

My first Linux system that I enjoyed using was CrunchBang Linux, this is what eventually made me switch to linux full time. One of the 'fun' aspects of the distro was using Muppet characters as release names. ~~Using [uBlue](http://github.com/uble-os/main) [sericea][ublue-sericea] Bunsen is my layering of features. Eventually I plan on also using [base][ublue-base]) to build a [Hyprland](https://hyprland.org/) version, Beaker, that I can play around with.~~

Both have a \*-zed option for built in zfs. 

[ublue-sericea]: https://github.com/ublue-os/main/pkgs/container/base-sericea
[ublue-base]: https://github.com/ublue-os/main/pkgs/container/base-main


## Features

- Finish with my quarks
  - Remove
    -guest VM support
- Added
  - Tailscale
  - NeoVim
  - git (and GitHub CLI client)
  - tmux
  - vifm
  - Fonts (powerline-fonts, mozilla-fira, fira-code, google-noto, ibm-plex, jetbrains-mono)

## IMPORTANT CHANGES

I've decided with the release of F40 I will scale the Sway (Bunsen) build to a twice a week build, Tuesday and Friday. I am also thinking about changing the images names back to a sane naming scheme with the name of the compositor in the title.

### Hyprland (beaker build)
[![Copr build status](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/package/hyprland/status_image/last_build.png)]

The beaker build is typically offered up two versions, stable and rawhide. The Fedora base is provided via [fedora-ostree-desktops/base](https://quay.io/repository/fedora-ostree-desktops/base?tab=tags&tag=latest) Hyprland support is provided via [copr:solopasha/hyprland](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/) ([git repo](https://github.com/solopasha/hyprlandRPM)); rawhide builds also contain hyprland-git.

#### Similar
[Hyprgreen](https://github.com/hyprgreen/main)

## How to use these:

Rebase from an existing Fedora Atomic Desktop

#### Bunsen (Sway derived from uble-sericea)  

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/bunsen:39

or
    
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/bunsen-zed:39


#### Beaker (Hyprland derived from fedora-ostree-desktops)


    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/beaker:39

or

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/beaker-zed:39


#### ZFS Support
[![build-zfs-kmods](https://github.com/mitchejj/ostree-zfs-kmod/actions/workflows/build.yml/badge.svg)](https://github.com/mitchejj/ostree-zfs-kmod/actions/workflows/build.yml)

ZFS support is only built against the latest stable Fedora release.

Due to ongoing issues with integration between the Linux kernel and zfs sometimes the zfs version may not always be up-to-date.

The default mountpoint for a newly created zpool `tank` is `/tank` since the root filesystem is immutable the directory cannot be created. A new mount point needs to be selected. I would suggest `/mnt/tank`

## Other

[Fedora Atomic Desktop Cheat Sheet](https://docs.fedoraproject.org/en-US/fedora-silverblue/_attachments/silverblue-cheatsheet.pdf)

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/mitchejj/<image name>

