---
layout: post
title: Redis can't save in background
date: 2013-01-31 00:00:00.000000000 -03:00
---
Hoy me encontr&eacute; con el siguiente error en los 3 sservidores donde corre Redis:

    [3765] 30 Jan 11:31:10 * 1 changes in 900 seconds. Saving...
    [3765] 30 Jan 11:31:10 # Can't save in background: fork: Cannot allocate memory

Para solucionarlo basta con setear en 1 el overcommit_memory, de la siguiente forma:

    $ echo 1 > /proc/sys/vm/overcommit_memory sysctl vm.overcommit_memory=1

En otro momento escribir&eacute; sobre el overcommit_memoy...
