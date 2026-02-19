#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    libdecor \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ! llvm

# Comment this out if you need an AUR package
if [ "${DEVEL_RELEASE-}" = 1 ]; then
	package=nestopia-git
else
	package=nestopia
fi
make-aur-package "$package"
pacman -Q "$package" | awk '{print $2; exit}' > ~/version
