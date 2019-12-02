---
layout: post
title: Algoritmos de balanceo en HAProxy
date: 2014-01-08 00:00:00.000000000 -03:00
---
[HAProxy](http://haproxy.1wt.eu/) junto con [Nginx](http://nginx.org/) debe ser uno de los mejores softwares que he usado en las interneces. En este post explicaré un poco sobre los algoritmos que implementa HAProxy para distribuir los request entre los nodos disponibles. Esto se puede configurar definiendo el valor `balance` junto al nombre del algoritmo, que son los que se listan a continuación:

### Round Robin
Este es el método más conocido de todos y lo que hace es distribuir la carga entre todos los servers disponibles detrás del balanceador. Para que sea eficiente, requiere que los servers tengan las mismas características de hardware y aplicaciones.


```language-bash
...
backend super-server
option tcplog
balance roundrobin
...
```

## Static Round Robin
Este método los request son repartidos de forma secuencial entre los nodos disponibles tomando en cuenta el peso que se asigna previamente por quien configura el balanceador. Lo que se hace asignando los pesos es definir la capacidad de cada server. Por ejemplo, si tenemos un servidor (A) que es el doble de potente que (B), a (A) le asignaremos un peso de 100 y a (B) un peso de 50.

```
...
backend super-server
option tcplog
balance static-rr

server A 1.1.1.1 1.1.1.1:80 check 100
server B 1.1.1.1 1.1.1.1:80 check 50
...
```

## Least Connection
Una desventaja de los dos métodos anteriores es que no llevan la cuenta de cuántas conexiones mantiene cada server. Es así como podemos encontrarnos con que el servidor (B) tiene más conexiones abiertas, y por lo tanto más carga, que el servidor (A). En este caso, no tiene sentido que le enviémos más tráfico a (B) porque probablemente se tarde más que (A) en responder un request. 

```
...
backend super-servers
option tcplog
balance leastconn
...
```

## Source
Este método genera un *hash* usando la dirección IP de origen del request que luego será utilizado para enviar los request de esa misma IP al mismo server físico que le contestó por primera vez. Es una especie de *persistencia de sesión* no muy eficiente ya que puede causar que un servidor de cargue más que otro.

```
...
backend super-server
option tcplog
balance source
...
```

## URI
Este método permite verificar partes específicas de la URL, como por ejemplo valores enviados por POST, para determinar a qué server se debe enviar el request. Por ejemplo, podemos definir que un request que contenga en valor "hola" sea enviado al server (A) y un request con el valor "chao" al server (B). En caso de que el request no tenga ninguno de los valores definidos, se enviará el request a donde el método de balanceo por defecto nos diga (round robin).

```
...
backend super-server
option tcplog
balance url_param hola
...
```
