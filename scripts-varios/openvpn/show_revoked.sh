#!/bin/bash

if [ -d $1 ]
then
   echo "No input file. Usage:"
   echo "./show_revoked.sh index.txt"
else
   echo "Revoked certificates: "
   cat $1 | awk '{print $6}' |sed -e 's/\// /g' | awk '{print $5}' | sed -e 's/=/ /g' | awk '{print $2}'
fi
