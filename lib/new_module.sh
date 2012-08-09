#!/bin/bash

# Purpose:
#     Initialize a new, named Puppet module suitable for populating with
#     necessary information.

set -o errexit
set -o noclobber

gitkeep () {
  find modules/"${1}" -type d -execdir touch ".gitkeep" \;
}

puppet_module() {
  [[ -d "$1" ]] && exit 1
  mkdir -p modules/"${1}"/{manifests,files,lib,templates,tests}
  printf "class $1 {\n}" > modules/"${1}"/manifests/init.pp
  gitkeep "$1"
}

if [[ -z "$1" ]]; then
    echo "Usage: $(basename "$0") <module_name>" >&2
    exit 1
fi

puppet_module "$1"
