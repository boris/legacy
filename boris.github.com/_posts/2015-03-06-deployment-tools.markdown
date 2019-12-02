---
layout: post
title: Deployment Tools
date: 2015-03-06 00:00:00.000000000 -03:00
---
Contexto:

  - Aplicación Ruby on Rails
  - Muchos servidores
  - Requerimiento: 0 downtime deploy

Con eso en mente, la alternativa natural sería [Capistrano](http://capistranorb.com), que de hecho es lo que usamos actualmente. Pero por alguna razón, siento que el deploy se demora mucho (al rededor de 3 minutos).

Frente a esta preocupación, la pregunta obvia fue: ¿Por qué? ¿Por qué chucha Capistrano es *tan* lento? Ya que, a mi entender, el deploy debería consistir en:

  - Update del código
  - Bundle install
  - Compilación de assets
  - Restart de aplicación

Para el Update del código hay varias estrategias. La más común es la que hace capistrano, manteniendo un directorio `releases`, pero no lo encuentro muy eficiente que digamos. En su lugar me preocuparía de hacer un `git pull` o algo similar.

Ahora, si tenemos en cuenta que el `bundle install` sólo debemos ejecutarlo si algo cambió en nuestro `Gemfile` (a.k.a. sólo debería ejecutrase de ser necesario), por qué se ejecuta siempre? Esa tarea podría ser opcional... Lo mismo ocurre con la compilcación de assets. Por qué compilar si nada se ha modificado?

Con esto en mente, el proceso de deploy se podría dividir así:

  - Update del código
  - Bundle install (sólo si es necesario)
  - Complicación de assets (sólo si es necesario)
  - Restart de aplicación

A esto debemos sumar una tarea sumamente importante, que es el control de errores. Es necesario saber qué falló y donde falló. Una vez que algo falla, el deploy debería finalizar manteniendo la configuración (código) anterior. Esta es la razón por la cual Capistrano implementa el directorio releases. Por esta razón, el listado final de tareas que se debe realizar durante un proceso de deploy creo que debería ser:

  - Update del código
  - Bundle install (if necessary)
  - Compilación de assets (if necessary)
  - Symlink al latest release
  - Restart de aplicación

Hoy, por ejemplo, tuve que hacer deploy 7 veces (hotifx friday) y el tiempo promedio fue de 3 minutos, lo cual considero mucho tiempo. Existe alguna herramienta más rápida o tendremos que hacerla nosotros mismos?

Qué usa el resto del mundo?

