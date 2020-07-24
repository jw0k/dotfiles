#!/usr/bin/env bash

sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ fetch origin
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ rebase origin/master master
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ rebase origin/work work
sudo -E git --git-dir=$HOME/.mydotfiles/ --work-tree=/ rebase origin/home home
