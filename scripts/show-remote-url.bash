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
kernel.org-torvalds) echo "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git";;
kernel.org-palmer) echo "git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git";;
github.com-riscv) echo "git://github.com/riscv/riscv-linux.git";;
*) echo "Unknown remote \"$remote\"">&2; exit 1;;
esac
