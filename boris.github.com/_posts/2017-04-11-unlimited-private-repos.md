---
layout: post
title: Unlimited private repos
date: 2017-04-11
---
Si bien [Github](https://github.com) ofrece a un muy buen precio, en algunos
casos no vale la pena. Por ejemplo en mi caso, en que solo lo uso para guardar
algunas configuraciones _sensibles_, no voy a pagar $7 USD por **un solo repo**,
que es lo que finalmente usaré.

Seguro que había alguna otra forma de resolverlo, y esa forma es `git bare`.
Para esto, los materiales son:
  - Un server en algún lugar remoto (como
    [DigitalOcean](https://m.do.co/c/ca2727423015))
  - git (el comando)
  - Conexión ssh con autenticación por llaves públicas/privadas a nuestro
    server.
  - Una terminal.

## How To.
Supongamos que queremos *controlversional* nuestro código ubicado en
`~/Code/sample`. Lo que debemos hacer es inicializar git en ese lugar:

```
~ $ cd ~/Code/sample
~/Code/sample $ git init
```

Por otro lado, en nuestro server debemos crear un nuevo repositorio:

```
~ $ mkdir ~/git
~ $ cd ~/git
~/git $ git init --bare sample.git
```

Volvemos a nuestra máquina local y agregamos un nuevo *remote origin* a nuestro
repo, usando nuestras credenciales de accesso ssh y el path a nuestro **bare
repo**:

```
~ $ git remote add origin boris@git.zsh.io:/git/sample.git
```

Luego de eso, usamos `git` de forma normal.
