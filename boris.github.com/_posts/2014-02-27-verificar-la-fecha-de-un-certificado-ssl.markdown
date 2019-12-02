---
layout: post
title: Verificar la fecha de un certificado ssl
date: 2014-02-27 00:00:00.000000000 -03:00
---
Este más que un post es un tip muy útil ya que generalmente se nos olvida cuando generamos un certificado SSL, por ejemplo, para nuestro servidor web.

Para averiguarlo debemos ejecutar lo siguiente:

{% highlight bash %}
$ openssl x509 -noout -dates -in /path/to/file.crt
notBefore=Jul 12 02:48:29 2012 GMT
notAfter=Jul 14 22:07:28 2014 GMT
{% endhighlight %}

Ahora que conocemos la fecha, podemos dejar alguna alerta en nuestro calendar para unos días antes del vencimiento...
