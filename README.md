# archmirror

A simple little set of scripts to maintain a partial Arch mirror.

## Synopsis
I want to run my own local Arch mirror, but I don't really want to eat up 42GB syncing the entire package pool.

[pacserve](https://wiki.archlinux.org/index.php/Pacserve) is a simple tool for sharing downloaded Arch Linux packages between computers on the same network.

Pacserve works great, but is an anti-duplication method. It doesn't *pre-emptively* download packages, just shuffles around the ones you already have.
