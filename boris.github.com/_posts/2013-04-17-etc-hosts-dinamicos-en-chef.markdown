---
layout: post
title: /etc/hosts dinamicos en Chef
date: 2013-04-17 22:45:00.000000000 -03:00
---
Hoy tuve que solucionar el siguiente problema: Generar de forma automagica el archivo `/etc/hosts` para todos los servers que son manejados con [Chef](http://www.opscode.com/chef/). La idea es que todos los hosts se conozcan con todos sin la necesidad de estar agregando manualmente cada uno al DNS. De hecho, creo que no se justifica en este caso tener un DNS Server ya que son poquitos hosts, como 17...

Si lo pensamos bien, debido a los pocos hosts que eran (y que no se piensan agregar m&aacute;s en un futuro cercano), daba lo mismo si generaba un archivo _est&aacute;tico_ (o hecho a mano) con la definici&oacute;n de los hosts y lo distribu&iacute;a con Chef. Pero a decir verdad, eso es poco sexy...

As&iacute; que para solucionar el problema hice lo siguiente:

- Crear un nuevo cookbook llamado **hosts**

{% highlight bash %}
boris@air:~$ knife cookbook create hosts
** Creating cookbook hosts
** Creating README for cookbook: hosts
** Creating CHANGELOG for cookbook: hosts
** Creating metadata for cookbook: hosts
{% endhighlight %}

- Editar el archivo `/path-to-cookbooks/hosts/recipe/default.rb` con el siguiente contenido:
{% highlight ruby %}
hosts = search(:node, "*:*", "X_CHEF_id_CHEF_X asc")

template "/etc/hosts" do
source "hosts.erb"
owner "root"
group "root"
   mode 0644
variables(
      :hosts => hosts,
      :fqdn => node[:fqdn],
      :hostname => node[:hostname]
      )
end
{% endhighlight %}

- Editar el archivo `/path-to-cookbooks/hosts/templates/defult/hosts.erb` con lo siguiente:

{% highlight erb %}
# Generado automagicamente con Chef
127.0.0.1 localhost

# Nodos manejados por Chef
<% @hosts.each do |node| %>
<%= node['ipaddress'] %> <%= node['hostname'] %>
<% end %>

# Shits con IPv6
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
{% endhighlight %}

Luego de eso agregamos el _recipe_ a alg&uacute;n nodo o, como lo hice yo, agregar el _recipe_ al _run_list_ de uno de mis _roles_ y esperar que el `chef-client` corra en cada nodo.
