# Main

[![build-ublue](https://github.com/ublue-os/main/actions/workflows/build.yml/badge.svg)](https://github.com/ublue-os/main/actions/workflows/build.yml)
YA-spin on the Fedora immutable images; built upon uBlue.

## What is this?

## Features

- Start with a Fedora image (Sericea or Base)
- uBlue adds some extra's: 
  - Hardware acceleration and codecs
  - `distrobox` for terminal CLI
  - A selection of [udev rules and service units](https://github.com/ublue-os/config)
  - Various other tools: check out the [complete list of packages](packages.json)
  - Sets automatic staging of updates for the system
  - Sets flatpaks to update twice a day
- Finish with my quarks
  - Tailscale
  - Tools
  - Fonts
  - Removes VM guest tooling

## How to use these:

Note: If you have an Nvidia GPU use [the ublue-os/nvidia images instead](https://github.com/ublue-os/nvidia)

To rebase an existing Silverblue/Kinoite machine to the latest release (37): 
1. Download and install [Fedora Silverblue](https://silverblue.fedoraproject.org/download)
1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback 
1. Open a terminal and use one of the following commands to rebase the OS:

    
#### Bunsen (Sway derived from Sericea) 
Fedora 38-only, recommended only for advanced users

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/sericea-main:38


#### Beaker (Hyprland derived from Base)

    sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/base-main:37


## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/ublue-os/base

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions.

