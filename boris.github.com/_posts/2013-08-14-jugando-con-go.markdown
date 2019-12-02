---
layout: post
title: Jugando con Go!
date: 2013-08-14 00:00:00.000000000 -04:00
---
Hace un tiempo que vengo haciendo algunas csas en un lenguaje llamado [Go](http://www.golang.org). Lo conoc&iacute; cuando estuve trabajando en [.se](http://en.wikipedia.org/wiki/Gothenburg), me lo present&oacute; un amigo de Nepal y durante un par de meses no hice nada por aprender dicho lenguaje.

Pero hace un tiempo, en momento de ocio, decid&iacute; darle una oportunidad, luego de leer un post en [StackOverflow](http://stackoverflow.com) donde se discut&iacute;an sus ventajas y desventajas:

* Compila muy r&aacute;pido
* Soporta concurrencia a nivel del lenguaje
* Tiene un garbage collector

Para los que tienen background en C y/o Java (ZZzzz..), les ser&aacute; muy f&aacute;cil la adaptaci&oacute;n- Aqui les dejo un pequeño ejemplo:

{% highlight go %}
package main

import "fmt"

func main() {
   fmt.Println("hola mundo!")
}
{% endhighlight %}

Lo de arriba es el contenido de un archivo llamado `hello.go`, el cual se ejecuta de la siguiente forma:

`$ go run hello.go`

Ahora, si queremos compilar nuestro c&oacute;digo, es tan simple como ejecutar:

`$ go build hello.go`

Esto generar&aacute; un binario:

{% highlight bash %}
$ ls
total 1244
-rwxrwxr-x 1 boris boris 1267654 Aug 14 10:03 hello
-rw-rw-r-- 1 boris boris      77 Aug 14 10:03 hello.go
{% endhighlight %}

El binario generado podemos compartirlo y puede ser ejecutado en cualquier maquina que tenga un interpete de Go.

Espero el fin de semana poder escribir sobre el uso que le estoy dando a Go para mis daily-devops-tasks :D
