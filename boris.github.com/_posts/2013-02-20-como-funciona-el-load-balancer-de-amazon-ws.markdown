---
layout: post
title: Como funciona el load balancer de Amazon WS
date: 2013-02-20 15:40:25.000000000 -03:00
---
Cuando trabajamos con balanceadores de carga, como por ejemplo [HAProxy](http://haproxy.1wt.eu/), asumimos que si tenemos 2 servidores _atrás_ la carga será repartida equitativamente, esto es 50 y 50. Ahora, si tenemos 5 servidores a cada uno le llegará un 20% de la carga total.

Pero, qué pasa cuando nuestro balanceador de carga es un [ELB de AmazonWS](http://aws.amazon.com/elasticloadbalancing/)? Cómo afecta las _availability zones_ al reparto de carga? Veamos un ejemplo gráfico:

![LoadBalancer01](/images/loadbalancer01.png)

Ahora, qué pasaría si agregamos 2 nodos más? Cada uno recibirá. No! Los **ELB** hacen la distribución de la carga en base a las _availability zones_, por lo tanto si tenemos 5 nodos la distribución de carga será la siguiente:

![LoadBalancer02](/images/loadbalancer02.png)

En este caso, quién recibirá mayor carga será el **nodo02** y por lo tanto es posible que recibamos alertas de uso de CPU, memoria, etc. Debido a la forma en que **ELB** distribuye la carga, se recomienda tener siempre la misma cantidad de nodos en cada _availability zone_ a fin de evitar que un nodo trabaje más que el resto.

Este problema lo enfrenté hoy. Destrás de uno de los ELB tenía 3 nodos (en las zonas a, b y c) a los cuales necesitaba agregar uno extra, debido al aumento en los requests y la carga de uno de los sitios. No tenía sentid tener 6 nodos (uno en cada zona), así que la solución fue eliminar un nodo de la zona C y agregar dos nodos, uno a la zona A y uno a la zona B.
