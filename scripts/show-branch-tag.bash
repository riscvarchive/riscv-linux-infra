#!/bin/bash

set -e
set -o pipefail

unset repo
unset base
unset parent
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --repo) repo="$2"; shift; shift;;
    --base) base="$2"; shift; shift;;
    --target) target="$2"; shift; shift;;
    esac
done

last_tag="$(git -C "$repo" describe "$base" --abbrev=0)"

case "$target"
in
master) echo "$last_tag";;
for-rc) echo "$last_tag";;
for-mw) echo "$last_tag";;
for-linux-next) echo "$last_tag";;
riscv-next) echo "$last_tag";;
*) echo "Unknown target \"$target\"">&2; exit 1;;
esac
