---
layout: post
title: IPTABLES para OpenStack
date: 2013-04-20 23:28:00.000000000 -03:00
---
Hoy naci&oacute; mi nuevo server. Se llama [wardenclyffe](http://en.wikipedia.org/wiki/Wardenclyffe_Tower) y por ahora est&aacute; corriendo con [OpenStack](http://www.openstack.org).

Un tema importante en todo esto es la configuraci&oacute;n de la red. Para evitar problemas futuros (y por flojera) en caso que se agreguen m&aacute;s nodos de c&oacute;mputo, la red est&aacute; configurada bajo 10.0.0.0/8 en la interf&aacute;z `br100`. Con esto, cualquier instancia que levantemos tomar&aacute; IP a partir de la 10.0.0.2 y podr&aacute;n comunicarse todas con todas siempre que esto sea permitido por el *Security Group* al cual pertenece cada instancia, ya que por default hay un `deny all`.

Respecto al t&iacute;tulo de este post: Una vez que se levanta una nueva instancia, &eacute;sta se *conecta* al `br100` el cual deber&iacute;a darle salida al mundo, pero no! Esto se debe a que OpenStack no tiene idea qu&eacute; direccionamiento de red ocuparemos, ni qu&eacute; intefaces usaremos. No sabe si nuestra WAN est&aacute; conectada a la `eth0` o a la `eth24.500-03`. No sabe si el bridge que usaremos est&aacute; en `br0` o, como en mi caso, en el `br100`. Por esta raz&oacute;n no se preocupa de generar ninguna regla de **iptables** que haga el *forward* del tr&aacute;fico de datos. Entonces, c&oacute;mo lo hacemos? F&aacute;cil: primero creamos una regla de **iptables** y luego nada, porque con eso es suficiente. La regla la creamos as&iacute;:

{% highlight bash%}
boris@wardenclyffe:~$ sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
boris@wardenclyffe:~$ sudo iptables -A FORWARD -i br100 -j ACCEPT
{% endhighlight %}

De lo anterior podemos decir:

1. Mi salida al mundo es por la `eth1`.
2. Mis instancias de OpenStack est&aacute;n conectadas al `br100`.

En caso de que sus configuraciones de red sean diferentes, obviamente tendr&aacute;n que cambiar a la interf&aacute;z que corresponda, adem&aacute;s de asegurarse que su bit de *forward* para IPv4 est&aacute; habilitado:

{% highlight bash %}
boris@wardenclyffe:~$ cat /proc/sys/net/ipv4/ip_forward
1
{% endhighlight %}
