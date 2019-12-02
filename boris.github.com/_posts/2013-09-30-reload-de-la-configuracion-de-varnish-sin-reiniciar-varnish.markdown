---
layout: post
title: Reload de la configuracion de Varnish sin reiniciar Varnish
date: 2013-09-30 00:00:00.000000000 -03:00
---
Algo que en la actualidad de cuida con la vida es el cache de [Varnish](http://varnish-cache.org). Para los que no lo saben, Varnish es un acelerador de aplicaciones web ampliamente utilizado "en la industria". Además de eso, el logo es un conejito:

![varnish](http://cdn.friendbg.net/2013/09/varnish-logo.jpg)

Hace uno días, necesitaba cambiar un valor en la configuración del Varnish y para que tuviera efecto sería necesario reiniciar el proceso y por lo tanto perder todo lo que ha cacheado hasta la fecha. Cabe señalar que la configuración guarda objetos durante un año y la aplicación se encarga de invalidarlos si es necesario hacerlo. En este caso, perder un año de cache hubiera sido terrible.

## Resolución del problema
La herramienta a usar fue **varnishadm** de la siguiente forma:

{% highlight bash %}
server ~$ varnishadm
200
-----------------------------
Varnish Cache CLI 1.0
-----------------------------
-sfile,-smalloc,-hcritbit

Type 'help' for command list.
Type 'quit' to close CLI session.

vcl.load newconfig01 /opt/local/etc/varnish.vcl
vcl.use newconfig01
quit
500
Closing CLI connection
{% endhighlight %}

Lo anterior le dice a varnish que cargue la **newconfig01** ubicada en `/opt/local/etc/varnish.vcl` y que posteriormente la use (`vcl.use`).

Con eso tendremos nuestra nueva configuración corriendo sin perder los objetos cacheados a la fecha.
