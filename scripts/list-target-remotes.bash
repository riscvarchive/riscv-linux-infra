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
    echo "kernel.org-palmer-linux"
    echo "kernel.org-palmer-riscv_linux"
    echo "github.com-riscv-riscv_linux"
    ;;
for-next)
    echo "kernel.org-palmer-riscv_linux"
    echo "kernel.org-palmer-linux"
    ;;
riscv-all)
    echo "kernel.org-palmer-riscv_linux"
    echo "kernel.org-palmer-linux"
    echo "github.com-riscv-riscv_linux"
    ;;
*) echo "Unknown target \"$target\"">&2; exit 1;;
esac
