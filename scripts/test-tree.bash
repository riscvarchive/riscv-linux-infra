#!/bin/bash

set -e

unset repo
unset tree
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --repo)       repo="$2";                            shift 2;;
    --tree)       tree="$2";                            shift 2;;
    *)            echo "$0: unknown argument $1" >&2;   exit 1;;
    esac
done

echo "$0: Testing $tree [$(git -C "$repo" describe "$tree")]"
git -C "$repo" checkout "$tree"
make.cross -C "$repo" ARCH=riscv defconfig
make.cross -C "$repo" ARCH=riscv
