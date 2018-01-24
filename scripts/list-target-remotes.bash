#!/bin/bash

set -e
set -o pipefail

unset target
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --target) target="$2"; shift; shift;;
    esac
done

# First, make sure we have all the relevant remotes for this
case "$target"
in
master)
    echo "kernel.org-palmer"
    echo "github.com-riscv"
    ;;
for-linus)
    echo "kernel.org-palmer"
    ;;
for-next)
    echo "kernel.org-palmer"
    ;;
riscv-all)
    echo "kernel.org-palmer"
    echo "github.com-riscv"
    ;;
*) echo "Unknown target \"$target\"">&2; exit 1;;
esac
