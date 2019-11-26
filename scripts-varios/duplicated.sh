#!/bin/bash
args=("$@")

sort -n ${args[0]} | uniq -c | awk '$1>1 {print $2}' > duplicated.txt
