#!/bin/bash

# Purpose:
#    Install the Mikogo screen-sharing client from source. Mikogo does
#    *not* have an open license, so the binaries cannot be distributed
#    as part of this package, although this installer script is
#    available to you under GPLv3.
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

URL=http://download.mikogo4.com/mikogo.tar.gz
FILENAME=$(basename "$URL")

cd /tmp
find . -type d -name \*mikogo\* -print0 2>&- | xargs -0 rm -rf

wget --continue "$URL"
clamscan --verbose --detect-pua "$FILENAME"

echo
tar xvfa "$FILENAME"

echo
mv -i mikogo*/* ~/bin/
