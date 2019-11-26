#!/bin/bash
long=$1
[ "$long" == "" ] && long=10
tr -dc A-Za-z0-9_#$% < /dev/urandom | head -c ${long} | xargs


