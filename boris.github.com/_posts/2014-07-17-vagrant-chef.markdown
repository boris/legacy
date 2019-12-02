---
layout: post
title: Vagrant + Chef
date: 2014-07-17 00:00:00.000000000 -04:00
---
[Vagrant](https://vagrantup.com) es una herramienta que nos permite crear y configurar entornos de desarrollo portables, livianos y reproducibles. Y es en este último punto donde me quiero detener. La idea de que sea reproducible está relacionada con la agilidad o el tiempo que nos tomará tener una instancia andando.

Imaginemos que tenemos que entregar el entorno de desarrollo al nuevo developer, y en ese entorno hay varias configuraciones que si las hacemos manualmente estaríamos un buen rato. Qué hacer? Hay dos opciones rápidas: 1. Hacer una imagen, la cual ante cualquier cambio quedaría obsoleta y tendríamos que hacerla otra vez. 2. Usar Vagrant con Chef.

## ¿Cómo?
Es cosa de incluir lo siguiente en el `Vagrantfile`

```ruby
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    [...]

    # Chef provisioning
    config.vm.provision "chef_client" do |chef|
	chef.chef_server_url = "http://chef.cl"
	chef.node_name = "Wardenclyffe"
	chef.validation_key_path = "path/to/file.pem"
	chef.validation_client_name = "boris" # o el nombre de nuestro cliente
	chef.environment = "development"

	# Role for developers
	chef.add_role "development_scl"
    end
end
```

Obviamente tenemos que tener el role "development_scl" con todo lo necesario para luego ejecutar `vagrant provision` y esperar que todo se instale.
