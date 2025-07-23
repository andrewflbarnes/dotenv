#!/usr/bin/env bash

df_rust_hydrate() {
  rustup-init
  . "$CARGO_HOME/env"
  cargo install git-cliff
}
