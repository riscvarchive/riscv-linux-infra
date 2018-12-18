#!/bin/bash

unset repo
unset target
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --repo) repo="$2"; shift; shift;;
    --target) target="$2"; shift; shift;;
    esac
done

# First, make sure we have all the relevant remotes for this
remotes=()
case "$target"
in
master)
    ;;
for-next)
    remotes+=("github.com-riscv-riscv_linux")
    remotes+=("kernel.org-palmer-linux")
    ;;
riscv-all)
    remotes+=("github.com-riscv-riscv_linux")
    remotes+=("kernel.org-palmer-linux")
    ;;
*) echo "Unknown target \"$target\"">&2; exit 1;;
esac

for remote in "${remotes[@]}"
do
    if [[ "$(git -C "$repo" remote show "$remote")" == "" ]]
    then
        url="$(./scripts/show-remote-url.bash --remote "$remote")"
        git -C "$repo" remote add "$remote" "$url"
    fi
    git -C "$repo" fetch --prune "$remote"

    case "$remote"/"$target"
    in
    github.com-riscv-riscv_linux/for-next)
        git -C "$repo" branch --all | grep "  remotes/$remote/fix-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/next-" | sed 's@^  remotes/@@'
        ;;
    kernel.org-palmer-linux/for-next)
        git -C "$repo" branch --all | grep "  remotes/$remote/fix-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/next-" | sed 's@^  remotes/@@'
	;;
    github.com-riscv-riscv_linux/riscv-all)
        git -C "$repo" branch --all | grep "  remotes/$remote/fix-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/next-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/review-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/wip-" | sed 's@^  remotes/@@'
        ;;
    kernel.org-palmer-linux/riscv-all)
        git -C "$repo" branch --all | grep "  remotes/$remote/fix-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/next-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/review-" | sed 's@^  remotes/@@'
        git -C "$repo" branch --all | grep "  remotes/$remote/wip-" | sed 's@^  remotes/@@'
        ;;
    *)
        echo "Unknown remote/target \"$remote\"/\"$target\"">&2
        exit 1
        ;;
    esac
done
