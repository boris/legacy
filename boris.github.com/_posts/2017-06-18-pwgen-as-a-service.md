---
layout: post
title: pwgen as a service
date: 2017-06-18
---
Este fue mi último _weekend project_. La motivación detrás de esto fue encontrar
un sistema para generar contraseñas seguras que:
- Fuera simple de usar.
- No requiriera instalar nada.
- Pueda ser auditado.
- Fuera web.
- Fuera fácil de deployar.

Entonces me puse a pensar en qué servicios uso frecuentemente que me sirvieran
de inspiración y llegué a [ifconfig.co](http://ifconfig.co). Si bien este
servicio tiene una interfáz web bien simple, yo siempre lo uso con
[curl](https://curl.haxx.se/), básicamente porque **es simple** y **no necesito
instalar nada** para usarlo. 😐

Con eso ya tenía dos de cinco puntos resueltos. Los otros tres eran bastante
claros:
- Utilizar [pwgen](https://linux.die.net/man/1/pwgen), ya que cualquiera que
  esté interesado en saber como funciona lo puede mirar.
- Servirlo via web utilizando algo que no requiera mucha configuración, por lo
  que la opción fue [flask](http://flask.pocoo.org/) y de paso aproveché de
  repasar algunas cosas de python.
- *Dockerizarlo* para que el deploy, en el peor de los casos,  pase a ser algo
  tan simple como `docker pull ; docker restart`.

Debo reconocer que cuando estaba pensando en cómo resolver este problema imaginé
que me tomaría más tiempo, que al final fueron como dos horas de trabajo
efectivo desde el `python -m venv` hasta el `git push`, pero al final quedé
bastante conforme porque pude desarrollar algo que si bien tiene muchas cosas
pendientes y otras que me gustaría agregar, terminó quedando como algo
perfectamente funcional.

## How it works and how to use it
La forma de uso más común, y que en realidad son las "necesidades" que he
tenido, son dos:
- Generar una contraseña de largo X
- Generar N contraseñas de largo X

Lo anterior en realidad se reduce a **N contraseña(s) de largo X**.

Para conseguir esto, se me ocurrió que el `curl` utilizara dos argumentos en la
URL, uno siendo **N** y el otro siendo **X** (obvio), lo que llevaría la contrucción de
la URL a algo como **servicio.com/N/X** y aquí apareció el primer problema: ¿Por
qué pasar un 1 (como N) cuando quiero solo UNA contraseña? El razonamiento de
esto viene dado porque en general he necesitadao crear contraseñas de a una:
para **un** usuario de base datos, para **un** usuario de vpn, contraseña de
sudo para **un** usuario nuevo, y así. Casi siempre de a uno.

Entonces, ¿por qué no mejor dejar **N=1** como valor por defecto? Me pareció
buena idea, así que tuve que cambiar el orden de los argumentos de la URL que
finalmente quedó así: **servicio.com/X/N** donde **N** es opcional.

Una vez construida la URL, el servicio llama a una función que ejecuta el módulo
python de `pwgen` y le pasa como parámetros los dos argumentos de la URL, largo
y cantidad, y devuelve la cantidad de contraseñas necesarias todas generadas de
forma *random*. En caso de no recibir el parámetro de "cantidad" devolverá sólo
una.

Y en la vida real, toda la mentira de arriba funciona en
[pwgen.zsh.io](http://pwgen.zsh.io) y se usa así:

```
➜ curl pwgen.zsh.io/15/3
g$tl84ymZ2FxSSn         
iFV$SB17GxfpPqU         
3PV&oga8H7GXMaI         
➜ curl pwgen.zsh.io/15
tsGpOj{eeUQwsbC       
```

Y, tal como pedía el último requermiento, esto lo metí en una imagen Docker que
está [disponible aquí](https://hub.docker.com/r/boris/pwgen-web/).

Finalmente, hice algunas pruebas para ver el perfomance de este sistema, ya que
la idea es que fuera rápido. Y llevándolo a valores absurdos, como por ejemplo
[generar 100 contraseñas de largo 150](http://pastebin.ubuntu.com/24896803/) en
poco más de un segundo, o [500 contraseñas de largo
150](http://pastebin.ubuntu.com/24896846/) en poco menos de dos segundos.

Si bien hay muchas cosas que se pueden mejorar aun, por el momento cumple los
requisitos que definí al comienzo. Podría haber usado directamente `pwgen` o
[la imagen de pwgen que hice hace un
tiempo](https://hub.docker.com/r/boris/pwgen/) pero en esta pasada quería algo
que no necesitara instalar nada, y quedé conforme :)

-----
¿Quieres mirar el código? [Está acá](https://github.com/boris/pwgen).
