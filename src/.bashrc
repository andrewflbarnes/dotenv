#!/usr/bin/env bash
if [[ -d ~/.bashrc.d ]]
then
  echo "Loading rc scripts..."
  for i in ~/.bashrc.d/*
  do  
    [[ -r $i ]] && [[ "` basename $i`" =~ ^[0-9] ]] && {
      printf "Loading %-35s" "$(basename $i)..."
      . $i
      printf "\033[1;32mDone\033[0m.\n"
    }   
  done
fi

