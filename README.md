# Main
[![bunsen-builder](https://github.com/mitchejj/ostree-quarks/actions/workflows/sway-build.yml/badge.svg)](https://github.com/mitchejj/ostree-quarks/actions/workflows/sway-build.yml)
[![beaker-builder](https://github.com/mitchejj/ostree-quarks/actions/workflows/ng-build.yml/badge.svg)](https://github.com/mitchejj/ostree-quarks/actions/workflows/ng-build.yml)

YA custom Fedora operating system using [OCI/Docker containers as a transport and delivery mechanism](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStabley). Images are scheduled to build daily at 9:45 UTC, here is a [UTC Clock](https://time.is/UTC).

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

### Hyprland (beaker build)
[![Copr build status](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/package/hyprland/status_image/last_build.png)]

The beaker build is offered up two versions, current Fedora stable (F39) and rawhide. The packages providing Hyprland support come from [copr:solopasha/hyprland](https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/) ([git repo](https://github.com/solopasha/hyprlandRPM)); additionally the rawhide build using hyprland-git.

(https://copr.fedorainfracloud.org/coprs/solopasha/hyprland/package/
[solopasha/hyprlandRPM](https://github.com/solopasha/hyprlandRPM)

## How to use these:

To rebase an existing Silverblue/Kinoite/Sericea machine to the latest release (38): 
1. Download and install [Fedora Silverblue](https://silverblue.fedoraproject.org/download)
1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback.
1. Open a terminal and use one of the following commands to rebase the OS:

    
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

Due to ongoing issues with intergration between the Linux kernel and zfs sometimes the zfs version may not always be up-to-date.

The default mountpoint for a newly created zpool `tank` is `/tank` since the root filesystem is immutable the directory cannot be created. A new mount point needs to be selected. I would suggest `/mnt/tank`

## Similar
[Hyprgreen](https://github.com/hyprgreen/main)
## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/mitchejj/<image name>

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions.

