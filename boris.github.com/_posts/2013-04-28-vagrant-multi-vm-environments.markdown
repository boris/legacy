---
layout: post
title: Vagrant Multi-VM Environments
date: 2013-04-28 23:18:00.000000000 -04:00
---
Cuando uno lleva un tiempo trabajando con [VirtualBox](https://www.virtualbox.org) y se encuentra con [Vagrant](http://www.vagrantup.com) se le facilita la vida. Todo administrable desde la terminal, todo en un archivo de configuraci&oacute;n f&aacute;cil de escribir y leer.

Conversando con gente que trabaja con Vagrant, me di cuenta que la mayor&iacute;a le saca poco provecho. Por ejemplo son pocos los que han creado sus propias **boxes** y las comparten con sus equipos de trabajo. Tambi&eacute;n son pocos los que utilizan Chef o Puppet para administrar las configuraciones. Y son aún menos los que utilizan varias instancias administradas con un s&oacute;lo archivo, tambi&eacute;n llamado *Multi-VM Env*.

La configuraci&oacute;n de estos ambientes es bastante simple. Ac&aacute; les dejo un ejemplo:

{% highlight ruby %}
Vagrant.configure("2") do |config|
   config.vm.define :dev do |dev_config|
      dev_config.vm.box = "dev"
      dev_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
      dev_config.vm.network :forwarded_port, host:4000, guest:4000
      dev_config.vm.network :forwarded_port, host:8080, guest:8080
      end
      
      config.vm.define :git do |git_config|
      git_config.vm.box = "git"
      git_config.vm_box_url = "http://files.vagrantup.com/precise64.box"
      git_config.vm.network :forwarded_port, host: 80, guest:80
   end
end
{% endhighlight %}

Me parece que el archivo es f&aacute;cil de leer y de modificar para lo que cada uno necesite. Ojal&aacute; a alguien le sirva como gu&iacute;a para crear sus propios archivos.

*Enjoy and share...*
