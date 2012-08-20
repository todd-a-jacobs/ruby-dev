#!/bin/bash

# Purpose:
#    Install rbenv for a single user inside a Vagrant box. This is
#    unreasonably difficult using Puppet, so the user needs to do most
#    of the heavy lifting.
#
# Copyright:
#     Copyright 2010-2012 Todd A. Jacobs
#     All rights reserved.
#
# License:
#     Released under the GNU General Public License (GPL)
#     http://www.gnu.org/copyleft/gpl.html
#
#     This program is free software; you can redistribute it and/or
#     modify it under the terms of the GNU General Public License as
#     published by the Free Software Foundation; either version 3 of the
#     License, or (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#     General Public License for more details.

set -e
set -o pipefail

######################################################################
# Main
######################################################################
trap 'exit 1' TERM

sudo aptitude install rbenv ruby-build

# Install rbenv to ~/.bashrc, but only enable it if RVM is not found in
# the user's home directory.
{
    echo
    [[ -d ~/.rvm ]] && echo -n '#'
    echo 'eval "$(rbenv init -)"'
} >> ~/.bashrc

exec "$SHELL"
