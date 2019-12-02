---
layout: post
title: Problema al instalar ruby 1.8.7 usando rbenv
date: 2014-01-24 00:00:00.000000000 -03:00
---
Por temas de compatibilidad tuve que instalar ruby 1.8.7-p371 en mi laptop para poder hacer deploy de un proyecto que aun está con capistrano 2.15.5. El tema es que al ejecutar el `rbenv install 1.8.7-p371` recibía el siguiente error:

{% highlight bash %}
boris@macbook ~                                                                                                [17:25:50]
> $ rbenv  install 1.8.7-p371
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Downloading ruby-1.8.7-p371.tar.gz...
-> http://dqw8nmjcqpjn7.cloudfront.net/653f07bb45f03d0bf3910491288764df
Installing ruby-1.8.7-p371...

BUILD FAILED

Inspect or clean up the working tree at /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458
Results logged to /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458.log

Last 10 log lines:
x ruby-1.8.7-p371/parse.c
/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458/ruby-1.8.7-p371 /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458 ~
configure: WARNING: unrecognized options: --without-tk, --with-readline-dir
checking build system type... i686-apple-darwin13.0.0
checking host system type... i686-apple-darwin13.0.0
checking target system type... i686-apple-darwin13.0.0
checking whether the C compiler works... no
configure: error: in `/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458/ruby-1.8.7-p371':
configure: error: C compiler cannot create executables
See `config.log' for more details

BUILD FAILED

Inspect or clean up the working tree at /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458
Results logged to /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458.log

Last 10 log lines:
/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458/ruby-1.8.7-p371 /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458 ~
configure: WARNING: unrecognized options: --without-tk, --with-readline-dir
checking build system type... i686-apple-darwin13.0.0
checking host system type... i686-apple-darwin13.0.0
checking target system type... i686-apple-darwin13.0.0
checking whether the C compiler works... no
configure: error: in `/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172552.38458/ruby-1.8.7-p371':
configure: error: C compiler cannot create executables
See `config.log' for more details
make: *** No targets specified and no makefile found.  Stop.
{% endhighlight %}

Pensé que era algun problema con los flags de compilación, así que intenté lo siguiente:

{% highlight bash %}
boris@macbook ~                                                                                                [17:28:55]
> $ CPPFLAGS=-I/opt/X11/include rbenv  install 1.8.7-p371
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Downloading ruby-1.8.7-p371.tar.gz...
-> http://dqw8nmjcqpjn7.cloudfront.net/653f07bb45f03d0bf3910491288764df
Installing ruby-1.8.7-p371...

BUILD FAILED

Inspect or clean up the working tree at /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110
Results logged to /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110.log

Last 10 log lines:
x ruby-1.8.7-p371/parse.c
/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110/ruby-1.8.7-p371 /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110 ~
configure: WARNING: unrecognized options: --without-tk, --with-readline-dir
checking build system type... i686-apple-darwin13.0.0
checking host system type... i686-apple-darwin13.0.0
checking target system type... i686-apple-darwin13.0.0
checking whether the C compiler works... no
configure: error: in `/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110/ruby-1.8.7-p371':
configure: error: C compiler cannot create executables
See `config.log' for more details

BUILD FAILED

Inspect or clean up the working tree at /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110
Results logged to /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110.log

Last 10 log lines:
/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110/ruby-1.8.7-p371 /var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110 ~
configure: WARNING: unrecognized options: --without-tk, --with-readline-dir
checking build system type... i686-apple-darwin13.0.0
checking host system type... i686-apple-darwin13.0.0
checking target system type... i686-apple-darwin13.0.0
checking whether the C compiler works... no
configure: error: in `/var/folders/_d/y3r_xgn907n2d2kr8pgt82d00000gn/T/ruby-build.20140124172914.39110/ruby-1.8.7-p371':
configure: error: C compiler cannot create executables
See `config.log' for more details
make: *** No targets specified and no makefile found.  Stop.
{% endhighlight %}

El resultado fue el mismo. Así que pensé que quizás el error era originado por el compilador LLVM, así que para resolverlo le pasé un parámetro para indicarle la versión específica del compilador a usar:

{% highlight bash %}
boris@macbook ~                                                                                                [17:29:30]
> $ CPPFLAGS=-I/opt/X11/include CC=/usr/local/bin/gcc-4.2 rbenv install 1.8.7-p371
/usr/local/bin/ruby-build: line 655: /usr/local/bin/gcc-4.2: No such file or directory
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Downloading ruby-1.8.7-p371.tar.gz...
-> http://dqw8nmjcqpjn7.cloudfront.net/653f07bb45f03d0bf3910491288764df
Installing ruby-1.8.7-p371...
Installed ruby-1.8.7-p371 to /Users/boris/.rbenv/versions/1.8.7-p371

Downloading rubygems-1.6.2.tar.gz...
-> http://dqw8nmjcqpjn7.cloudfront.net/0c95a9869914ba1a45bf71d3b8048420
Installing rubygems-1.6.2...
Installed rubygems-1.6.2 to /Users/boris/.rbenv/versions/1.8.7-p371
{% endhighlight %}

Success! Ahora tengo todas las versiones de ruby que necesito :)
{% highlight bash %}
boris@macbook ~                                                                                                [17:38:41]
> $ rbenv versions
system
1.8.7-p371
* 1.9.3-p327 (set by /Users/boris/.ruby-version)
1.9.3-p448
{% endhighlight %}
