#!/bin/bash
export TODO="path/to/to-do"

if [ $# == "0" ]
then
   cat $TODO
else
   n=$(($(tail -1 $TODO | cut -d ' ' -f 1) +1))
   echo "$n -> $@" >> $TODO
fi

