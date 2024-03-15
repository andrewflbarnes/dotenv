#!/usr/bin/env bash

install() {
    local opts=("$@")

    local cwd
    cwd="$(realpath "$0" | xargs dirname)"A

    local src="$cwd"
    local package=src
    local dest="$HOME"

    if ! [ -d "$src/$package" ]
    then
        echo "Source package could not be located: $src/$package" >&2
        return 1
    fi

    if ! command -v stow &> /dev/null
    then
        {
            echo "GNU stow is required to run the install script. Install with"
            echo "  brew install stow"
        } >&2
        return 2
    fi
    
    stow -v --adopt -t "$dest" -d "$package" "${opts[@]}" .
}

install "$@"
