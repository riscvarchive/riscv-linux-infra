#!/bin/bash

set -e
set -o pipefail

unset target
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --target) target="$2"; shift; shift;;
    *) echo "Unknown argument \"$1\"">&2; exit 1;;
    esac
done

case "$target"
in
master) echo "automatic";;
for-rc) echo "manual";;
riscv-next) echo "automatic";;
esac
