#!/bin/bash

set -e
set -o pipefail

repo="linux"
branch="riscv-next"
push="false"
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --repo) repo="$2"; shift; shift;;
    --branch) parent="$2"; shift; shift;;
    --push) push="true"; shift;;
    esac
done

if test ! -d "$repo"
then
    mkdir -p "$repo"
    git -C "$repo" init
fi

# This script forcefully regenerates a branch from its child branches.  First
# we go find the latest commit on the branch that this branch is based on.
# I've programmed in a bunch of mappings from local branches to parents, and a
# scheme for using slightly more stable versions for some parents (ie, Linus'
# latest tag).
base_branch="$(./scripts/show-base-branch.bash --parent "$branch")"
base_remote="$(./scripts/show-branch-remote.bash --branch "$base_branch")"

if [[ "$(git -C "$repo" remote show "$base_remote")" == "" ]]
then
    remote_url="$(./scripts/show-remote-url.bash --remote "$base_remote")"
    git -C "$repo" remote add "$base_remote" "$remote_url"
fi

base_tag="$(./scripts/show-branch-tag.bash --repo "$repo" --target "$branch" --base "$base_remote/$base_branch")"

git -C "$repo" fetch --prune "$base_remote"
git -C "$repo" checkout --no-track -B "$branch" "$base_tag"

# We've just reset the target branch to the base branch locally, so go ahead
# and merge every 
for source_tuple in $(./scripts/list-source-branches.bash --repo "$repo" --target "$branch")
do
    echo "automerging branch \"$source_tuple\" into \"$branch\""
    git -C "$repo" merge \
        --no-ff \
        --rerere-autoupdate \
        -m "automerging branch \"$source_tuple\" into \"$branch\"" \
        "$source_tuple" || git -C "$repo" commit --no-edit
done
