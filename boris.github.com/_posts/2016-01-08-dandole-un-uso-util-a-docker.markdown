---
layout: post
title: 'Tor: Dándole un uso útil a Docker'
date: 2016-01-08 21:23:42.000000000 -03:00
---
[Tor](https://www.torproject.org/) es una red a la cual nos podemos conectar y que nos permite navegar por las interneces de forma "anónima" para que nuestro proveedor de Internet no se de cuenta qué tipo de información estamos traficando.

A fin de cuentas, y en palabras siempre, es "algo" que permitirá que no nos limiten el tráfico a internet según el contenido al cual estemos accediendo.

¿Cómo funciona? Uno puede instalar una extensión en el Browse o bien proteger a toda su red haciendo pasar todo el tráfico "del WiFi" por Tor antes de salir a Internet. Y ese es el sentido de este post: Utilizando Docker, levantar un contenedor con Tor el cual tenga un SOCKET Proxy y salir a internet por ahí.

### Let's do this shit!

Lo primero que necesitamos es traernos un contenedor con Tor. [Yo ya preparé uno](https://hub.docker.com/r/boris/tor) así que lo único que tenemos que hacer es un `pull` y luego levantarlo. Acá debemos tener en cuenta la IP de nuestro docker host, que usaremos para levantar tor y para configurar el proxy.

```
$ docker pull boris/tor
$ docker run -d --name tor_nado -p 192.168.99.100:9150:9150 boris/tor
```

Lo que hace el segundo comando es levantar una instancia con tor (llamada tor_nado, sorry lo original) y *bindear* el puerto 9150 a la IP de mi docker host. Lo siguiente que debemos hacer es configurar nuestro browser para que pase por el proxy:

![](/content/images/2016/01/Screen-Shot-2016-01-08-at-9-34-31-PM.png)

Antes de guardar los cambios, podemos hacer una pequeña prueba: Vamos a https://check.torproject.org/ y veremos lo siguiente:

![](/content/images/2016/01/no_tor.png)

Pero una vez que apliquemos los cambios...

![](/content/images/2016/01/Screen-Shot-2016-01-08-at-9-39-27-PM.png)

Podemos ver que aunque no estoy usando Tor Browser, si estoy navegando a través de la red de Tor.

* * *
Por si alguien está interesado, el [Dockerfile](https://github.com/boris/docker/blob/master/tor/Dockerfile) que usé está disponible [en mi docker repo](https://github.com/boris/docker).
