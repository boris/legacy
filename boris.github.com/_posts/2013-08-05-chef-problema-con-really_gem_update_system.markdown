---
layout: post
title: Chef problema con REALLY_GEM_UPDATE_SYSTEM
date: 2013-08-05 00:00:00.000000000 -04:00
---
Hoy me encontr&eacute; con el siguiente error cuando estaba corriendo el *bootstrap* a una nueva maquina usando Chef:

{% highlight bash %}
72.2.xxx.yyy ERROR:  While executing gem ... (RuntimeError)
72.2.xxx.yyy     gem update --system is disabled on Debian, because it will overwrite
the content of the rubygems Debian package, and might break your Debian system in 
subtle ways. The Debian-supported way to update rubygems is through apt-get, using 
Debian official repositories.
72.2.xxx.yyy If you really know what you are doing, you can still update rubygems by 
setting the REALLY_GEM_UPDATE_SYSTEM environment variable, but please remember that 
this is completely unsupported by Debian.
72.2.xxx.yyy
72.2.xxx.yyy GET http://rubygems.org/latest_specs.4.8.gz
72.2.xxx.yyy
72.2.xxx.yyy 302 Moved Temporarily
72.2.xxx.yyy
{% endhighlight %}

Claramente es un comportamiento extra&ntilde;o que ocurre cuando se mezclan los siguientes componentes: Chef, Ubuntu 12.044 y Ruby 1.9. La soluci&oacute;n a este problema es modificar de la siguiente forma el archivo de bootstrap:

{% highlight ruby %}
--- ubuntu12.04_ruby1.9.1_bootstrap_PRE.erb     2013-05-22 14:00:28.260592253 +0000
+++ ubuntu12.04_ruby1.9.1_bootstrap.erb 2013-05-22 13:22:46.653543721 +0000
@@ -6,11 +6,11 @@
-gem update --system gem update --system --no-rdoc --no-ri
+REALLY_GEM_UPDATE_SYSTEM=yes sudo -E gem update --system gem update --system \
--no-rdoc --no-ri
{% endhighlight %}
