#!/bin/bash

set -e

if [ ! -r .vagrant ]; then
    echo 'EX_OSFILE: ".vagrant" missing' >&2
    exit 72
fi

case `uname -s` in
    Darwin)
	audio='coreaudio'
	;;
    Linux)
	audio='pulse'
	;;
esac

vagrant halt
VBoxManage modifyvm $(egrep -o '[[:xdigit:]]{8}-[^"]+' .vagrant) \
    --audio "$audio" \
    --clipboard bidirectional
vagrant up

vagrant ssh -c 'sudo aptitude --assume-yes install pulseaudio'
vagrant ssh -c \
    'echo "pulseaudio --check || pulseaudio --daemonize" >> "$HOME/.bashrc"'
