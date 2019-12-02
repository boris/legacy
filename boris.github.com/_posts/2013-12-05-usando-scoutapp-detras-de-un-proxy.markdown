---
layout: post
title: Usando ScoutApp detras de un Proxy
date: 2013-12-05 00:00:00.000000000 -03:00
---
Imagien que sus servers se conectan a las interneces pasando por un Proxy, digamos Squid, con la configuración por default: `http://super-proxy:3128`. Si por esas cosas de la vida, necesitamos monitorear estos servidores usando [ScoutApp](http://scoutapp.com), nada funcionará a menos que se lo indiquemos al momento de la instalación. Esto se hace así:

{% highlight bash %}
$ sudo scout install <api_key> --http-proxy http://super-proxy:3128
{% endhighlight %}

Cómo llegué a esto? Uno de los co-fundadores de ScoutApp me lo dijo :)
