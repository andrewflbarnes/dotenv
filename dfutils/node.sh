#!/usr/bin/env bash

df_node_hydrate() {
  local versions=${DF_NODE_VERSIONS:-18 20 22}
  local default_version=${DF_NODE_DEFAULT:-22}

  if ! type -t fnm &>/dev/null
  then
    echo "ERR: fnm command not available in shell" >&2
    return 1
  fi

  local version
  for version in $versions
  do
    echo "Install node version $version"

    if ! fnm install "$version"
    then
      echo "ERR: failed to install node version $version" >&2
      continue
    fi

    if [ "$version" == "$default_version" ]
    then
      echo "Setting $version as default version"
      fnm default "$version"
    fi
  done
}
