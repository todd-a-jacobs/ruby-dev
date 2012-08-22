#!/bin/bash

set -e

if [ ! -r .vagrant ]; then
    echo 'EX_OSFILE: ".vagrant" missing' >&2
    exit 72
fi

vagrant halt
VBoxManage modifyvm $(egrep -o '[[:xdigit:]]{8}-[^"]+' .vagrant) \
    --audio coreaudio \
    --clipboard bidirectional
vagrant up
