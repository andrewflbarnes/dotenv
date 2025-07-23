#!/usr/bin/env bash

df_brew_hydrate() {
  trap "return 127" INT HUP TERM

  local tap
  # shellcheck disable=SC2046
  awk '/^tap/{gsub("[,\"]", "", $0);print $2}' Brewfile \
  | while read -r tap
    do
      brew tap "$tap"
    done
  # shellcheck disable=SC2046
  brew install $(awk '/^brew/{gsub("[,\"]", "", $0);print $2}' Brewfile)
  # shellcheck disable=SC2046
  brew install --cask $(awk '/^cask/{gsub("[,\"]", "", $0);print $2}' Brewfile)

  trap - INT HUP TERM
}
