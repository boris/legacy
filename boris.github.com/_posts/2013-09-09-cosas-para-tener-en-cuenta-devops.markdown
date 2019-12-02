---
layout: post
title: Cosas para tener en cuenta cuando uno trabaja como DevOp
date: 2013-09-09 00:00:00.000000000 -03:00
---
Este post no pretende ser ninguna gu&iacute;a espiritual ni nada parecido en lo que a DevOp respecta. Es s&oacute;lo un ordenamiento de experiencias y buenas/malas pr&aacute;cticas que hasta ahora me han dado buenos resultados en el trabajo. Algunos lo llaman "metodolog&iacute;as &aacute;giles", pero yo creo que mi m&eacute;todo es mejor: "get shits done"...

# Deliver fast, deliver often
Esto es como la gravedad (es la ley). No hay nada mejor que entregar un proyecto r&aacute;pido, con la cantidad m&iacute;nima de features para que funcione e ir agregando features desde ah&iacute;. La raz&oacute;n de esto? Simple: Si tenemos un *sprint* que dura una semana, y nos equivocamos o algo sale horriblemente mal, s&oacute;lo tendremos que recuperar una semana de trabajo "perdido". Lo terrible ser&iacute;a perder un trabajo de meses...

# Track all your deployments
![Track your deployments](/images/meme_deploy.jpg)  
Esto es algo muy necesario ya que en un ambiente *&aacute;gil* y de entregas constantes. Siempre es necesario saber con exactitud cuando se hizo el release de qu&eacute; cosa. En el mejor de los casos, siempre es bueno tener un *changelog* para compartir con nuestro equipo, as&iacute; todos tienen claro lo que se entreg&oacute;.

La necesidad de esto nace de la cantida de *deploys* que se hacen actualmente en mi trabajo en un d&iacute;a de entregas: Aproximadamente 42...

# If it moves, track it.
Incluso si no se mueve y la expectativa es que **no** se mueva, hay que monitorearlo para estar seguros que no se mover&aacute;. Esto lo aprend&iacute; [de un post de los capos de Etsy](http://codeascraft.com/2011/02/15/measure-anything-measure-everything/) y desde que comenc&eacute; a aplicarlo tengo claro qu&eacute; con los sistemas que manejo y qu&eacute; puedo esperar de ellos...

Es importante conocer los datos hist&oacute;ricos para poder predecir el futuro, dicen. :)

# Automate as much as you can!
Hay muchas tareas que se deben hacer d&iacute;a a d&iacute;a que f&aacute;cilmente pueden ser automatizadas: Deployments, setup de nuevos servidores, backups, env&iacute;o de reportes de estado, el t&eacute; o caf&eacute;... Casi todo. El desaf&iacute;o est&aacute; en identificar la necesidad e implementar la automatizaci&oacute;n.

Cuando legu&eacute; a mi actual trabajo nada estaba automatizado. Al poco tiempo, los backups, el setup de nuevos servidores y el proceso de deploy estaba automatizado usando scripts hechos a medida, chef y capistrano respectivamente.

Junto con todo esto, es importante nunca perder la curiosidad y las ganas de aprender cosas nuevas cada d&iacute;a que pueda (o no) ser aplicadas a nuestro trabajo diario.
