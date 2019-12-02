---
layout: post
title: Problema con TIME_WAIT en HAproxy (y una que otra cosa)
date: 2013-02-14 11:55:00.000000000 -03:00
---
Ayer, por razones que todavia se investigan, nuestro server que corre [HAProxy](http://haproxy.1wt.eu/) decidió morir. Es el único server de toda la plataforma (39 servers en producción) que no es redundante, básicamente porque confio (o confiaba) ciegamente en HAProxy.  
Reemplazarlo fue relativamente simple, a pesar de unos problemas de dependencias de algunas _gems_ de chef-client lo cual significó una hora de downtime :(

El tema es que hoy, a eso de las 5.30 am me despertó una alerta de PagerDuty diciendo que el nuevo balanceador de carga (lb-1-new, que creativo...) había sobrepasdo la barrera del 50% de swap. Luego de hacer un `netstat -antp` vi que había millones de lineas mostrando `TIME_WAIT`:

	boris@lb-1:~$ sudo netstat -antp| grep TIME_WAIT|wc -l
	5787

El server estaba casi _out-of-memory_ así que había que picar. Lo primero que hice fue verificar los siguientes parámetros:

	boris@lb-1:~$ echo /proc/sys/net/ipv4/tcp_fin_timeout
	60
	boris@lb-1:~$ echo /proc/sys/net/ipv4/tcp_keepalive_intvl
	75
	boris@lb-1:~$ echo /proc/sys/net/ipv4/tcp_tw_recycle
	0

MAL! Así que hice las siguientes moficaciones:

	boris@lb-1:~$ echo /proc/sys/net/ipv4/tcp_fin_timeout
	20
	boris@lb-1:~$ echo /proc/sys/net/ipv4/tcp_keepalive_intvl
	35
	boris@lb-1:~$ echo /proc/sys/net/ipv4/tcp_tw_recycle
	1

El resultado:

	boris@lb-1:~$ sudo netstat -antp| grep TIME_WAIT|wc -l
	48

El tema es que el problema con la memoria continuaba! Así que de la mano de `htop` noté que el proceso `chef-client` estaba usando el 85% de la memoria! ¬¬ maldito... Un `service chef-client stop` solucionó el problema. Al volver a iniciar el proceso, no siguió comiendo memoria. Raro, muy raro. Ya habrá tiempo para investigar eso.

Más info sobre los parámetros de Linux: [http://www.speedguide.net/articles/linux-tweaking-121](http://www.speedguide.net/articles/linux-tweaking-121)
