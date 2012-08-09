#!/bin/bash

# Purpose:
#    Create a custom launcher for each client project.
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
set -o noclobber

read -e -i 'Company, Inc.'  -p 'Client Name:  ' CLIENT
read -e -i 'Sample Project' -p 'Project Name: ' PROJECT
read -e -i "$RUBY_VERSION"  -p 'Ruby Version: ' RUBY_VERSION
read -e -i 'rails'          -p 'Rails Gemset: ' RAILS_GEMSET

launcher="$HOME/bin/launch-${PROJECT// /_}"
launcher="${launcher,,}"

cat << EOF > "$launcher"
#!/bin/bash

CLIENT='$CLIENT'
PROJECT='$PROJECT'
RAILS_GEMSET='${RUBY_VERSION}@${RAILS_GEMSET}'
export CLIENT PROJECT RAILS_GEMSET

~/bin/client-tmux.sh
EOF

if [[ -f "$launcher" ]]; then
    chmod 755 "$launcher"
    echo "Created project launcher: $launcher"
fi
