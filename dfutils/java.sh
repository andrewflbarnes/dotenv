#!/usr/bin/env bash

df_java_hydrate() {
  local vendor=${DF_JAVA_VENDOR:-Corretto}
  local versions=${DF_JAVA_VERSIONS:-11 17 21 24}
  local default_version=${DF_JAVA_DEFAULT:-24}

  if ! type -t sdk &>/dev/null
  then
    echo "ERR: sdk command not available in shell" >&2
    return 1
  fi

  if ! type -t jenv &>/dev/null
  then
    echo "WARN: jenv command not available in shell" >&2
    return 1
  fi

  local vendor_versions
  vendor_versions=$(sdk_vendor java "$vendor")

  if [ -z "$vendor_versions" ]
  then
    echo "ERR: No java versions found for $vendor" >&2
    return 1
  fi

  local version vendor_version
  for version in $versions
  do
    vendor_version=$(grep "^$version" <<< "$vendor_versions" | head -n1)
    if [ -z "$vendor_version" ]
    then
      echo "WARN: Unable to find latest java $version for $vendor in sdkman" >&2
      continue
    fi


    echo "Installing java $vendor_version through sdk..."
    sdk install java "$vendor_version" <<< "n"

    if ! type -t jenv &>/dev/null
    then
      echo "WARN: jenv not in shell, skipping link" >&2
      continue
    fi

    echo "Linking java $vendor_version to jenv..."
    jenv add "$SDKMAN_DIR/candidates/java/$vendor_version"

    if [ "$version" == "$default_version" ]
    then
      echo "Setting $version / $vendor_version as default version"

      if sdk default java "$vendor_version"
      then
        echo "sdk java defauilt set"
      fi

      if type -t jenv &>/dev/null && jenv global "$version"
      then
        echo "jenv default set"
      fi
    fi
  done
}
