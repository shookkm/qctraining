#!/usr/bin/env bash

updateMinor(){
  VERSION_ARRAY[2]=0
  ((VERSION_ARRAY[1]++ ))
  LIB_VERSION=$(IFS="." ; echo "${VERSION_ARRAY[*]}")
}

updatePatch(){
  ((VERSION_ARRAY[2]++ ))
  LIB_VERSION=$(IFS="." ; echo "${VERSION_ARRAY[*]}")
}
LIB_VERSION=$(grep -oP '(?<=^version = ).*' gradle.properties)
LIB_VERSION="$(echo -e "${LIB_VERSION}" | tr -d '[:space:]')"
LIB_VERSION="$(echo -e "${LIB_VERSION}" | tr -d '\r')"
IFS="." read -r -a VERSION_ARRAY<<<"$LIB_VERSION"
LATEST_LOG=$(git log --oneline --decorate -1)
if [[ "$LATEST_LOG" =~ feature/ ]]; then
  updateMinor
else
  updatePatch
fi
sed -i "s/^\(version = \).*$/\1$LIB_VERSION/" gradle.properties
echo "$LIB_VERSION"