#!/bin/bash

set -e

unset repo
unset source_tuple
unset target_tree
while [[ "$1" != "" ]]
do
    case "$1"
    in
    --repo)       repo="$2";                            shift 2;;
    --source)     source_tuple="$2";                    shift 2;;
    --target)     target_tree="$2";                     shift 2;;
    *)            echo "$0: unknown argument $1" >&2;   exit 1;;
    esac
done

source_repo="$(echo "$source_tuple" | cut -d/ -f1)"
source_branch="$(echo "$source_tuple" | cut -d/ -f2)"
parent_branch="$(./scripts/show-base-branch.bash --parent "$target_tree")"

echo "$0: Rebasing $source_branch [$(git -C "$repo" describe "$source_tuple")] onto $parent_branch [$(git -C "$repo" describe "$parent_branch")]"

git -C "$repo" checkout "$source_tuple" -b "$source_branch"
trap "git -C $repo checkout $parent_branch; git -C $repo branch -D $source_branch" EXIT
git -C "$repo" rebase "$parent_branch"
git -C "$repo" push --force "$source_repo" "$source_branch"

if [[ "$(git -C "$repo" diff "$source_tuple" "$parent_branch" | wc -l)" == 1 ]]
then
    echo "$0: Deleteing $source_branch as it has been merged already"
    git -C "$repo" push "$source_repo" :"$source_branch"
fi
