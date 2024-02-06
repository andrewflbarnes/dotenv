#!/usr/bin/env bash

export DOTFILES_SKIPFILE="$HOME/.dotfiles-skip"
export DOTFILES_SKIP=
if [ -f "$DOTFILES_SKIPFILE" ] && [ -r "$DOTFILES_SKIPFILE" ]
then
    DOTFILES_SKIP="$(tr '\n' ' ' < "$DOTFILES_SKIPFILE")"
fi
export DOTFILES_SKIPPED=

function dotfiles_skip {
    local dotfile=$1

    if [ -n "$dotfile" ] && [[ " $DOTFILES_SKIP " =~ " $dotfile " ]]
    then
        DOTFILES_SKIPPED="$DOTFILES_SKIPPED $dotfile"
        return 0
    fi
    return 1
}
export -f dotfiles_skip

function dotfiles_skipped {
    if [ -n "$DOTFILES_SKIPPED" ]
    then
        echo -en "\033[33mWarning\033[0m: Skipped loading"
        sed 's/ /\n- /g' <<< "$DOTFILES_SKIPPED" | sort
    fi
}
export -f dotfiles_skipped
