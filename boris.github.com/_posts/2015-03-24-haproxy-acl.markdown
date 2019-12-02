---
layout: post
title: HAProxy ACL
date: 2015-03-24 00:00:00.000000000 -03:00
---
[HAProxy](http://www.haproxy.org/) debe ser, junto a [Nginx](http://nginx.org) una de las mejores piezas de software jamás credas. Es un software liviano, eficiente y capaz de manejar miles de conexiones concurrentes. 

Generalmente se usa como *balanceador de carga* pero tiene otros *features* muy interesantes. Uno de estos features son sus **Listas de Control de Acceso**, o Access Control Lists.

## Qué son?
Las listas de control de acceso son reglas que se usan para determinar permisos para un objeto determinado, en base a aspectos determinados. Por ejemplo, una lista de control de acceso podría ser "Sólo se permite el acceso si viste traje y corbata".

## Cómo funcionan?
En general las ACL funcionan de la misma forma: Una vez que se genera un request, este lee cada una de las reglas de arriba a abajo, de izquierda a derecha. Si hace *match* con alguna, la utilizará y se completará el request usando esa regla. Si no hace *match* con ninguna, el request leerá todas las reglas, por lo que siempre es conveniente dejar al final una regla que pueda manejar cualquier caso no previsto en las reglas anteriores, como por ejemplo un `deny all` o algo así.

En HAProxy el funcionamiento es el mismo, pero como siempre es más simple explicar con un ejemplo, acá va:

```
frontend local-secure
  mode http
  bind *:443 ssl crt /path/to/bundle.pem
  reqadd X-Forwarded-Proto:\ https
  default_backend EXTERNAL
  option http-server-close
  option httpclose
  acl MYACL src 10.10.10.10/8
  use_backend INTERNAL if MYACL

backend EXTERNAL
  mode http
  balance roundrobin
  server local 0.0.0.0:1337 check weight 1

backend INTERNAL
  mode http
  balance roundrobin
  server not-local 0.0.0.0:80 check weight 1
```

La configuración anterior es bastante simple y nos dice que por default todos los requests se irán al `backend EXTERNAL` y verán el servicio que está levantado en el puerto 1337. La única diferencia es que si el request viene desde la red `10.10.10.10/8`, el backend utilizado será el `backend INTERNAL` y se verá el servicio que está en el puerto 80.
