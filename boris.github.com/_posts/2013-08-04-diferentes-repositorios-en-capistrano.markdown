---
layout: post
title: Diferentes repositorios en Capistrano
date: 2013-08-04 00:00:00.000000000 -04:00
---
En donde estoy trabajando actualmente, mantenemos el c&oacute;digo en neustro propio servidor de git, y debido a esto (creo), me encontr&eacute; con el siguiente problema:

**El problema**  
El repositorio local est&aacute; en `http://git.ejemplo.com` y el repositorio remote est&aacute; en `http://git.ejemplo.com:8081`. Esto es as&iacute; gracias a las "medidas de seguridad" de nuestro firewall...

**La soluci&oacute;n**  
Como usamos diferentes *stages* el problema es muy simple de resolver. Les dejo como ejemplo las configuraciones de `staging.rb`:

{% highlight ruby %}
role :web, "1.1.1.1", "2.2.2.2"
set :repository, "http://git.ejemplo.com/#{application}"
{% endhighlight %}

Y de `production.rb`:
{% highlight ruby %}
role :web, "3.3.3.3", "4.4.4.4"
set :repository, "http://git.ejemplo.com:8081/#{application}"
{% endhighlight %}

De esta forma, se puede quitar la linea `set :repository` del archivo `deploy.rb`.
