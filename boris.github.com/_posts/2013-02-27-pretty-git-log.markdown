---
layout: post
title: Pretty git log
date: 2013-02-27 08:02:33.000000000 -03:00
---
Cuando vemos el log de git, usando `git log` nos encontramos con esto:

![GitCommonLog](/images/git_log01.png)

Si bien es bastante fácil de leer, debo reconocer que no me agrada. En su lugar, tengo un alias (`git l`) que muestra lo siguiente:

![GitCustomLog](/images/git_log02.png)

Cómo conseguir esto? Agregando el siguiente alias al `.gitconfig`:

	l = log --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(by %an %ar)%Creset' --all
