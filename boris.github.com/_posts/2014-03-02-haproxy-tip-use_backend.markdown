---
layout: post
title: 'HAProxy tip: use_backend'
date: 2014-03-02 00:00:00.000000000 -03:00
---
Por todos es sabido que los archivos estáticos (principalmente JS e imagenes) son los que más tiempo toman en la carga. No me refiero a que toman mucho tiempo porque sean pesados, sino que la cantidad de estos hace que el tiempo total de carga de una pagina aumente.

A medida que nuestro sistema crece, cada vez se hace más complejo servir estos archivos, ya que por cada *request* tenemos que entregar muchos archivos estáticos. Para acelerar un poco este proceso, los grandes sitios utilizan algo llamado [CDN](http://es.wikipedia.org/wiki/Red_de_entrega_de_contenidos) que básicamente es un gran repositorio de archivos que cambian con poca frecuencia.

El ejemplo más claro de uso de CDN es Facebook. Basta con mirar la URL de sus fotos y veremos lo siguiente:

![Facebook CDN](/images/facebook_cdn.png)

Todas las fotos y cualquier otro contenido **que no cambie nunca** (en estricto rigor, con poca frecuencia), facebook lo subirá a su CDN y lo repartirá en varias partes del mundo para que sea accesible rápidamente.

**ya, ¿y?**

A lo que voy no es a que **necesitamos** siempre contar con una CDN, pero algo bastante claro es que idealmente debemos configurar nuestra infraestructura para que nuestros servidor cumplan con su función específica. Por ejemplo, los servidores de aplicaciones se encarguen de servir la aplicación, los de bases de datos las bases de datos. ¿Y el contenido estático? Bueno, dediquemos un servidor específicamente para eso y le decimos a HAProxy que todos los request de contenido estático lo envíe a esa máquina. ¿Cómo? Así:

{% highlight bash %}
frontend web
  bind 0.0.0.0:80
  use_backend static_content if { path_end .jpg .png .gif .css .js }
  default backend app_servers

backend app_servers
  balance source
  cookie SERV insert indirect nocache
  server app-1 10.0.0.11:8080 check maxconn 1000
  server app-2 10.0.0.12:8080 check maxconn 1000

backend static_content
  balance roundrobin
  server static-1 10.0.0.21:80 check maxconn 1000
  server static-2 10.0.0.22:80 check maxxonn 1000
{% endhighlight %}

Lo que va a pasar aquí, es que cuando llegue un request la respuesta **no se enviará sólo a un servidor**. En lugar de eso, la respuesta se construirá por un lado con partes de algún servidor del grupo `app_servers` (la parte de la aplicación (nunca diga *aplicativo*)) y por otro lado con partes de algún servidor del grupo `static_content`. La idea es que los servidores de este último grupo cuenten con algún tipo de caché para que los requests no tengan que ir hasta el disco para obtener el dato que necesitan.
