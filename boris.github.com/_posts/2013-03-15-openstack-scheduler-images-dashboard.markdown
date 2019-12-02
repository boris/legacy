---
layout: post
title: 'OpenStack: Scheduler, Images, Dashboard'
date: 2013-03-15 10:20:05.000000000 -03:00
---
[En el post anterior](http://borisquiroz.herokuapp.com/2013/03/12/openstack-database-message-queue-api/) hablé de la DB, message queue y API de [OpenStack](http://openstack.org), así que ahora toca el turno de:

## Scheduler
Con el scheduler surge el primer gran problema: Cómo meter máquinas virtuales de diferentes tamaños (o "sabores" como se llaman en OpenStack) en cada uno de los nova-compute nodes? Existen varias formas para resolver este problema, pero aun no se ha llegado a una que pueda abarcar todos los casos posibles. En mi experiencia, lo que mejor resulta es que cada uno de los *flavors* escalen en forma lineal, siendo estos proporcional a nuestra capacidad física de hardware. De esta forma, el Scheduler no tendrá problemas en posicionar cada instancia (VM) dentro de los nova-compute nodes disponibles.

En caso de que nuestra infraestructura sea muy grande o bien la frecuencia de creación de la instancias sea muy alta y por lo tanto también sea alto el trabajo del Scheduler, hay que considerar más de un nova-scheduler. Lo bueno de esto es que el nova-scheduler trabaja completamente sobre la cola de mensajes, por lo tanto no es necesario ningun tipo de balanceo de carga o alguna estructura rara que proporcione HA.

## Image (and delivery) service
El catálogo de imagenes de OpenStack está compuesto por dos partes: **glance-api** y **glance-registry**. El primero es una API y el segundo un Registro (cri... cri...)

**glance-api** se encarga de entregar las imagenes que los compute nodes usarán para descargar sus imágenes desde el backend. Por su parte **glance-registry** se encarga de mantener la metadata asociada a cada imagen de cada instancia, y por lo tanto requiere una base de datos.

**glance-api** es una capa de abstracción que nos permite elegir que *backend* queremos usar. Por ahora soporta:

- OpenStack Object Storage (obvio)
- FS (cualquier FS tradicional que nos permita alojar las imagenes)
- S3 (read-only)
- HTTP (read-only)

Segun mi experiencia, la mejor opcion es la primera ya que es la que posee mayores ventajas desde el punto de vista de la escalabilidad y la integración dentro del ecosistema de OpenStack. En caso de que no podamos contar con Object Storage, el FS es una buena opción.

Por otro lado, si no queremos que nuestros usuarios tenga la libertad para agregar sus propias imagenes (algo asi como lo que hace Amazon), usar S3 o HTTP (que son read-only) es una buena opción para disponibilizar el catalogo de imagenes.

## Dashboard
**Horizon** es código en Python que corre sobre Apache, por lo tanto, al momento de pensar en balanceo de carga y HA, hay que tratarlo de la misma forma que cualquier otra aplicación web. Hay que tener en cuenta, además, la cantidad de llamadas a la API que se realizan con cada impresión de página, así como también las llamadas que se harán cuando la págin esté *idle*. Ejemplo: el refresh de 30 segundos que se realizará cuando el usuario tenga el dashboard abierto en una *tab* del browser que no esté usando.

## Para el próximo post:
- Consideraciones de red
- Scaling
