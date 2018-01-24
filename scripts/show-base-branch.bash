#!/bin/bash

unset parent
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --parent) parent="$2"; shift; shift;;
    *) echo "Unknown argument $1">&2; exit 1;;
    esac
done

case "$parent"
in
master) echo "master";;
for-linus) echo "master";;
for-next) echo "master";;
riscv-all) echo "master";;
*) echo "Unknown parent branch \"$parent\"">&2; exit 1;;
esac
