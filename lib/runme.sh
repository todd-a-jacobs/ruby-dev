#!/bin/bash

# Purpose:
#     Build and provision a Debian-based Ruby development box.

set -e
set -o pipefail

git rev-parse --is-inside-work-tree > /dev/null 2>&1
cd "$(git rev-parse --show-toplevel)"

bundle install
#bundle install --binstubs
#export PATH="$PWD/bin:$PATH"

alias veewee='bundle exec veewee'
alias vagrant='bundle exec vagrant'

template='Debian-6.0.5-i386-netboot'
vmname='debian-6.0.5-i386'
veewee vbox define ${FORCE:+--force} "$vmname" "$template"
echo 'yes' | bundle exec veewee vbox build ${FORCE:+--force} 'debian-6.0.5-i386'

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
