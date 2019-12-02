---
layout: post
title: Bootstrapping Vagrant
date: 2013-05-26 20:59:00.000000000 -04:00
---
Cuando uno comienza a trabajar con Vagrant y hace el primer *up*, se encontrar&aacute; que la m&aacute;quina reci&eacute;n booteada no tienen nada, salvo el sistema base por lo que debemos comenzar a instalar todo lo que queremos que tenga.

Con una m&aacute;quina no hay problema, pero si necesitamos 10 o 15 iguales? Para solucionar esto, Vagrant implementa algo llamado **bootstrap**. [Info sobre bootstrap ac&aacute;](http://docs.vagrantup.com/v2/getting-started/provisioning.html).

El bootstrap funciona de forma bastante simple: Creamos un archivo llamado `bootstrap.sh` en el mismo directorio que tenemos nuestro `Vagrantfile` con un contenido como el siguiente:

{% highlight bash %}
#!/usr/bin/env bash

aptitude update
aptitude install -y build-essential git-core vim zsh lighttpd nodejs
{% endhighlight %}

Luego de eso, en nuestro `Vagrantfile` incluimos la siguiente linea:

{% highlight ruby %}
Vagrant.configure("2") do |config|
   config.vm.box = "boris-dev"
   config.vm.box_url = "http://files.vagrantup.com/precise64.box"
   config.vm.provision :shell, :path => "bootstrap.sh"

   ...
end
{% endhighlight %}

Con esto, cuando hagamos el `vagrant up` se ejecutar&aacute; el archivo `bootstrap.sh` y se instalar&aacute; todo lo que ah&iacute; definimos
