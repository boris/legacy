---
layout: post
title: 'OpenStack: Data Base, Message Queue, API'
date: 2013-03-12 12:55:39.000000000 -03:00
---
Cuando uno se lanza a la tarea de crear una nube, en mi caso usando [OpenStack](http://openstack.org), tiene que tomar en cuenta muchos factores referentes a la alta disponibilidad del sistema.

Si vamos a prestar un servicio, ya sea pagado (a clientes) o gente dentro de nuestra propia organización, este servicio debe estar siempre disponible, dejando de lado la típica respuesta chilena: "Estamos sin sistema".

Para mi, algunas de las características fundamentales de una nube son:

- Siempre disponible (y por lo tanto tolerante a fallos, redundante)
- Elástica (puede crecer o achicarse, *on-demand*)
- Inteligente (debe ser capaz de mantenerse sin la intervención humana, dentro de lo posible)
- Automágica (debe ser capaz de realizar tareas por su cuenta: configurar nuevo hardware, disponibilizar más nodos, etc)

Con esto en mente, en la siguiente serie de post haré algunos comentarios sobre cada uno de los componentes de OpenStack y cómo estos deben (o no) estar en un entorno de alta disponibilidad. A diferencia de lo que se pueda pensar, hay cosas que no requieren HA. Es más, hay cosas que tranquilamente pueden correr sobre una máquina virtual. Pero eso lo veremos en otro post mas adelante, cuando esta serie termine.

## Base de datos
La base de datos que usa OpenStack es del tipo *stateful*, es decir, toma en cuenta el estado de la información. Si esta base de datos, que es utilizada principalmente por **nova-compute**, pierde conectividad perderemos información el estado de nuestros nodos (que es lo que informa nova-compute). Esto puede provocar que se reporte un nodo en estado **running** cuando realmente no lo está.

**Recomendación**: Hacer que nuestra base de datos sea tolerante a fallos. Bastante simple.

## Message Queue
La gran mayoria de los servicios de cómputo de OpenStack se comunican entre sí utilizando una cola de mensajes. Si esta cola falla (o queda inaccesible), nuestro cluster quedará en un estado de *read-only*, con la información del último mensaje que fue enviado.

Queda claro que la cola de mensajes en un elemento vital en el funcionamiento de nuestra nube, por lo tanto es un **must** que sea tolerante a cualquier fallo. Por suerte, RabbitMQ tiene integrada capacidades de cluster.

## API
Aqui siempre hay un dilema. OpenStack soporta su propia API (obvio) y la API de [EC2](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/Welcome.html). Cuando uno va a implementar una nube que prestará algun servicio, es necesario decidir qué API soportar ya que existe una incosistencia al momento de disponibilizar ambas. Esta inconsistencia está dada principalmente por las referencias a las **instancias** y a las **imágenes**. En la API de EC2 se hace referencia a las instancias usando IDs que contienen un valor hexadecimal, mientras que la API de OpenStack se refiere a las instancias usando nombres y dígitos. Otro ejemplo es que la API de EC2 depende de un DNS para contactar a las máquinas virtuales, mientras que la API de OpenStack lo hace usando direcciones IP.

Al igual que en las bases de datos y en las colas de mensajes, tener más de un servidor para API es recomendable, más aun si estamos usando [Horizon](http://docs.openstack.org/developer/horizon/) ya que cada vez que se cargue una página se realizarán varias llamadas a la API.

Este problema yo lo solucioné usando [HAProxy](http://haproxy.1wt.eu/) con 4 nodos para balancear la carga.

## Para el próximo post...
En el próximo post de esta serie, escribiré sobre:

- Scheduler
- Images
- Dashboard
