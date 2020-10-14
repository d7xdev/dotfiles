#!/bin/sh

function install
{
    source ./dotfiles.shlib

    for x in "${dotfiles[@]}"; do
        ## Make sure parent directory exist
        parent=$HOME/.$(dirname $x)
        [ -d $parent ] || mkdir -p $parent

        ln -sfT $PWD/$x $HOME/.$x
    done
}

install
