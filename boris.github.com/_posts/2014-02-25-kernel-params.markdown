---
layout: post
title: TCP Kernel Params
date: 2014-02-25 00:00:00.000000000 -03:00
---
{{ content | emojify }}
En este post hablaré sobre un par de parámetros del kernel que nos ayudarán a manejar un mayor número de conexiones. Es una buena idea implementarlos en cualquier server que esté de cara al usuario final, como por ejemplo balanceadores de carga :wink:

Los parámetros en cuestión son los siguientes:

`ip_local_port_range` define la cantidad de puertos que pueden ser utilizados para conexiones con el cliente. En otras palabras, define la cantidad de conexiones activas simultáneas que el servidor puede manejar.

{% highlight bash %}
# sysctl net.ipv4.ip_local_port_range
net.ipv4.ip_local_port_range = 32768    61000
net.ipv4.ip_local_port_range = 1024	    65535
{% endhighlight %}

`tcp_tw_reuse` permite que los sockets en estado `TIME_WAIT` puedan ser utilizados por nuevas conexiones.

{% highlight bash %}
# sysctl net.ipv4.tcp_tw_reuse
net.ipv4.tcp_tw_reuse = 0
net.ipv4.tcp_tw_reuse = 1
{% endhighlight %}
