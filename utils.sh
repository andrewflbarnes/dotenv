#!/usr/bin/env bash

do_load() {
  local f
  for f in dfutils/*
  do
    [ -f "$f" ] && source "$f"
  done
}

do_load
