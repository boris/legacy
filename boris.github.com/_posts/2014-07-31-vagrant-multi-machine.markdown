---
layout: post
title: Vagrant Multi-Machine
date: 2014-07-31 00:00:00.000000000 -04:00
---
En algunos casos, necesitamos hacer pruebas que involucran dos o más instancias. En el caso particular que me tocó hoy, lo que necesitaba eran dos instancias para correr [MariaDB](https://mariadb.com) es modo Master/Slave. Obviamente la elección fue [Vagrant](http://vagrantup.com).

La configuración típica de Vagrant es más o menos así:
{% highlight ruby %}
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "boris.dev"
    [...]
end
{% endhighlight %}

El tema es que hoy necesito dos! Y para eso, la configuración cambia un poco:
{% highlight ruby %}
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
[...]
    config.vm.define "master" do |m|
	m.vm.box = "ubuntu/trusty64"
	m.vm.hostname = "mariadb-master"
    end

    config.vm.define "slave" do |s|
	s.vm.box = "ubuntu/trusty64"
	s.vm.hostname = "mariadb-slave"
    end
end
{% endhighlight %}

Con eso, cuando hagamos un `vagrant status` veremos:
{% highlight bash %}
 boris@macbook  ~/Code/Vagrant  vagrant status
 Current machine states:

 master                    not created (virtualbox)
 slave                     not created (virtualbox)

 This environment represents multiple VMs. The VMs are all listed
 above with their current state. For more information about a specific
 VM, run `vagrant status NAME`.
 {% endhighlight %}

 Y listo. Ahora es cosa de hacer `vagrant up <master/slave>` para comenzar a trabajar.
