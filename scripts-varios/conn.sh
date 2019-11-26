#!/bin/bash
# author: boris[at]insert-coin.org
# twitter.com/cereal_bars
# ToDo: incluir ayuda

if [ -z "$2" ] && [ -z "$3" ];
	then
	echo "ssh -v Server $1 con usuario por default (root) y puerto 22"
        ssh -v $1 -l root -p 22
fi

if [ -z "$3" ]
	then
	echo "ssh -v $1 con usurio $2. puerto 22 "
        ssh -v $1 -l $2 -p 22
else
	echo "ssh -v Server $1 con usuario $2 y puerto $3"
        ssh -v $1 -l $2 -p $3
fi
