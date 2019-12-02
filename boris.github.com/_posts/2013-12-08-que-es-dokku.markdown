---
layout: post
title: ¿Qué es Dokku?
date: 2013-12-08 00:00:00.000000000 -03:00
---
Desde hace un par de meses que vengo estudiando y haciendo pruebas sobre un sistema llamado [Dokku](https://github.com/progrium/dokku), que es una implementación de [PaaS](http://en.wikipedia.org/wiki/Platform_as_a_service) muy pequeña y simple. Dokku utiliza [Docker]({% post_url 2013-11-03-jugando-con-docker-y-nodejs %}) como componente fundamental para proporcionar, en menos de 100 lineas de código, una mini plataforma como la de Heroku.

Además de Docker, Dokku está compuesto principalmente por [Buildstep](https://github.com/progrium/buildstep), [Gitreceive](https://github.com/progrium/gitreceive) y [sshcommand](https://github.com/progrium/sshcommand). Veamos qué hace cada uno de estos componentes:

* Docker: es el encargado de ejecutar y administrar los contenedores donde correrán las aplicaciones. Viendolo desde un punto de vista bastante elevado, es una tecnología similar a la que utilizan los Dynos de Heroku.

* Buildstep: son los buildpacks liberados por Heroku, y se encargan de construir las imagenes base (compilador, librerías y otras cosas) que necesita nuestra aplicación para ser ejecutada. En Heroku se le denomina "stack" y puede ser NodeJs, Ruby on Rails, PHP, Go, etc.

* Gitreceive: es el encargado de proporcionarnos el usuario de git que nos permite hacer push a nuestro repositorio. Además de esto, se encarga de gatillar un evento usando que tomará nuestro push y hará "algo" con el nuevo código. Este "algo" está definido por los [pluginhooks](https://github.com/progrium/pluginhook), que se preocuparán de hacer todo lo necesario para que una vez recibido el push se realicen las acciones requeridas por nuestra aplicación para ejecutarse de forma correcta.

* sshcommand: es un pequeño sistema que permite al usuario ejecutar comandos via SSH, por ejemplo `sshcommand create <user> <command>`.

Ya están abiertas las inscripciones de beta testers para la [Paas en la que estoy trabajando](http://paas.globex.io)
