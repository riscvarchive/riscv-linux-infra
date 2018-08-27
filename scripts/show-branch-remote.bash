#!/bin/bash

set -e
set -o pipefail

unset branch
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --branch) branch="$2"; shift; shift;;
    esac
done

case "$branch"
in
master) echo "kernel.org-torvalds-linux";;
*) echo "Unknown branch \"$branch\"">&2; exit 1;;
esac
