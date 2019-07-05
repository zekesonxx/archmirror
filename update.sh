#!/usr/bin/env bash
# archmirror v0.0.0
# https://github.com/zekesonxx

run_pacman() {
	fakeroot pacman --config ./pacman.conf --noconfirm "$@"
}

run_powerpill() {
	fakeroot powerpill --powerpill-config ./powerpill.json \
		--config ./pacman.conf --noconfirm $@
}

check_cmd() {
	if hash "$1" 2>>/dev/null; then
		echo "$1 available";
	else
		echo "$1 not found, exiting";
		exit 1
	fi
}
echo "# Checking for available programs..."
check_cmd fakeroot
check_cmd aria2c
check_cmd rsync
check_cmd pacman
check_cmd powerpill
check_cmd paccache

echo "# Generating package list..."
mkdir -p ./lists
for filename in ./lists/*; do
	echo "$(basename "$filename"): $(wc -l < "$filename") packages";
done
package_list="$(cat ./lists/* | sort -u)"
echo "Generated list with $(echo "$package_list" | wc -l) packages"

echo "# Updating package database..."
mkdir -p ./packages ./pacman/hooks ./pacman/gnupg ./pacman/hooks
run_pacman -Sy

echo "# Downloading updated packages"
run_powerpill --powerpill-clean -Sw "$package_list"

echo "# Pruning duplicate packages"
paccache -c ./packages -rk 1

echo "# Updated!"
