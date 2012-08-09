#!/bin/bash

# Purpose:
#    Use tmux and rvm to work on a client-specific Rails project in a
#    flexible but isolated way.
#
# Note:
#    You can call this script directly by setting the appropriate
#    environment variables (see below), or use a custom launcher script
#    to automate the process.
#
# Copyright:
#     Copyright 2011, 2012 Todd A. Jacobs
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
# User-configurable environment variables.
######################################################################
: "${CLIENT:=Company, Inc.}"
: "${PROJECT:=sample_project}"
: "${RAILS_GEMSET:=1.9.3@rails}"
: "${ROOT:=$HOME/sandbox/git/rails/$CLIENT/$PROJECT}"
: "${SESSION:=$CLIENT}"
export CLIENT PROJECT RAILS_GEMSET ROOT SESSION 

mkdir -p "$ROOT"
cd "$ROOT"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
PATH="$PATH:$HOME/.rvm/bin"
rvm use "$RAILS_GEMSET"

if tmux has-session -t "${SESSION}"; then
    tmux attach-session -t "${SESSION}"
else
    tmux start-server

    tmux new-session -s "${SESSION}" -d
    tmux rename-window -t "${SESSION}:0" resque

    tmux new-window -t "${SESSION}:1" -n server
    tmux new-window -t "${SESSION}:2" -n console
    tmux new-window -t "${SESSION}:3" -n models
    tmux new-window -t "${SESSION}:4" -n controllers
    tmux new-window -t "${SESSION}:5" -n views
    tmux new-window -t "${SESSION}:6" -n tests
    
    tmux send-keys -t "${SESSION}:0" 'QUEUE=\* rake resque:work' C-m
    tmux send-keys -t "${SESSION}:1" 'rails server thin' C-m
    tmux send-keys -t "${SESSION}:2" 'rails console' C-m
    tmux send-keys -t "${SESSION}:3" 'cd app/models' C-m
    tmux send-keys -t "${SESSION}:4" 'cd app/controllers' C-m
    tmux send-keys -t "${SESSION}:5" 'cd app/views' C-m
    tmux send-keys -t "${SESSION}:6" 'cd app/spec' C-m

    tmux select-window  -t "${SESSION}:2"
    tmux attach-session -t "${SESSION}"
fi
