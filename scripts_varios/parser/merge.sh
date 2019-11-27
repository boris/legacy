#!/bin/bash

pr_line=""
g_flag=0
fr=1
while read line
do
   if [[ ${line} = "1-EMFINDEPENDENCIA" ]]
   then
      g_flag=1
      pr_line=${line}
      continue
   fi
   printf "%s\n" ${line}
done < listado3
