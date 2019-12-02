---
layout: post
title: Probando un script para generar posts
date: 2013-09-16 00:00:00.000000000 -03:00
---
Hace un rato, mientras preparaba un [pisco sour](http://es.wikipedia.org/wiki/Pisco_sour) not&eacute; que es bastante "complejo" el proceso de generar un post nuevo cuando uno usa [jekyll](http://jekyllrb.com) as&iacute; que se me ocurri&oacute; la idea de crear un script que lo haga m&aacute;s f&aacute;cil. Tan f&aacute;cil como ejecutar lo siguiente:

{% highlight bash %}
➜  blog git:(master) ✗ ./post.sh "Probando un script para generar posts"
{% endhighlight %}

Lo que dar&aacute; como resultado lo siguiente:

{% highlight bash %}
➜  blog git:(master) ✗ ls -lrt _posts
(...)
-rw-r--r--  1 boris  staff  2099 Sep 15 23:07 2013-02-14-problema-con-time_wait-en-haproxy.md
-rw-r--r--  1 boris  staff   130 Sep 16 23:46 2013-09-16-Probando-un-script-para-generar-posts.md
{% endhighlight %}

Como se ve, en la &uacute;ltima linea est&aacute; el archivo recien creado con el scrip que hice. Si bien ya est&aacute; resuelto el tema de la creaci&oacute;n de posts con una [rake task](https://gist.github.com/stammy/792958) quer&iacute;a ver si pod&iacute;a hacerlo por mi cuenta.

Por si a alguien le interesa, el c&oacute;digo est&aacute; en [github](https://github.com/boris/boris.github.com)
