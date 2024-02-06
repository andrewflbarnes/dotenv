#!/usr/bin/env bash
(
set -e
cwd="$(realpath $0 | xargs dirname)"
dotenv_files="$cwd/src"
[ -d "$dotenv_files" ]
dotenv_dest="$HOME"
shim_files="$cwd/shims"
dotbin_dest="$HOME/dotbin"

padding=95
now=$(date "+%Y%m%d%H%M%S")

function add_ln {
    local src=$1
    local dest_dir=$2
    local file=$3
    local dest="${dest_dir}/${file}"
    local force=$4

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
            local dest_target="$(realpath "$dest")"
            if [[ "$dest_target" != "$(realpath "$src")" ]]
            then
                printf "\033[31m%-${padding}s\033[0m: %s\n" "The destination symlink already exists for $dest" "${dest_target}" >& 2
                return 4
            else
                printf "\033[33m%-${padding}s\033[0m: %s\n" "The destination symlink already exists" "${dest}" >& 2
                return 4
            fi
        else
            printf "\033[31m%-${padding}s\033[0m: %s -> %s\n" "The destination symlink already exists but is to a non-existent file" "${dest}" "$(realpath "${dest}")" >& 2
            return 2
        fi
    fi

    if [ -e "${dest}" ]
    then
        printf "\033[31m%-${padding}s\033[0m: %s\n" "The destination file already exists but isn't a symlink" "${dest}" >& 2
        return 3
    fi

    ln -s "${src}" "${dest}"
}

function add_dotenv_file {
    local src=$1
    local dest_dir=$2
    local force=$3

    local file
    file=$(basename "${src}")

    if add_ln "$src" "$dest_dir" "$file" "$force"
    then
        printf "\033[32m%-${padding}s: %s\n" "Linked file to ${dest_dir}: " "${src}" >& 2
    fi
}

function add_all_dotenv_files {
    local force=$1

    local files
    files=$(find ${dotenv_files} -maxdepth 1 -name ".*" | sort)

    local file
    for file in ${files}
    do
        add_dotenv_file "${file}" "${dotenv_dest}" "${force}"
    done
}

function add_all_shims {
    local force=$1

    if ! [ -d "${shim_files}" ]
    then
        printf "\033[33m%-${padding}s\033[0m: %s\n" "No shim source folder exists" "${shim_files}" >& 2
        return
    fi

    local files
    files=$(find ${shim_files} -maxdepth 1 -mindepth 1 | sort)

    local file
    for file in ${files}
    do
        add_dotenv_file "${file}" "${dotbin_dest}" "${force}"
    done
}

function add_alias {
    local prog=$1
    local alias=$2

    if add_ln "$prog" "$dotbin_dest" "$alias" "$force"
    then
        printf "\033[32m%-${padding}s: %s\n" "Linked alias to ${alias}: " "${prog}" >& 2
    fi
}

add_all_dotenv_files "$@"
mkdir -p "$dotbin_dest"
add_all_shims "$@"
)
