---
layout: post
title: Single Point of Failure
date: 2013-02-17 18:47:25.000000000 -03:00
---
Es comun actualmente que el código de nuestras aplicaciones esté en [Github](http://github.com) o en algún otro sistema de control de versiones. Es comun, también, que al momento de hacer _deploy_ la lógica sea más o menos:

- Hacer un pull del código que queremos
- Correr scripts de instalación (compilación de assets, instalación de dependencias, etc)
- Reiniciar algún servicio que se tenga que reiniciar

Esto funciona bastante bien cuando tenemos pocos servidores en producción (hasta 3 o 4 creo que es aceptable), pero qué ocurre cuando tenemos 10? 20? 100? Cómo es la lógica del deployment en este caso? Veamos un ejemplo:

Supongamos que tenemos un solo servidor de aplicaciones y que al momento del deploy seguimos los puntos de más arriba (traernos la última versión del código, instalar lo que tengamos que instalar y reiniciar uno que otro servicio) y que todo este proceso nos toma 5 minutos. Perfecto! 5 minutos de deployment time no está mal. Pero, qué pasa si tenemos 10 servidores? Ése tiempo aumentaría a 50 minutos? No. El tiempo de deployment **no es lineal** ya que podemos hacer deploy en varios servidores a la vez. Pero aún así, el tiempo de deployment será alto y nos seguiremos encontrando con un cuello de botella: Github.

Por alguna razón la gente insiste en traer la última versión del código directamente del repositorio. Si tenemos el código en Github nos encontraríamos con la limitante de nuestro ancho de banda: Tendríamos que traer todo el código tantas veces como servidores tengamos. Pero por otro lado, si el código lo tenemos en nuestro propio servidor de Git, llegará un determinado instante de tiempo en que varios servidores dirán "oh sí, necesitamos traernos este pedazo de código". Entonces nuestro pobre servidor de Git tendrá que __servir__ el último código a muchos servidores a la vez. Y no está diseñado para eso!

Cómo solucionarlo? Hay gente que dice que [Capistrano](https://github.com/capistrano/capistrano) es una solución, pero de acuerdo a mi experiencia (y a mi crítica) no resuelve el problema de ir a Github a buscar el código tantas veces como servidores tengamos. Una buena opción para resolverlo es usar [Murder](https://github.com/lg/murder). Más adelante escribiré un post sobre eso, por ahora sólo dejo planteada la inquietud...
