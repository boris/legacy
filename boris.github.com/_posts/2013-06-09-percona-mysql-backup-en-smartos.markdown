---
layout: post
title: Percona (mysql) backup en SmartOS
date: 2013-06-09 18:38:00.000000000 -04:00
---
De nada sirve tener una gran base de datos si no tenemos backup. En realidad, cuando uno trabaja en tecnolog&iacute;a o como DevOp, no sirve de nada hacer nada si al primer problema vamos a tener nuestro sistema abajo mucho rato.

Un punto cr&iacute;tico es el respaldo de las bases de datos, y cuando digo "base de datos" me refiero a la estructura y contenido de las tablas, no de las configuraciones.

En el proyecto que estoy trabajando actualmente, decidimos usar [http://www.percona.com/](Percona), principalmente por la integraci&oacute;n que tiene con [http://smartos.org](SmartOS). Una de las gracias que tiene la *Percona SmartMachine* de Joyent es el *Joyent QuickBackup*, que b&aacute;sicamente es un *non-blocking* MySQL backup que por debajo usa el Percona Xtrabackup. Por default, viene pre-configurado con el usuario y password necesarios para conectarse a la base de datos, pero el servicio viene deshabilitado.

**Configuraci&oacute;n b&aacute;sica**

    $ svccfg -s pkgsrc/quickbackup-percona setprop quickbackup/minute = 0
    $ svccfg -s pkgsrc/quickbackup-percona setprop quickbackup/hour = 04
    $ svccfg -s pkgsrc/quickbackup-percona setprop quickbackup/day = all

Con lo anterior, se realizar&aacute; un backup de todas las bases de datos todos los d&iacute;s a las 4AM.

Una vez configurado el servicio, debemos habilitarlo:

    $ svcadm refresh quickbackup-percona
    $ svcadm enable quickbackup-percona


Listo. Ahora s&oacute;lo nos queda configurar algun sistema (rsync?) para mover nuestros backups a otro lugar.
