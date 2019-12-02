---
layout: post
title: Usando http_proxy en capistrano
date: 2013-11-12 00:00:00.000000000 -03:00
---
Ayer, durante el deploy de una aplicación en Rails en un nuevo stack de servidores (AWS usando VPC), recibí el siguiente mensaje por parte de capistrano:

{% highlight bash %}
Fetching full source index from https://rubygems.org/
Could not reach https://rubygems.org/
{% endhighlight %}

Lo que ocurre es que estos servidores pasan por un proxy, por lo tanto para solucionar el problema es necesario indicarle a capistrano dónde está el proxy. Para definir esto tenemos varias opciones:

1. El archivo `deploy.rb`. Si lo hacemos acá la configuración del proxy será para todos los *stages* que tengamos.
2. En el archivo correspondiente al stage.

Obviamente me fui por la opción 2, ya que así puedo aislar esta opción y no afectar el comportamiento del deploy en el resto de los ambientes. Así que incluí lo siguiente en mi `super-cool-stage.rb`:

{% highlight ruby %}
default_environment['http_proxy'] = 'server:port'
default_environment['https_proxy'] = 'server:port'
{% endhighlight %}
