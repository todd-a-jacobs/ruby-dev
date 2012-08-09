#!/bin/bash

# Purpose:
#     Make hidden dotfiles visible for easy editing.

set -e

cd 'modules/dotfiles/files'
for file in .[a-z]*; do
    ln -s "$file" "${file:1}"
done
