---
layout: post
title: 'SPoF: Single Point of Failure'
date: 2013-05-01 21:10:00.000000000 -04:00
---
Supongamos que tenemos que dise&ntilde;ar una arquitectura para soportar una aplicaci&oacute;n web que ser&aacute; visitada por muchos usuarios al d&iacute;a, digamos unos 300.000 visitante &uacute;nicos diariamente. Obviamente este dise&ntilde;o ser&aacute; puesto "en la nube" y deber&iacute;a cumplir con al menos lo siguiente:

- Ser autoescalable
- Proporcionar alta disponibilidad

Que un sistema sea **autoescalable** nos dice que por si solo ya proporciona alta disponibilidad, porque si algo falla o faltan recursos, el sistema se dar&aacute; cuenta y agregar&aacute; nodos donde sea necesario para soportar la demanda. Por otro lado, un sistema con **alta disponibilidad** no necesariamente ser&aacute; autoescalable ya que esta alta disponibilidad puede estar dada, por ejemplo, por dos *sites* diferentes.

Cuando uno comienza el dise&ntilde;o de una plataforma debe tener en cuenta estos factor, pero por sobre todo algo llamado [Single Point of Failure](http://en.wikipedia.org/wiki/Single_point_of_failure). Me parece que no es necesario que explique qu&eacute; es el punto &uacute;nico de fallos porque su nombre lo dice todo, pero s&iacute; considero necesario explicar qu&eacute; podemos hacer al respecto:

Nuestra tarea siempre debe ser reducir al m&aacute;ximo posible el *downtime* de nuestros servicios, por lo que es primordial que el SPoF pueda volver a la vida r&aacute;pidamente. Supongamos que nuestro SPoF est&aacute; en nuestra base de datos: Qu&eacute; pasa si la base de datos se nos muere? Cu&aacute;nto nos demoramos en recuperarla? Esto es: Levantar una nueva instancia, hacer las configuraciones y colocar ah&iacute; un dump de nuestro backup m&aacute;s reciente? Si pensamos que tenemos todo, por ejemplo, en Amazon y administramos las configuraciones con Chef o Puppet, el proceso de despliegue de la nueva instancia no deber&iacute;a tomar mucho tiempo. Pero qu&eacute; hay del dump de la base de datos? Eso depender&aacute; del volumen de datos que menejemos, por lo que el tiempo es variable.

La experincia me ha ense&ntilde;ado que el SPoF **debe** estar en un lugar que sea r&aacute;pido de recuperar. Un lugar que s&oacute;lo maneje configuraciones simples que r&aacute;pidamente se las podamos hacer llegar a nuestra nuevo server con Chef o Puppet. Un lugar que **no** maneje data de usuarios ni de aplicaciones! Qu&eacute; lugar podr&iacute;a ser? S&iacute;, el **load balancer**!

Uno de los balanceadores de carga m&aacute;s usados es [HAProxy](http://haproxy.1wt.eu/). S&eacute; de buena fuente que grandes empresas de tecnolog&iacute;a del mundo (como [Google](https://github.com/google), [Globo.com](https://github.com/globocom), [Mercado Libre](https://github.com/mercadolibre) y [Github](https://github.com/github)) usan HAProxy en sus plataformas, b&aacute;sicamente debido a su simpleza. 

Y bueno, por qu&eacute; dejar nuestro load balancer como SPoF? Porque es un componente que no guarda datos de usuarios ni de aplicaciones, no tiene configuraciones complejas m&aacute;s all&aacute; de un archivo de configuraci&oacute; y, lo mejor de todo, porque tiene sentido que est&eacute; ah&iacute;! Qu&eacute; sentido tiene que nuestro balanceador de carga est&eacute; arriba si no es posible llegar a nuestra aplicaci&oacute;? Ninguno. Adem&aacute;s, debido a su simpleza es posible volver este componenten a la vida es menos de 15 minutos. A mi ya me pas&oacute; :-)
