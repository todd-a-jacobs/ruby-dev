#!/bin/bash

set -e

rm -rf *box iso/ definitions/ .vagrant "$HOME/.vagrant.d/boxes/${PWD##*/}"
