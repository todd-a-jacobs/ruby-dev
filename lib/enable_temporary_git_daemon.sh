#!/bin/bash

# Purpose:
#     Enable remote-forwarding of git-daemon from the virtual machine to
#     the host machine. The idea is to allow on-demand access to Git
#     repositories on the host without having to rely on VirtualBox
#     shared folders.
#
# Environment Variables:
#     GITDAEMON_BASEPATH - Root directory for repository URLs.
#     GITDAEMON_PID      - Process ID file for git-daemon.
#
# Options:
#     None.
#
# Example:
#    # On host system.
#    enable_temporary_git_daemon.sh
#
#    # Once connected to virtual machine.
#    cd /tmp/
#    git clone git://localhost/foo
#    cd foo/
#    git commit --allow-empty -m 'Empty commit.'
#    git push
#    exit
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

: "${GITDAEMON_BASEPATH:=$HOME/Documents/Vagrant_Box_Shares/${PWD##*/}/files/git}"
: "${GITDAEMON_PID:=/tmp/git-daemon-$$.pid}"
export GITDAEMON_BASEPATH GITDAEMON_PID

echo -n 'Starting git-daemon on localhost...' >&2
mkdir -p "$GITDAEMON_BASEPATH"
git daemon \
    --base-path="$GITDAEMON_BASEPATH" \
    --detach \
    --enable=receive-pack \
    --enable=upload-archive \
    --export-all \
    --pid-file="$GITDAEMON_PID" \
    "$GITDAEMON_BASEPATH"
echo 'done!' >&2
echo >&2


echo "Connecting to ${PWD##*/} VM..." >&2
vagrant ssh -- -R 9418:localhost:9418 \
               -o ControlPersist=no \
	       -o ControlPath=none

echo >&2
echo -n 'Cleaning up git-daemon...' >&2
if ps --pid $(cat "$GITDAEMON_PID") > /dev/null; then
    kill $(cat "$GITDAEMON_PID")
fi
[[ -f "$GITDAEMON_PID" ]] && rm "$GITDAEMON_PID"
echo 'done!' >&2
