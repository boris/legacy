---
layout: post
title: 'Bundle Install: Cannot allocate memory'
date: 2014-01-21 00:00:00.000000000 -03:00
---
Hoy mientras preparaba mi DevBox -powered by [Vagrant](http://vagrantup.com)- con [rbenv](https://github.com/sstephenson/rbenv), al ejecutar el `bundle install` me encontré con el siguiente mensaje

{% highlight bash %}
Unfortunately, a fatal error has occurred. Please see the Bundler
troubleshooting documentation at http://bit.ly/bundler-issues. Thanks!
/var/lib/gems/1.8/gems/bundler-1.5.2/lib/bundler/source/git/git_proxy.rb:114:in ``': Cannot allocate memory - git clone
'git://github.com/jpoz/APNS.git' "/home/boris/.bundler/cache/git/APNS-ace7892473338460ff8cfe3ede279b88ca3948f4" --bare --no-hardlinks
(Errno::ENOMEM)
{% endhighlight %}

La solución para eso? Agregar un swapfile, de la siguiente forma:

{% highlight bash %}
> $ sudo swapon -s   # verificamos si tenemos swap
[sudo] password for boris:
Filename	  Type	   Size	 Used  Priority

> $ sudo dd if=/dev/zero of=/swapfile bs=1024 count=512k    # creamos un swap file
524288+0 records in
524288+0 records out
536870912 bytes (537 MB) copied, 1.498 s, 358 MB/s

> $ sudo mkswap /swapfile     # creamos el "swap fs"                    
Setting up swapspace version 1, size = 524284 KiB
no label, UUID=0ad9a06e-4a9b-4f5e-8b31-dcea3e5cfbed

> $ sudo swapon /swapfile     # montamos la swap

> $ sudo swapon -s	      # verificamos nuevamente 
Filename	  Type	   Size	 Used  Priority
/swapfile                               file	524284	 0  -1
{% endhighlight %}

Luego de eso, el bundle install funciona sin problemas.
