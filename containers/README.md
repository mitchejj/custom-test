# Main
[![bunsen-builder](https://github.com/mitchejj/custom-test/actions/workflows/sway-build.yml/badge.svg)](https://github.com/mitchejj/custom-test/actions/workflows/sway-build.yml)

YA custom Fedora operating system using [OCI/Docker containers as a transport and delivery mechanism](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStabley). Images are rebuit nightly at UTC: 23:45 (https://time.is/UTC)

## What is this?

My first Linux system that I enjoyed using was CrunchBang Linux, this is what eventually made me switch to linux full time. One of the 'fun' aspects of the distro was using Muppet characters as release names. Using [uBlue](http://github.com/uble-os/main) [sericea][ublue-sericea] Bunsen is my layering of features. Eventually I plan on also using [base][ublue-base]) to build a [Hyprland](https://hyprland.org/) version, Beaker, that I can play around with.

Both have a \*-zed option for built in zfs. Due to ongoing issues with intergration between the Linux kernel and zfs sometimes the zfs version may not always be up-to-date.

[ublue-sericea]: https://github.com/ublue-os/main/pkgs/container/base-sericea
[ublue-base]: https://github.com/ublue-os/main/pkgs/container/base-main


## Features

- Finish with my quarks
  - Remove guest VM support
  - Tailscale
  - NeoVim
  - git
  - tmux
  - vifm
  - Fonts (powerline-fonts, mozilla-fira, fira-code, google-noto, ibm-plex, jetbrains-mono)

## How to use these:


To rebase an existing Silverblue/Kinoite machine to the latest release (37): 
1. Download and install [Fedora Silverblue](https://silverblue.fedoraproject.org/download)
1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback.
1. Open a terminal and use one of the following commands to rebase the OS:

    
#### Bunsen (Sway derived from Sericea)  
Fedora 38-only, recommended only for advanced users

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/bunsen:38

or
    
    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/bunsen-zed:38


#### Beaker (Hyprland derived from Base)


    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mitchejj/beaker:38

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/ublue-os/base

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions.

