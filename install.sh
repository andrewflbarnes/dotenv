#!/usr/bin/env sh

dotenv_files=src

function add_dotenv_file() {
    local src=$1
    local file=$(basename ${src})
    local dest_dir=$2
    local dest=${dest_dir}/${file}

    if [ ! -e "${src}" -o ! -d "${dest_dir}" ]
    then
        printf "\033[31m%-65s\033[0m\n" "A file and destination must be specified" >& 2
        return 1
    fi

    if [ -L ${dest} ]
    then
        printf "\033[33m%-65s\033[0m: %s\n" "The destination symlink already exists" ${dest} >& 2
        return 0
    fi

    if [ -e ${dest} ]
    then
        printf "\033[31m%-65s\033[0m: %s\n" "The destination file already exists but isn't a symlink" ${dest} >& 2
        return 2
    fi

    printf "\033[32m%-65s: %s\n" "Linked file to ${dest_dir}: " ${src} >& 2
    ln -s ${src} ${dest}
}

function add_all_dotenv_files() {
    local current=$(pwd -P)
    local files=$(find ${current}/${dotenv_files} -maxdepth 1 -name ".*")
    local dest_dir=${1:-$HOME}

    for file in ${files}
    do
        add_dotenv_file ${file} ${dest_dir}
    done
}

add_all_dotenv_files ${HOME}
