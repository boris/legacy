---
layout: post
title: Entendiendo lo que top nos quiere decir
date: 2014-06-09 00:00:00.000000000 -04:00
---
[Top](http://www.unixtop.org/top1.html) es una de las herramientas más utilizadas cuando queremos saber el estado de alguno de nuestros servidores. Lo que hace es mostrarnos información actualizada de los procesos que están usando CPU.

![top](../images/top.png)

Lo que muestra la imagen es `top` corriendo, donde podemos ver los procesos, uptime, uso de cpu, memoria, etc. Lo importante es lo que está marcado con rojo:

- us: Tiempo de CPU utilizado en el User Space
- sy: Tiempo de CPU utilizado en el Kernel Space
- ni: Tiempo de CPU utilizado por procesos de baja prioridad (nice)
- id: Tiempo de CPU sin uso (idle)
- wa: Tiempo de CPU utilizado escribiendo/leyendo de disco (io wait)
- hi: Tiempo de CPU utilizado sirviendo o manejando interrupciones de hardware (hardwaure irq)
- si: Tiempo de CPU utilizado sirviendo o manejando interrupciones de software (software irq)
- st: Tiempo de espera (involuntario) de una CPU virtual (vCPU) mientras el hypervisor está sirviendo otro proceso (otra máquina virtual)

### ¿Qué hay que tener en cuenta?

Depende. Cada servidor es diferente y por lo tanto no existe una receta para ver si una máquina está sobre cargada o no. Lo que sí, siempre es bueno hacernos algunas preguntas que nos ayudarán a determinar si nuestro servidor está con mucha carga o no:

- ¿Qué procesos están corriendo?
- ¿Qué procesos están consumiendo la mayor cantidad de tiempo de CPU?
- ¿Deberían estos procesos consumir tanta CPU? (Sí, tenemos que conocer nuestra aplicación)
- ¿Hay otro tipo de consumo de CPU anormal? (En este caso debemos fijarnos en **st** y **wa**)

### Impacto en los servicios (caso de la vida real)

Esto ocurrió **justamente hoy**(9 de Junio de 2014): Uno de los servidores con [Redis](http://redis.io) comenzó a utilizar mucha carga durante mucho tiempo. En otras palabras y en buen chileno: "estaba pegada en 100 todo el rato", lo que nos dejaba en una posición perfect para entregar timeouts a nuestros usuarios y excepciones en nuestro mail... Horror.

Junto a un compañero de labores, utilizamos **top** (en reliadad usamos pagent. Pronto más info sobre eso) para analizar el comportamiento de la máquina en términos de CPU y memoria, teniendo en cuenta que Redis usa memoria, mucha memoria. Al analizar **top** notamos que Redis no usaba mucho tiempo de CPU y que la memoria en uso era normal. Entonces, WTF?! 

Simple (claro, ahora parece simple): Redis tiene una variable llamada `save` y está definida así:

{% highlight bash %}
save 900 1
save 300 10
save 60 10000
{% endhighlight %}

Eso nos dice que Redis guardará en disco cada 900 segundos si al menos una *key* cambió, cada 300 segundos si cambiaron al menos 10 y cada 60 segundos si al menos 10000 keys cambiaron. En nuestro caso, en 60 segundos cambian al rededor de 500.000 keys, por lo tanto el *guardado a disco* se hacía con una frecuencia mayor que el tiempo que éste tenía para terminar, lo que provocaba un cuello de botella.

Solución? Aumentar la frecuencia, con lo que la configuración de Redis quedó así:

{% highlight bash %}
save 900 1
save 300 10
save 300 10000
{% endhighlight %}

Con esto bajamos la carga de 100% a menos del 20%, con algunos peaks cada vez que se debe guardar en disco la información de Redis, proceso que no dura más de un minuto.

Sin **top** (ni *PAgent*) no hubieramos podido resolver esto :)

