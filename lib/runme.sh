#!/bin/bash

# Purpose:
#     Build and provision a Debian-based Ruby development box.
#
# Options:
#     Use the FORCE environment variable to overwrite all existing
#     definitions, ISO images, and Vagrant boxes. This is a sledgehammer
#     option, not a fine-grained set of flags.
#
# Copyright:
#     Copyright 2012 Todd A. Jacobs
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

git rev-parse --is-inside-work-tree > /dev/null 2>&1
cd "$(git rev-parse --show-toplevel)"

bundle install

# Will not work properly as aliases inside the script, although they
# seem to work fine at the command line. They work reliably as
# functions, though.
veewee () {
    bundle exec veewee "$@"
}
vagrant () {
    bundle exec vagrant "$@"
}

template='Debian-6.0.5-i386-netboot'
vmname='debian-6.0.5-i386'
veewee vbox define ${FORCE:+--force} "$vmname" "$template"
echo 'yes' | veewee vbox build ${FORCE:+--force} 'debian-6.0.5-i386'

# Verify the ISO.
if (which md5sum > /dev/null); then
    md5sum \
	iso/debian-6.0.5-i386-netinst.iso |
	fgrep --color bdf926d604258ce17dfba0b5ef067f17
fi

vagrant basebox export "$vmname"
vagrant box add ${FORCE:+--force} "${PWD##*/}" 'debian-6.0.5-i386.box'

sleep 60
vagrant up
