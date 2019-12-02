---
layout: post
title: Localtunnel para compartir nuestro localhost
date: 2013-07-31 00:00:00.000000000 -04:00
---
En la vida de todo freelancer, llega un momento en que hay que tener un entorno de desarrollo visible al mundo. Algunos tienen sus propios servidores (generalmente en casa), mientras que otros alojan su c&oacute;digo en servicios como Amazon.

El problema de esto, es que hay que hacerse cargo de mantener los systemas, cosa que le quita tiempo al *pobre* desarrollador. Por suerte, hay una *gem* llamada [Localtunnel](http://progrium.com/localtunnel/) que lo que hace es abrir un t&uacute;nel entre nuestro localhost (en algun puerto de escucha) con el mundo.

La instalaci&oacute;n es muy simple: `gem install localtunnel` y su uso es igual de simple. Imaginemos que tenemos nuestra app corriendo en el puerto TCP:3000. En ese caso, usamos localtunnel de la siguiente forma:

    (dev*) $ localtunnel -k ~/.ssh/id_rsa.pub 3000
       This localtunnel service is brought to you by Twilio.
       Port 3000 is now publicly accessible from http://57v8.localtunnel.com ...

Luego de eso, compatimos la URL http://57v8.localtunnel.com y nuesta app ser&aacute; visible para el mundo :)
