#!/bin/bash

# Purpose:
#     Build and provision a Debian-based Ruby development box.

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
