#!/usr/bin/env bash
if [[ -d ~/.bashrc.d ]]
then
  #echo "Loading rc scripts..."
  echo
  for i in ~/.bashrc.d/*
  do
    [[ -r $i ]] && [[ "` basename $i`" =~ ^[0-9] ]] && {
      printf "\033[1A\033[K"
      printf "Loading %-35s" "$(basename $i)..."
      . $i
      printf "\033[1;32mDone\033[0m.\n"
    }
  done
  printf "\033[1A\033[K"
fi
