#!/bin/env sh
### Install Nerd Fonts (Symbols Only)

set -ouex pipefail

# ideally /usr/local/share/font*
# for install base

FONT_DIR="/usr/share/fonts/nerd-font"
CONF_DIR="/usr/share/fontconfig/conf.avail"


REPO_URL="https://github.com/ryanoasis/nerd-fonts"
VERSION=3.0.2
REPO_PATH="patched-fonts/NerdFontsSymbolsOnly"
FONTS=(
  "SymbolsNerdFont-Regular.ttf"
  "SymbolsNerdFontMono-Regular.ttf"
)
CONF_URL="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v$VERSION"
CONF_NAME="10-nerd-font-symbols.conf"

for font in ${FONTS[@]} ; do
  URL="$REPO_URL/raw/v$VERSION/$REPO_PATH/$font"
  curl -L $URL --create-dirs -o $FONT_DIR/$font
done

curl -L $CONF_URL/$CONF_NAME -o $CONF_DIR/$CONF_NAME
## TO-DO link 10-nerd-font-symbols.conf into /etc/fonts/conf.d


