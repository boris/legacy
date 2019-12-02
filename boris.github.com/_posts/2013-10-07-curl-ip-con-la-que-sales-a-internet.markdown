---
layout: post
title: 'ProTip: Conoce la IP con la que sales a Internet'
date: 2013-10-07 00:00:00.000000000 -03:00
---
[Curl](http://curl.haxx.se/) es una herramienta que, según yo, debería venir en todo sistema operativo que quiera ser llamado sistema operativo. Este **ProTip** muestra como usar curl para conocer cuál es la IP que usamos para salir a Internet:

{% highlight bash %}
macbook at ~ ❯ curl ifconfig.me/all
ip_addr: 200.55.194.218
remote_host:
user_agent: curl/7.24.0 (x86_64-apple-darwin12.0) libcurl/7.24.0 OpenSSL/0.9.8y zlib/1.2.5
port: 39419
lang:
connection:
keep_alive:
encoding:
mime: */*
charset:
via:
forwarded:
{% endhighlight %}

Otra forma, que muestra menos información es la siguiente:

{% highlight bash %}
macbook at ~ ❯ curl ifconfig.me/ip
200.55.194.218
{% endhighlight %}

Todo esto, gracias a la gente que se le ocurrió hacer [ifconfig.me](http://ifconfig.me) donde hay más ejemplos de curl que muestran diferente información.
