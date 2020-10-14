#!/bin/sh

function uninstall
{
    source ./dotfiles.shlib

    for x in "${dotfiles[@]}"; do
        rm $HOME/.$x
    done
}

uninstall
