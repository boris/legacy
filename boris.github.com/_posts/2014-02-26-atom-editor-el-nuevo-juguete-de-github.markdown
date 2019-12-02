---
layout: post
title: Atom Editor el nuevo juguete de Github
date: 2014-02-26 00:00:00.000000000 -03:00
---
Hoy la comunidad geek mundial se revolucionó al conocer a [Atom](http://twitter.com/atomeditor). La idea detrás de este proyecto es mezclar lo mejor de dos mundos: Por un lado todo lo que ofrecen en términos de usabilidad los editores "modernos" como Sublime o TextMate y por otro lado la potencia, flexibilidad y *hackeabilidad* que editores de verdad como Vim o Emacs.

Personamente, nunca he dejado de usar Vim. Soy de los que tiene su propio theme, vimrc y varios plugins, además de un sistema para reconstruir mi ambiente bastante rápido cada vez que lo necesito (git clone, ln -s y listo) y nunca me llamó la atención cambiarme a nada más *moderno* como MacVim, pero debo reconocer que Atom me intriga un poco. Un poco harto, y por varias razones:

1. Fue diseñado pensando en *hackeabilidad* y usabilidad.
2. Univerisdad Católica.
3. Usaron una excelente estrategia: invitaciones (como Google lo hizo alguna vez con GMail).
4. Fue hecho por gente que de esto sabe mucho...

**Como obtuve una invitación**

<blockquote class="twitter-tweet" lang="en"><p><a href="https://twitter.com/mojombo">@mojombo</a> what about this: A neutron walked into a bar and asked, &quot;How much for a drink?&quot; The bartender replied, &quot;For you, no charge.&quot;</p>&mdash; Boris Quiroz (@cereal_bars) <a href="https://twitter.com/cereal_bars/statuses/438824712106680320">February 26, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

**Lo que he visto hasta ahora**

A primera vista es igual a [Sublime Text](http://www.sublimetext.com/), con un sistema similar para agregar/manejar diferentes paquetes para diferentes propósitos. El primero que agregué fue [Vim-mode](http://atom.io/packages/vim-mode), además de modificar un poco el *theme* antes de ponerme a escribir este post.

Para instalar un paquete, se puede hacer desde las *Settings* de Atom o bien usando la terminal así:

{% highlight bash %}
boris@macbook ~
> $ apm install Zen
Installing Zen to /Users/boris/.atom/packages ✓

boris@macbook ~
> $
{% endhighlight %}

Ya veremos si me acostumbro...
