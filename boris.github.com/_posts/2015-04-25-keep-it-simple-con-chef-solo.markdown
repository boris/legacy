---
layout: post
title: Chef solo por un día
date: 2015-04-25 00:00:00.000000000 -03:00
---
Si bien soy bastante fan de [chef-server](http://docs.chef.io/server/), ayer tuve que ponerme a configurar una instancia para un proyecto en particular. Si bien la configuración necesaria es bastante simple, aproveché la oportunidad para usar [chef-solo](https://docs.chef.io/chef_solo.html).

El proceso de configuración es bastante simple, y todo puede ser manejado a la
*ruby-way* usando un `Gemfile`.

## Chef-solo, Vagrant, Berkshelf
El setup que decidí utilizar contiene las tres herramientas del título de esta
sección, aunque en regior `vagrant` es opcional, decidí incluirlo para poder
replicar el mismo ambiente fácilmente.

Mi configuración actual cuenta con un `Gemfile` bastante simple, con el
siguiente contenido:

```Gemfile
source "https://rubygems.org"

gem "knife-solo"
gem "berkshelf"
```

Además de eso hay un `Vagrantfile`, que luego subiré a [github](https://github.com/boris), y que tiene como objetivo poder aislar el ambiente `chef-solo` para no tener que instalar `gems` en nuestro sistema host.

## Un caso "real"
Para esta prueba, lo que intenté fue levantar una máquina [1] e instalarle Nginx, PHP5.4 y MySQL, por lo tanto las recetas serían `nginx`, `php` y `mysql` más todas sus dependencias, que serían manejadas por `Berkshelf`.

Una vez está la máquina, lo primero que debemos hacer es el `bootstrap`:

```bash
knife solo bootstrap usuario@server
```

Lo que ocurrirá aquí es que `knife` se conectará al server, instalará Chef, copiará los cookbooks que le hayamos pasado en el archivo `nodes/server.json` y luego ejecutará Chef.

La estructura de este archivo es bien simple y define de manera clara qué debe ejecutar chef en cada máquina.

```json
{
  "run_list": [
    "recipe[php]",
    "recipe[packages]"
    ]
}
```

Y eso sería todo. De ahí en más, cuando hagamos algun cambio en las recetas que se aplican a alguna máquina en particular y queremos que chef se encargue, sólo debemos ejecutar `knife solo cook usuario@server`.

## Comentarios finales
Si bien la experiencia usando chef-solo me pareció demasiado agradable y simple, el único problema que le encontré es la escalabildad. No imagino la administración de muchos servidores utilizando esta alternativa, pero para pocas máquinas es una excelente opción.

Respecto a las recetas utilizadas en la prueba, todas están disponibles tanto vía `Berkshelf` o [en mi repositorio chef](https://github.com/boris/chef) en
Github.

* * *

[1] Una máquina en [DigitalOcean](https://digitalocean.com), si quiere puede
usar mi [referral code](https://www.digitalocean.com/?refcode=ca2727423015).
