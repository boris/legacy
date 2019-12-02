---
layout: post
title: mysql_connect demasiado lento
date: 2013-02-01 00:00:00.000000000 -03:00
---
En algunos casos, una simple *query* con un par de JOINs puede tomar mucho tiempo cuando ha sido llamada usando `mysql_connect()`.

Esto ocurre porque cuando se usa esta funci&oacute;n, el servidor MySQL intentar&aacute; resolver el nombre del host que est&aacute; intentando conectarse. Si la resoluci&ooacute;n de &eacute;ste nombre toma mucho tiempo, el proceso terminar&aacute; siendo muy lento.

Este tipo de comportamiento es posible verlo en los siguientes casos:

* Servidores de aplicaciones conectados a bases de datos remotas
* Error en la configuraci&oacute;n de localhost

La soluci&oacute;n a este problema pasa por agregar la siguientes lineas al archivo `my.cnf`:

    [mysqld]
    skip-name-resolve

Una vez hecho el cambio, hay que reiniciar el servicio MySQL.
