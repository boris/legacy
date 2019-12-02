---
layout: post
title: Some notes about Docker
date: 2015-11-30 12:34:08.000000000 -03:00
---
Hace tiempo vengo haciendo pruebas con [Docker](https://docker.com) y no había tenido tiempo de escribir al respecto. Pero no daré la lata con filosofía sobre contenedores o sobre "contenedores vs. virtualización", sino que iré al grano. Acá el índice:

- [¿Cómo instalar Docker en OS X?](#install)
- [Comandos básicos (pull, run, build, push)](#commands)
- [Levantar un contenedor y acceder a él](#run)

### ¿Cómo instalar Docker en OS X?<a name="install"></a>
La forma más fácil de instalar Docker en OS X, sin depender de un servidor remoto es [usando esto](https://docs.docker.com/mac/step_one/). "Esto" instalará el una máquina virtual sobre VirtualBox y configurará una terminal capaz de conectarse a este servicio Docker.
Una vez que la instalación haya terminado y ejecutemos la terminal, veremos algo como esto:
![](/content/images/2015/12/Screen-Shot-2015-12-09-at-20-32-23-1.png)

### Comandos básicos (pull, run, build, push)<a name="commands"></a>
En docker tenemos 39 comandos disponibles para interactuar con nuestros contenedores. Acá explicaré sólo los más comunes:

`docker pull`: Traerá del *registry* una imagen o repositorio docker. Esta imagen luego quedará disponible para usar con `docker run`.

```
$ docker pull ubuntu
$ docker pull boris/redis:2.6.14
```

`docker run`: Permite ejecutar comando en un nuevo contenedor. Lo que hace es crear un contenedor con permisos de escritura sobre la imagen especificada y luego ejecuta el comando que le entregamos. Tiene algunas opciones interesantes como `-i` y `-t` que se encargan de mantener el STDIN abierto (incluso cuando no está *attached*) y de levantar un `pseudo-TTY`, respectivamente.

```
$ docker run -i -t ubuntu:latest /bin/bash
$ docker run busybox /bin/sh
```

Con los dos comandos anteriores ya nos podemos hacer de nuestro ambiente docker. Lo que viene ahora es crear nuestro propio Dockerfile, hacer el build y subirlo a [DockerHub](https://hub.docker.com).

`docker build`: Se encarga de construir imágenes docker desde un Dockerfile y en un contexto determinado. Ejemplos de build:

```
$ docker build -t boris/ubuntu-base:latest .
$ docker build https://github.com/docker/rootfs.git#container:docker
$ docker build - < Dockerfile
```

`docker push`: Una vez que tenemos creada nuestra imagen, debemos subirla a DockerHub para que esté disponible para todos. Para esto, lo primero que tenemos que hacer, después de crearnos una cuenta en DockerHub, es autenticarnos:

```
$ docker login
```
Luego de eso, podremos hacer un *push* con nuestra imagen:

```
$ docker push boris/redis:2.6.14
```
Con el comando anterior, nuestra imagen quedará disponible [aquí](https://hub.docker.com/r/boris/redis/).

### Levantar un contenedor y acceder a él<a name="run"></a>
Ya vimos más arriba que para levantar un contenedor debemos usar el comando `docker run` con algunas opciones. La sintaxis de este comando es:

```
$ docker run [opciones] imagen [comandos]
```

Por ejemplo, para levantar un contendor de Ubuntu sobre el cual ejecutar bash y mantener la consola interactiva (`-i`) *attachada* (`-t`), debemos hacer lo siguiente:

```
$ docker run -t -i ubuntu /bin/bash
```
![](/content/images/2015/12/Screen-Shot-2015-12-15-at-9-19-36-AM.png)

Cuando salimos del contenedor, este se detiene pero no se elimina. Lo podemos ver si hacemos un `docker ps -a`. Para volver a entrar a nuestro contenedor debemos iniciarlo (`start`) y luego conectarnos (`attach`):

```
$ docker ps -a
$ docker start <CONTAINER ID>
$ docker attach <CONTAINER ID>
```

![](/content/images/2015/12/Screen-Shot-2015-12-15-at-9-22-19-AM.png)


