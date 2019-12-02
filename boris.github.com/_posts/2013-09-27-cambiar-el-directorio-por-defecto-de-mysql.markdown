---
layout: post
title: Cambiar el directorio por defecto de MySQL
date: 2013-09-27 00:00:00.000000000 -03:00
---
Un server en el que estoy haciendo pruebas tiene una configuraci&oacute;n m&aacute;s o menos as&iacute;:

{% highlight bash %}
root@server :~# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1       9.1G  8.1G  928M  90% /
udev            2.0G   12K  2.0G   1% /dev
tmpfs           792M  228K  792M   1% /run
none            5.0M     0  5.0M   0% /run/lock
none            2.0G     0  2.0G   0% /run/shm
/dev/vda3       3.0G  4.5M  2.9G   1% /tmp
/dev/vdb1       118G  4.3G  114G   4% /data
{% endhighlight %}

Dentro de lo que tengo que hacer, necesito montar una base de datos que pesa como 20GB los cuales claramente no entran en `/var/lib/mysql`. Qué hacer para resolver esto? Simple: Cambiar el direectorio por defecto de MySQL, cosa que se hace de la siguiente forma:

Detener el servicio MySQL y copiar el contendio de `/var/lib/mysql` al lugar donde queremos que quede finalmente:
{% highlight bash %}
root@server :~# cp -a /var/lib/mysql /data/var/lib/mysql
{% endhighlight %}
Luego de eso, hay que ditar el archivo `/etc/mysql/my.cnf` modificando la línea que hace referencia al **datadir**.

Modificar el perfil **AppArmor** de MySQL editando el archivo `/etc/apparmor.d/usr.sbin.mysqld`:
{% highlight bash %}
  #/var/lib/mysql/ r,
  #/var/lib/mysql/** rwk,
  /data/var/lib/mysql/ r,
  /data/var/lib/mysql/** rwk,
{% endhighlight %}

Finalmente, recargamos y reiniciamos los servicios:
{% highlight bash %}
root@server :~# service apparmor reload
root@server :~# service mysql restart
{% endhighlight %}
