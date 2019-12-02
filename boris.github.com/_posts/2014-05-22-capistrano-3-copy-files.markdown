---
layout: post
title: Copiar archivos usando Capistrano 3
date: 2014-05-22 00:00:00.000000000 -04:00
---
Una de las herramientas más usadas para hacer deploy es [Capistrano](https://github.com/capistrano/capistrano) (otra bastante usada es [Fabric](https://github.com/fabric/fabric)). El proceso de deploy con Capistrano es bastante simple y se reduce a un `cap deploy`. Pero eso no es lo que interesa ahora. Lo que sí interesa es cómo hacemos si queremos copiar algun archivo local a un servidor remoto?

## Cómo?!
Me explico. Supongamos que tenemos un proyecto en rails, alojado en [Github](http://github.com) del cual queremos hacer deploy a uno de nuestros servers. Nuestro proyecto tiene que tener archivos de configuración para la base de datos, para resque, para rainbows, etc. Los dos últimos no es problema si los dejamos en el repositorio, pero de base de datos? Con nuestra contraseña de base de datos ahí? [Y los niños andando en bicicleta?](http://www.eldinamo.cl/2012/01/17/chilevision-publica-entrevista-completa-de-ines-perez-sobre-las-nanas/) *(chiste chileno...)*

Entonces, cómo hacemos para mantener seguro los archivos que no queremos compartir con el mundo? Fácil: **no los publicamos**. Y cómo hacemos para copiarlos al servidor? Alguien diría: "Usando scp". Sí, pero si tenemos que copiarlo a unos 40 servidores? Un `for` y luego `scp`? Mejor usar Capistrano con la siguiente task:

{% highlight ruby %}
namespace :devops do
  desc "Copy files"
  task :copy do
    on roles(:all) do |host|
      %w[ file.one file.two file.n ].each do |f|
        upload! '/path/to/file/' + f, '/remote/path/' + f
      end
    end
  end
end
{% endhighlight %}

Luego, cuando necesitamos copiar estos archivos hacemos un `cap devops:copy` y listo :)
