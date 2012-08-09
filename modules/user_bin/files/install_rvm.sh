#!/bin/bash

# Purpose:
#    Install Ruby Version Manager (RVM) for a single user inside a
#    Vagrant box. This is unreasonably difficult using Puppet, so this
#    (mostly) automated script speeds up configuration of an up-to-date
#    Rails development environment.
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
# User-configurable stuff.
######################################################################
: ${RUBY_VERSION:=1.9.3}

DEFAULT_GEMS=(
    bundler
    haml
    heroku
    pry
    pry-doc
    rake
    sinatra
    shotgun
    thin
    wirble
)

######################################################################
# Main
######################################################################
trap 'exit 1' TERM

alias fgrep='fgrep --quiet'

# Enable RVM for current shell.
enable_rvm () {
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
}

cat << EOF > ~/.gemrc
install: --no-rdoc --no-ri
update:  --no-rdoc --no-ri
EOF

# Install prerequisites for compiling MRI within RVM.
packages=(
    autoconf automake bison build-essential curl git libc6-dev
    libncurses5-dev libreadline6 libreadline6-dev libsqlite3-0
    libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev
    libyaml-dev openssl sqlite3 subversion zlib1g zlib1g-dev
)
/usr/bin/sudo /usr/bin/aptitude install "${packages[@]}"

#ironruby_pkgs=(curl libmono-2.0-dev)
#jruby_pkgs=(curl g++ openjdk-6-jre-headless)
#jruby_head_pkgs=(ant curl default-jdk default-jre-headless g++)
#/usr/bin/sudo /usr/bin/aptitude install \
#    "${jruby_pkgs[@]}" "${jruby_head_pkgs[@]}" "${ironruby_pkgs[@]}" 

# Run remote installer script.
curl -L get.rvm.io |
    bash -s latest --rails --gems=$(tr ' ' , <<< ${DEFAULT_GEMS[*]})
enable_rvm

# RVM installs to .profile by default. Debian and Ubuntu need to be
# sourced from .bashrc as well.
fgrep \$HOME/.rvm/scripts/rvm ~/.bashrc ||
    { echo; echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function'; } >> ~/.bashrc

# Install default gems.
GEMFILE="$HOME/.rvm/gemsets/default.gems"
for gem in "${DEFAULT_GEMS[@]}"; do
    fgrep "$gem" "$GEMFILE" || echo "$gem" >> "$GEMFILE"
done

# Install global gems.
GEMFILE="$HOME/.rvm/gemsets/global.gems"
for gem in "${DEFAULT_GEMS[@]}"; do
    fgrep "$gem" "$GEMFILE" || echo "$gem" >> "$GEMFILE"
done

rvm reload
rvm install $RUBY_VERSION
rvm reload
rvm --default use $RUBY_VERSION
rvm all do gem install "${DEFAULT_GEMS[@]}"
rvm reload

# Enable gemsets to be created on the fly.
fgrep rvm_gemset_create_on_use_flag ~/.rvmrc ||
    echo rvm_gemset_create_on_use_flag=1 >> ~/.rvmrc

exec "$SHELL"
