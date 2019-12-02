---
layout: post
title: Monitoreo de infraestructura con SensuApp
date: 2015-08-13 12:08:31.000000000 -03:00
---
[SensuApp](https://sensuapp.org) es un framework de monitoreo de *cualquier cosa* en *cualquier lenguaje*. Esto quiere decir que podemos monitorear cualquier servicio que tengamos (Apache, Nginx, MySQL, Redis, Custom services, etc) y que los *checks* para estos servicios podemos escribirlos en el lenguaje que queramos (Ruby, Golang, BASH, Python, etc.)

El funcionamiento interno de SensuApp se explica mejor con la siguiente imagen:
![](https://sensuapp.org/docs/0.17/img/sensu-diagram-87a902f0.gif)

La explicación de la imagen de arriba es muy simple: El server pide, a través de RabbitMQ el estado de un check, en este caso `check-http.rb`. Los clientes que son parte de esa subscripción[^1] ejecutarán el check y reportarán su estado a RabbitMQ, quien se lo reportará al server y este persistirá el estado en Redis, que luego será notificado a la API. Desde ahí puede ser leído por algún servicio externo (PagerDuty, Slack, etc) o por algún dashboard.

De aquí en adelante, asumiré que estamos usando Ubuntu 14.04 LTS tanto para el server como para los clientes.

### Instalación y configuración del Server
Simple as hell:

```bash
sudo aptitude update
sudo aptitude install sensu
```

El paquete sensu se encargará de instalar RabbitMQ y Redis. Lo único que nos queda por hacer es configurar los servicios.

Si asumimos que "el server" es una sola instancia, la configuración es muy simple:

```json
{
  "rabbitmq": {
    "host": "localhost",
    "vhost": "/sensu",
    "user": "sensu",
    "password": "supersecret" 
  },
  "redis": {
    "host": "localhost"
  },
  "api": {
    "host": "localhost",
    "port": 4567
  }
}
```

Luego de eso: `sudo service sensu-service restart` y listo. Lo que nos queda ahora es implementar un primer **check** a modo de prueba.

En el lado del servidor, lo único que necesitamos es la **definición del check** en donde se llame al script que hará el check. Esta definición es un archivo que dejamos en `/etc/sensu/conf.d` y cuyo nombre debe comenzar con `check`. Por ejemplo `check_webserver.json`.

```json
{
  "checks": {
    "check_webserver": {
      "command": "/etc/sensu/plugins/check_webserver.rb",
      "subscribers": [
	        "webserver"
      ],
      "interval": 10
    }
  }
}
```

El check anterior se ejecutará cada 10 segundos sólo en las máquinas cuya "subscripción" sea *webserver*.

### Instalación y configuración de clientes
La instalación en los clientes es igual de simple que en el server, ya que el paquete `sensu` instala tanto server como client. Lo único que tenemos que hacer es configurar el cliente. Para esto usamos el archivo `/etc/sensu/conf.d/client.json`:

```json
{
  "client": {
    "name": "webserver-0",
    "address": "1.2.3.4",
    "subscriptions": [
      "webserver"
    ]
  }
}
```

Suponiendo que uno de nuestro Webserver corre Nginx, haremos un pequeño script en Ruby para verificar que el proceso Nginx este corriendo. 

```ruby
#!/usr/bin/env ruby

processes = `ps aux`

running = processes.lines.detect do |process|
  process.include?('nginx')
end

# return appropriate check output and exit status code
if running
  puts 'OK - Nginxis running'
  exit 0
else
  puts 'WARNING - Nginx is NOT running!!'
  exit 1
end
```

El archivo anterior será `/etc/sensu/plugins/check_webserver.rb` y estará alojado **solo en los clientes**.

Una vez que tenemos la configuración del cliente y el check, reiniciamos el cliente: `sudo service sensu-client restart`.

### Dashboard
El mejor(?) dashboard que encontré para Sensu es [Uchiwa](https://uchiwa.io). La instalación es *idiot-proof* `sudo aptitude install uchiwa` y la configuración anda por las mismas. Acá el contenido del archivo `/etc/sensu/uchiwa.json`

```json
{
  "uchiwa": {
    "user": "user",
    "pass": "passwd",
    "refresh": 5,
    "host": "0.0.0.0",
    "port": 3000
  },
  "sensu": [
    {
      "name": "SensuApp",
      "host": "127.0.0.1",
      "url": "http://127.0.0.1:4567",
      "path": "",
      "ssl": false,
      "timeout": 5
    }
  ]
}
```

### Integración con Chef

Ya que la integración con un sistema que administre configuraciones es importante, dejaré esto acá sólo para que no se me olvide...

![](http://www.dumpaday.com/wp-content/uploads/2013/05/a-cat-in-the-toilet-soon-meme.jpg)

[^1]: Lo veremos más adelante

