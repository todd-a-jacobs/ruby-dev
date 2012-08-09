#!/bin/bash

# Purpose:
#    Install a modest set of Vim plugins. This is easier than tweaking
#    the relevant Puppet module, and makes it optional for those who
#    don't need or want the extensions.
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

mkdir -p ~/.vim/plugin
cd ~/.vim/plugin
curl -oL https://raw.github.com/tpope/vim-endwise/master/plugin/endwise.vim
curl -oL https://raw.github.com/tpope/vim-markdown/master/syntax/markdown.vim

cd
/usr/bin/vim-addons install \
    asciidoc    \
    justify     \
    matchit     \
    msmtp       \
    puppet      \
    vim-rails
