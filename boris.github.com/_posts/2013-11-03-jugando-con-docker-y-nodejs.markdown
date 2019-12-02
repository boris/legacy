---
layout: post
title: Jugando con Docker y NodeJS
date: 2013-11-03 00:00:00.000000000 -03:00
---
Docker viene ganando cada vez más espacio en lo relacionado con PaaS. De hecho, hay un interesante proyecto que usa docker como parte fundamental.

En este breve tutorial espero que los lectores logren generar interés en hacer sus propias implementaciones usando docker, ya que lo que verán a continuación no es más que una especie de laboratorio para demostrar que las cosas funcionan. Para esto, los ingredientes son:

- [Vagrant](http://vagrantup.com)
- Instalar docker siguiendo [estas instrucciones](http://docs.docker.io/en/latest/installation/vagrant/)

**Crear una imagen base** (notar el cambio en el prompt.
{% highlight bash %}
vagrant@precise64:~$ docker run -i -t base /bin/bash
Unable to find image 'base' (tag: latest) locally
Pulling repository base
b750fe79269d: Pulling image (ubuntu-quantl) from base, endpoint: https://cdn-regb750fe79269d: Download complete
27cf78414709: Download complete
root@31574d50d0cb:/# apt-get update
{% endhighlight %}

**Instalamos algunas cosas necesarias**
{% highlight bash %}
root@31574d50d0cb:/# apt-get install aptitude build-essential python-software-properties python g++ make software-properties-common
[...]
{% endhighlight %}

**Agregamos el repo de node e instalamos**
{% highlight bash %}
root@31574d50d0cb:/# add-apt-repository ppa:chris-lea/node.js && aptitude update
You are about to add the following PPA to your system:
Evented I/O for V8 javascript. Node's goal is to provide an easy way to build scalable network programs
More info: https://launchpad.net/~chris-lea/+archive/node.js
Press [ENTER] to continue or ctrl-c to cancel adding it

gpg: keyring '/tmp/tmpb7s0ze/secring.gpg' created
gpg: keyring '/tmp/tmpb7s0ze/pubring.gpg' created
gpg: requesting key C7917B12 from hkp server keyserver.ubuntu.com
gpg: /tmp/tmpb7s0ze/trustdb.gpg: trustdb created
gpg: key C7917B12: public key "Launchpad chrislea" imported
   gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
OK
[...]
{% endhighlight %}

**Instalamos NodeJS**
{% highlight bash %}
root@31574d50d0cb:/# aptitude install nodejs
The following NEW packages will be installed:
nodejs rlwrap{a}
0 packages upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
Need to get 5972 kB of archives. After unpacking 17.4 MB will be used.
Do you want to continue? [Y/n/?]
[...]
root@31574d50d0cb:/# node -v
v0.10.21
{% endhighlight %}

**Creamos una pequeña "aplicación" en node, solo para probar**

{% highlight bash %}
root@31574d50d0cb:/root# cat hello.js
console.log("hello world");
root@31574d50d0cb:/root# node hello.js
hello world
root@31574d50d0cb:/root#
{% endhighlight %}

**Listamos los contenedores que tenemos corriendo**

{% highlight bash %}
vagrant@precise64:~$ docker ps -a
ID                  IMAGE                COMMAND                CREATED             STATUS              PORTS
31574d50d0cb        base:latest          /bin/bash              About an hour ago   Exit 0
{% endhighlight %}

**Creamos un nuevo contenedor para docker**

{% highlight bash %}
vagrant@precise64:~$ docker commit 31574d50d0cb EjemploNode
f7021d3486e9
vagrant@precise64:~$ docker images
REPOSITORY          TAG                 ID                  CREATED              SIZE
EjemploNode         latest              f7021d3486e9        About a minute ago   446.5 MB (virtual 626.6 MB)
{% endhighlight %}

**Iniciamos el contenedor recién creado y le forwardeamos el puerto 1337**

{% highlight bash %}
vagrant@precise64:~$ docker run -i -t -p :1337 EjemploNode /bin/bash
root@97f707faded2:/#
{% endhighlight %}

**Creamos una pequeña aplicación en node que levantará un webserver y mostará un mensaje**
{% highlight javascript linenos %}
var http = require('http');
function requestHandler(req, res) {
   res.writeHead(200, {'Content-Type': 'text/plain'});
   res.end('Esta es una prueba usando Docker.io\n');
}
http.createServer(requestHandler).listen(1337);
{% endhighlight %}

**Desde la máquina que corre Vagrant, ejecutamos `curl` para ver si la aplicación responde**

{% highlight bash%}
vagrant@precise64:~$ curl -i 10.0.2.15:1337
HTTP/1.1 200 OK
Content-Type: text/plain
Date: Mon, 04 Nov 2013 02:27:59 GMT
Connection: keep-alive
Transfer-Encoding: chunked

Esta es una prueba usando Docker.io
{% endhighlight %}

Todo esto funciona ya que aún estamos ejecutando docker en modo interactivo, lo que significa que nuestro "web server" sólo funcionará mientras la sesisón ssh exista.

Lo que debemos hacer ahora es guardar el contenedor como una nueva imagen e iniciar todo como demonio.

{% highlight bash %}
vagrant@precise64:~$ docker ps -a
ID                  IMAGE                COMMAND                CREATED             STATUS              PORTS
97f707faded2        EjemploNode:latest   /bin/bash              10 minutes ago      Exit 130
vagrant@precise64:~$ docker commit 97f707faded2 NodeProduction
338975cd46ab
{% endhighlight %}

**Levantamos el contenedor en modo demonio e invocamos el inicio del web server con nuestra aplicación**

{% highlight bash %}
vagrant@precise64:~$ docker run -d -p :1337 NodeProduction node /root/hello.js
100a2b8a669d
{% endhighlight %}

**Verificamos el funcionamiento**
{% highlight bash %}
vagrant@precise64:~$ docker ps
ID                  IMAGE                   COMMAND               CREATED              STATUS              PORTS
100a2b8a669d        NodeProduction:latest   node /root/hello.js   About a minute ago   Up About a minute   1337->1337
vagrant@precise64:~$ curl 10.0.2.15:1337
Esta es una prueba usando Docker.io
{% endhighlight %}

**Consideraciones finales.**

De la misma forma que aquí levantamos un pequeño servidor node mostrando básicamente un `hola mundo`, docker puede ser utilizado para levantar otro tipo de servicios. He visto algunos casos en donde docker es utilizado como *slave* de Jenkins.

En un futuro cercano, espero que docker sea capáz de solucionar un problema que tengo actualmente con los ambientes para e equipo de QA...
