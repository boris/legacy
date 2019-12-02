---
layout: post
title: 'HAProxy: variables globales y por defecto'
date: 2014-03-27 00:00:00.000000000 -03:00
---
Según mi entendimiento, cuando uno define una variable como *global* esta aplica *para toda* la aplicación. Por alguna razón en HAProxy 1.5-dev esto no es así. Y lo noté cuando definí como global la cantidad máxima de conexiones:

{% highlight bash %}
global
   log 127.0.0.1   local0
   log 127.0.0.1   local1 notice
   log loghost    local0 info
   maxconn 10000
{% endhighlight %}

Como ven, se supone que con eso HAProxy llegaría a un máximo de 10.000 conexiones antes de empezar a encolarlas. Pero no estaba funcionando! Dónde definirlas entonces? En la sección defaults:

{% highlight bash %}
defaults
   log     global
   mode    http
   retries 3
   timeout client 50s
   timeout connect 5s
   timeout server 50s
   option dontlognull
   option httplog
   option redispatch
   option tcp-smart-accept
   option tcp-smart-connect
   balance  roundrobin
   maxconn 15000
{% endhighlight %}

Problema resuelto.
