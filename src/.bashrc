#!/usr/bin/env bash

[ -r "$HOME/.dotfiles-init.sh" ] && . "$HOME/.dotfiles-init.sh"

if [ -d ~/.bashrc.d ]
then
  #echo "Loading rc scripts..."
  echo
  for i in ~/.bashrc.d/*
  do
    loadfile="$(basename "$i")"
    [ -r "$i" ] && [[ "$loadfile" =~ ^[0-9] ]] && {
      printf "\033[1A\033[K"
      printf "Loading %-35s" "$loadfile..."
      if dotfiles_skip ".bashrc.d/$loadfile"
      then
        printf "\033[1;33mSkipped\033[0m.\n"
      else
        . "$i"
        printf "\033[1;32mDone\033[0m.\n"
      fi
    }
  done
  printf "\033[1A\033[K"
fi

dotfiles_skipped

# sdkman-init.sh default init prevention : START
# sdkman-init.sh default init prevention : END
