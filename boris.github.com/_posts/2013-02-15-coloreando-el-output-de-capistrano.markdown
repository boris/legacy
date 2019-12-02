---
layout: post
title: Coloreando el output de Capistrano
date: 2013-02-15 12:58:17.000000000 -03:00
---
[Capistrano](https://github.com/capistrano/capistrano) es un framework que permite automatizar el proceso de _deployment_ por medio de la ejecución de comandos en servidores remotos. Fue originalmente desarrollado por [37Signlas](http://37signals.com/opensource) para hacer deploy de sus productos (Rails).

No entraré en detalle sobre la configuracion de Capistrano, pero para poder tener colores en el STDOUT de Capistrano, debemos instalar: `gem install colored`. Luego de eso, en neustro `deploy.rb` colocamos lo siguiente:

{% highlight ruby %}
require 'capistrano/ext/multistage'
require 'colored'
...
before "deploy:update_code"
do
	puts "Este mensaje sera en color Rojo".red
end
{% endhighlight %}

El resultado será:

![Capistrano](http://media.tumblr.com/740cf2b6570eccdd35a5f0cd38693e2b/tumblr_inline_mgktqj0Y0l1qef6b5.png)
