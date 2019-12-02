---
layout: post
title: Qué es Heartbleed y cómo nos afecta
date: 2014-04-08 00:00:00.000000000 -03:00
---
Ayer 7 de Abril de 2014 supimos de la existencia de una [vulnerabilidad](https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2014-0160) bastante grave en OpenSSL. Por si los que leen esto no son tan *geeks*, les cuento que OpenSSL es una librería criptográfica que se encarga aproximadamente del 99.999999% de las comunicaciones seguras en Internet. Para que les quede más claro, es la que se encarga de que todas las páginas HTTPS sean seguras y que los datos que enviamos, por ejemplo a nuestro banco, no los vea nadie que no debe. El tema es que esta vulnerabilidad permite a un atacante obtener información sensible. Específicamente las llaves que protegen la comunicación, las contraseñas de los usuarios, etc.

El problema mayor de esta vulnerabilidad es que dejó al descubierto una gran cantidad de llaves privadas y otro tipo de contendio secreto, el cual podía ser accedido desde cualquier punto de Internet. Lo peor: quien se aprovechara de esto no dejaría rastro, ya que en este nivel (y por razones obvias) no se guardan logs.

##Solución

Actualizar a libssl1.0.0 :)
{% highlight bash %}
$ sudo apt-get update ; sudo apt-get install --only-upgrade libssl1.0.0
{% endhighlight %}

##Más información:

* [Heartbleed](http://heartbleed.com/)
* [Cómo funciona](http://security.stackexchange.com/questions/55116/how-exactly-does-the-openssl-tls-heartbeat-heartbleed-exploit-work)

### Update:
Una buena idea es firmar nuevamente cualquier certificado SSL que tengamos. La razón de esto radica en que **no sabemos** si alguien ya obtuvo nuestros datos y pueda suplantar nuestra identidad. 
