---
layout: post
title: Docker multi-stage builds
date: 2018-03-06
---
Un feature intersante, y que permite reducir de forma considerable el tamaño de
las imágenes de Docker, es usar **multi stage build**.

Los **multi stage builds** fueron introducidos a partir de Docker 17.05 y su
objetivo principal es "building images is keeping the image size down". Para
esto, debemos modificar un poco la estrucutura de nuestro Dockerfile y la mejor
forma de observalo es con un ejemplo.

En este ejemplo usare dos imágenes, `golang:latest` de 779MB y `alpine:latest`
de 3.99MB. Lo que haré seré compilar un pequeño código en go, primero utilizando
un método *tradicional* y luego con **multi-stage builds**.

## El código de prueba, súper complejo.

```golang
package main
import "fmt"
func main() {
    fmt.Println("hello world")

}
```

## Dockerfile "tradicional".
La estructura del Dockerfile utilizando el método tradicional sería algo como
esto:

```
FROM golang:latest
COPY hello.go
RUN go build hello.go
```

A lo anterior ejecutamos el build, verificamos el tamaño de la imágen y probamos
si funciona:
```
 ➜ docker build -t boris/multistage:1.0 .
Sending build context to Docker daemon  3.072kB
Step 1/3 : FROM golang:latest
 ---> 1c1309ff8e0d
Step 2/3 : COPY hello.go .
 ---> fb1a753278a6
Step 3/3 : RUN go build hello.go
 ---> Running in 51f6a4520e36
Removing intermediate container 51f6a4520e36
 ---> 1b5bc3b63fc9
Successfully built 1b5bc3b63fc9
Successfully tagged boris/multistage:1.0

➜ docker images boris/multistage
REPOSITORY          TAG    IMAGE ID          CREATED             SIZE
boris/multistage    1.0    1b5bc3b63fc9      12 seconds ago      781MB

➜ docker run boris/multistage:1.0 /go/hello
hello world

➜ docker run boris/multistage:1.0 ls -lh /go/hello
-rwxr-xr-x 1 root root 2.0M Mar  6 14:36 /go/hello
```

Ya tenemos nuestra imagen, de 781MB que contiene un binario de 2.0MB. Algo acaba
de dejar de tener sentido...

## Multi-stage build
Ahora repetiremos el proceso, pero haciendo algunas modificaciones al Dockerfile
anterior:

```
FROM golang:latest as builder

COPY hello.go .
RUN go build hello.go

FROM alpine:latest
COPY --from=builder /go/hello /usr/local/bin/hello
```
Ejecutamos los mismos pasos que antes y verificamos:

```
➜ docker build -t boris/multistage:1.1 .
Sending build context to Docker daemon  3.072kB
Step 1/5 : FROM golang:latest as builder
 ---> 1c1309ff8e0d
Step 2/5 : COPY hello.go .
 ---> Using cache
 ---> fb1a753278a6
Step 3/5 : RUN go build hello.go
 ---> Using cache
 ---> 1b5bc3b63fc9
Step 4/5 : FROM alpine:latest
 ---> 4a415e366388
Step 5/5 : COPY --from=builder /go/hello /usr/local/bin/hello
 ---> b3ebaf96dd5e
Successfully built b3ebaf96dd5e
Successfully tagged boris/multistage:1.1

➜ docker images boris/multistage
REPOSITORY          TAG    IMAGE ID          CREATED             SIZE
boris/multistage    1.1    b3ebaf96dd5e      4 seconds ago       6.01MB
boris/multistage    1.0    1b5bc3b63fc9      13 minutes ago      781MB

➜ docker run boris/multistage:1.1 hello
hello world

➜ docker run boris/multistage:1.1 ls -lh /usr/local/bin/hello
-rwxr-xr-x 1 root root 1.9M Mar  6 14:36 /usr/local/bin/hello

```

Y es así como rápidamente se pasa de una imagen de 781MB a una de 6.01MB, con el
mismo contenido.

Lo anterior lo probé hace unos días en el trabajo y pude pasar una imagen de
1.7GB a poco más de 180MB que contenía una aplicación en java.

En caso de que alguien necesite el ejemplo, está [disponible en
github](https://github.com/boris/docker/tree/master/multistage).
