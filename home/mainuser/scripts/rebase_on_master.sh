#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    me=`basename "$0"`
    echo "Usage: $me branch_to_rebase_on_master"
    exit 1
fi

BRANCH="$1"

CURRENT_COMMIT=$(sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ status | awk 'NR==1 { print $NF; exit }')

if [ -z $CURRENT_COMMIT ]; then
    echo "cannot get the current commit!"
    exit 1
fi

echo "saving current commit - $CURRENT_COMMIT"

echo "fetching origin..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ fetch origin

if [ $? -ne 0 ]; then
    echo "cannot fetch origin!"
    exit 1
fi

echo "checking out ${BRANCH}..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ checkout "${BRANCH}"

if [ $? -ne 0 ]; then
    echo "cannot checkout ${BRANCH}!"
    exit 1
fi

echo "rebasing on master..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ rebase master

if [ $? -ne 0 ]; then
    echo "cannot rebase ${BRANCH}!"
    sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ rebase --abort
    #exit 1  # we do not exit at this point, as we want to go back to $CURRENT_COMMIT
fi

echo "returning to $CURRENT_COMMIT..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ checkout $CURRENT_COMMIT

if [ $? -ne 0 ]; then
    echo "cannot return to $CURRENT_COMMIT"
    exit 1
fi

echo "done"
