#!/bin/bash
SERVERS=( 01 02 03 )
for i in ${SERVERS[@]}
do
	ssh server-$i 'echo PS1=\"[\\u@\\h \\w] $ \" > .bash_profile && hostname && cat .bash_profile' 

done
