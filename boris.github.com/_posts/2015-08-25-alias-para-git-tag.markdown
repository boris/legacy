---
layout: post
title: Alias para git tag
date: 2015-08-25 17:57:58.000000000 -03:00
---
Hoy, mientras miraba el output del comando `git tag`, se me ocurrió buscar una forma de ordenar el resultado en orden ascendente respetando las separaciones por punto.

Para ejemplificar esto, hice un hermoso(?) *one-liner* en ruby que simula los números de versiones

```irb
irb(main):037:0> 10.times { puts 3.times.map { [*'0'..'9'].sample }.join.gsub(/([0-9])/) { |n| "#{$1}."}.chop }
0.2.5
0.3.3
9.2.9
7.3.7
9.9.0
3.7.3
7.4.6
5.7.9
4.1.8
0.5.7
=> 10
```
Una vez que tenemos nuestro listado de tags, lo que hacemos es ejecutar el siguiente comando:

`git tag | sort -n -t . -k 3 | sort -n -t . -k 2 | sort -n -t . -k 1`

El resultado será el siguiente:
```
0.2.5
0.3.3
0.5.7
3.7.3
4.1.8
5.7.9
7.3.7
7.4.6
9.2.9
9.9.0
```

Ahora sólo nos queda crear un alias en nuestro `~/.zshrc` y listo.
