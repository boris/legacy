---
layout: post
title: Hostname `hostname` is blocked because of many connection errors
date: 2014-03-09 00:00:00.000000000 -03:00
---
No recuerdo si esto ocurrió el Jueves o el Viernes recién pasados. Mientras configuraba un ambiente para `staging` me encontré con el siguiente error:

{% highlight mysql %}
Host 'host_name' is blocked because of many connection errors.
Unblock with 'mysqladmin flush-hosts'
{% endhighlight %}

La solución del problema es bastante simple: viene claramente indicada en el mensaje de error. Pero eso no es lo que me interesaba saber, yo quería saber la razón por la cual apareció ése mensaje.

**Google.**

Luego de dar vuelta google y leer varias veces el manual de MySQL encontré una respuesta que me convenció. Lo que ocurre es que mientras yo estaba trabajando en el setup de este nuevo ambiente, los `grants` en la base de datos no eran los correctos. Eso provocó que cada vez que `monit` levantaba un servicio, este fallaba. Eso ocurría frecuentemente gracias al *retry* de monit.

Con toda esa cantidad de errores (aproximadamente √-1), se superó ampliamente la cantidad de conexiones fallidas que acepta MySQL antes de bloquear un hosts. Por si les interesa, la cantidad de conexiones está definida con la variable  `max_connect_errors` y por defecto es de 10. Cuando se alcanza este número, MySQL bloqueará todas las conexiones desde dicho hosts, sin importar si son correctas o no. Esto se hace porque es más barato responder el mensaje de error en cuanto conocemos la IP desde la cual se intenta abrir la conexión, a tener que hacer el intento de abrir la conexión y que esta falle.
