#!/bin/bash

set -e
set -o pipefail

unset remote
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --remote) remote="$2"; shift; shift;;
    esac
done

case "$remote"
in
kernel.org-torvalds-linux) echo "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git";;
kernel.org-palmer-riscv_linux) echo "git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git";;
kernel.org-palmer-linux) echo "git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git";;
github.com-riscv-riscv_linux) echo "git://github.com/riscv/riscv-linux.git";;
github.com-sifive-riscv_linux) echo "git://github.com/sifive/riscv-linux.git";;
*) echo "Unknown remote \"$remote\"">&2; exit 1;;
esac
