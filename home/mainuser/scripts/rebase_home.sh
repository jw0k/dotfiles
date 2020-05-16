#!/usr/bin/env bash

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

echo "checking out home..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ checkout home

if [ $? -ne 0 ]; then
    echo "cannot checkout home!"
    exit 1
fi

echo "rebasing on master..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ rebase master

if [ $? -ne 0 ]; then
    echo "cannot rebase home!"
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
