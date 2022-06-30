#!/usr/bin/env bash

dotenv_files=src
padding=75
now=$(date "+%Y%m%d%H%M%S")

function add_dotenv_file {
    local src file dest_dir dest force
    src=$1
    file=$(basename "${src}")
    dest_dir=$2
    dest=${dest_dir}/${file}
    force=$3

    if [ ! -e "${src}" ] || [ ! -d "${dest_dir}" ]
    then
        printf "\033[31m%-${padding}s\033[0m\n" "A file and destination must be specified" >& 2
        return 1
    fi

    if [ -n "${force}" ] && { [ -L "${dest}" ] || [ -e "${dest}" ]; }
    then
        local backup=${dest}.${now}
        printf "\033[33m%-${padding}s\033[0m: %s -> %s\n" "Backing up existing destination file" "${dest}" "${backup}" >& 2
        mv "${dest}" "${backup}"
    fi

    if [ -L "${dest}" ]
    then
        if [ -e "${dest}" ]
        then
            printf "\033[33m%-${padding}s\033[0m: %s\n" "The destination symlink already exists" "${dest}" >& 2
            return 0
        else
            printf "\033[31m%-${padding}s\033[0m: %s -> %s\n" "The destination symlink already exists but is to a non-existent file" "${dest}" "$(readlink "${dest}")" >& 2
            return 2
        fi
    fi

    if [ -e "${dest}" ]
    then
        printf "\033[31m%-${padding}s\033[0m: %s\n" "The destination file already exists but isn't a symlink" "${dest}" >& 2
        return 3
    fi

    printf "\033[32m%-${padding}s: %s\n" "Linked file to ${dest_dir}: " "${src}" >& 2
    ln -s "${src}" "${dest}"
}

function add_all_dotenv_files {
    local current files dest_dir force
    current=$(pwd -P)
    files=$(find "${current}"/${dotenv_files} -maxdepth 1 -name ".*")
    dest_dir=${1:-$HOME}
    force=$2

    for file in ${files}
    do
        add_dotenv_file "${file}" "${dest_dir}" "${force}"
    done
}

add_all_dotenv_files "${HOME}" "$@"
