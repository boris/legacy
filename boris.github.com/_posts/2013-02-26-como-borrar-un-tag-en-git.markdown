---
layout: post
title: 'Como: Borrar un TAG en Git'
date: 2013-02-26 06:57:30.000000000 -03:00
---
El proceso de release que me gusta usar es parecido (en realidad es lo mismo) a [git flow](http://nvie.com/posts/a-successful-git-branching-model/). Lo describo rapidamente:

1. Hacemos todo el desarrollo en el branch `develop`
2. Al momento de finanlizar el sprint, creamos un release branch llamado `release-X.X.X`, donde X.X.X es la version que vamos a liberar (obvio).
3. Hacemos un merge de `release-X.X.X` en `master`, de la siguiente forma: `git merge --no-ff release-X.X.X`
4. En `master` hacemos un tag: `git tag X.X.X`
5. Mandamos el tag al mundo: `git push --tags`

### Aqui viene el problema.
Qué ocurre cuando un developer, con lo giles que son, se olvida de commitear algo al release branch?

En uno de los balanceadores de carga (que controla una app móvil) hay una __cosa__ (lo llamo así para simplificar la explicación) que verifica que cada nodo detrás del balanceador de carga esté con vida. Sin esto, el ELB de Amazon no incluirá el nodo dentro de la rotación y por lo tanto no llegan requests. Y por lo tanto al resto de los nodos les llega más carga, de forma __desbalanceada__ (ver [este post](/2013/02/20/como-funciona-el-load-balancer-de-amazon-ws/)) y el mundo explotaría.

Bueno, el tema es que en el último release me econtré con este problema cuando el TAG ya estaba creado. Qué hacer? Había dos opciones:

1. Crear un hotfix branch
2. Mandar a la mierda el TAG de release y crearlo nuevamente.

### "Lo segundo, xilófono..." (Homero J. Simpson)
Supongamos que el __release branch__ era `release-1.24.0`, el TAG será `1.24.0`. Veamos cómo eliminarlo:

	(master)# git tag
	(...)
	1.23.0
	1.24.0
	(master)# git tag -d 1.24.0
	(master)# git push origin :refs/tags/1.24.0

Listo. Con eso eliminamos el TAG y podemos volver a crearlo
