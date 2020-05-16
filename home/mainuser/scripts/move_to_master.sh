#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    me=`basename "$0"`
    echo "Usage: $me number_of_commits_to_move"
    exit 1
fi

if [ ! -z "$(sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ status --porcelain)" ]; then
    echo "Working directory is not clean. Consider stashing"
    exit 1
fi

NUMBER_OF_COMMITS_TO_MOVE="$1"

CURRENT_COMMIT=$(sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ name-rev HEAD --name-only)

if [ -z $CURRENT_COMMIT ]; then
    echo "cannot get the current commit!"
    exit 1
fi

if [ $CURRENT_COMMIT == "master" ]; then
    echo "you are already on master!"
    exit 1
fi

echo "saving current commit - $CURRENT_COMMIT"

echo "fetching origin..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ fetch origin

if [ $? -ne 0 ]; then
    echo "cannot fetch origin!"
    exit 1
fi

echo "checking out master..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ checkout master

if [ $? -ne 0 ]; then
    echo "cannot checkout master!"
    exit 1
fi

echo "cherry picking ${NUMBER_OF_COMMITS_TO_MOVE} commit(s) from ${CURRENT_COMMIT}"

CHERRY_PICK_OK=true
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ cherry-pick "${CURRENT_COMMIT}~${NUMBER_OF_COMMITS_TO_MOVE}..${CURRENT_COMMIT}"

if [ $? -ne 0 ]; then
    echo "cannot cherry-pick ${NUMBER_OF_COMMITS_TO_MOVE} commit(s) from ${CURRENT_COMMIT}!"
    sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ cherry-pick --abort
    CHERRY_PICK_OK=false
    #exit 1  # we do not exit at this point, as we want to go back to $CURRENT_COMMIT
fi

echo "returning to $CURRENT_COMMIT..."
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ checkout $CURRENT_COMMIT

if [ $? -ne 0 ]; then
    echo "cannot return to ${CURRENT_COMMIT}, you need to clean up"
    exit 1
fi

if ${CHERRY_PICK_OK}; then
    echo "removing last ${NUMBER_OF_COMMITS_TO_MOVE} commit(s) from $CURRENT_COMMIT"
    sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ reset --keep "HEAD~${NUMBER_OF_COMMITS_TO_MOVE}"
    if [ $? -ne 0 ]; then
        echo "cannot remove last ${NUMBER_OF_COMMITS_TO_MOVE} commit(s) from $CURRENT_COMMIT"
        exit 1
    fi

    /home/mainuser/scripts/rebase_home.sh
fi

echo "done"
