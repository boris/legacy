---
layout: post
title: ¿A qué apunta la automatizacion del deploy de servidores?
date: 2013-11-25 00:00:00.000000000 -03:00
---
Cuando uno piensa en automatización del deploy de servidores desde el punto de vista del CTO se deben comprender algunos puntos claves que muchas veces son pasados por alto. Esto es un pequeño resumen de lo que he tenido que pasar cada vez que quiero introducir estas tecnologías donde he tenido que trabajar, sobre todo cuando los CEO y/o CTO son de la *vieja escuela*.

Los puntos importantes que se deben tener en cuenta son:

* Debe ser simple.
* Debe ser agnóstico a la plataforma.
* Se debe entender lo que está ocurriendo.
* Una vez realizado el proceso, la máquina debe ser independiente.
* Nada es para toda la vida.

## Simple
La simpleza del proceso apunta a la rapidez, a "en cuantos minutos" tendremos un nuevo server listo para ser usado. Pero no sólo a eso, también a punta a "qué tan fácil será automatizar el proceso" en caso de que queramos enseñarle a algún robot a hacer el trabajo. Idealmente el proceso debe limitarse a la ejecución de un solo comando o unos cuantos comandos relativamente simple.

Si lo llevaramos a un pseudo-lenguaje, debería ser algo así:

{% highlight ruby %}
$ deploy server-1 role-web
{% endhighlight %}

Y la idea es que con eso seamos capaces de obtener un servidor llamado "server-1" que contenga todo lo necesario para trabajar como uno de nuestros web servers,

## Agnóstico
Esto es en referencia a la plataforma donde correrán nuestros servidores y del sistema operativo que usemos. De esta forma permitimos que nuestro sistema se escalable. Da lo mismo si estamos levantando nuestra plataforma sobre servidores físicos o sobre VPS, el comportamiento debe ser exactamente el mismo. Para conseguir esto debemos tener muy claro cual será el *stack* que usaremos y como podemos estandarizar la instalación de cada uno de los componentes del *stack* para las diferentes plataformas/sistemas operativos que usemos.

## Entender
Trabajamos con computadoras, pero no somos computadoras! Debemos entender lo que ocurre *under the hood*, básicamente porque no todo ocurre por arte de mágia (algunas cosas sí).

Debemos entender, por ejemplo, cómo funciona **<a href="http://www.opscode.com/chef/">chef</a>**, **<a href="http://haproxy.1wt.eu/">haproxy</a>**, **<a href="http://capistranorb.com">capistrano</a>**, **<a href="http://nginx.org">nginx</a>** con sus redirects, **<a href="http://unicorn.bogomips.org/">unicorn</a>**, cómo maneja la concurrencia **<a href="http://nodejs.org">nodejs</a>**, cómo funciona un **compilador**, qué ocurre con el **<a href="http://blog.scoutapp.com/articles/2013/07/25/understanding-cpu-steal-time-when-should-you-be-worried">cpu steal</a>** y por sobre todo, debemos **entender como funciona nuestro producto**.

## Independiente
Una vez que la máquina está corriendo, debe ser independiente y ser capaz de realizar algunas tareas sin intervención humana: Actualizaciones, deploys, backups y, lo más importante, **alertarnos si algo está funcionando mal**. Todo esto nos permitirá enfocarnos en tareas más importantes que las que están directamente relacionadas con el mantenimiento de un sistema que, por default, debería ser estable.

## Nada!
Del punto anterior que habla de la independencia se desprende que **nada dura para toda la vida**. Gracias a la flexibilidad que nos entrega una plataforma que sigue más o menos los puntos que mencioné anteriormente, no tendremos que preocuparnos mucho por la vida útil de algún servidor. La desición se reduce a la simple regla de: "Si no tiene carga, se elimina".

Esto nos permitirá, entre otras cosas, ahorrar considerables sumas de dinero en tiempos de CPU ociosos...
