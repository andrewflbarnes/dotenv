#!/usr/bin/env bash

df_python_hydrate() {
  local versions=${DF_PYTHON_VERSIONS:-3.10 3.11 3.12 3.13}
  local default_version=${DF_PYTHON_DEFAULT:-3.13}

  if ! type -t pyenv &>/dev/null
  then
    echo "ERR: pyenv command not available in shell" >&2
    return 1
  fi

  local version
  for version in $versions
  do
    echo "Install python version $version"

    if ! pyenv install "$version"
    then
      echo "ERR: failed to install python version $version" >&2
      continue
    fi

    if [ "$version" == "$default_version" ]
    then
      echo "Setting $version as default version"
      pyenv global "$version"
    fi
  done
}
