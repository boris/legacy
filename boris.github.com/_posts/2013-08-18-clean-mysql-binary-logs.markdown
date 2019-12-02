---
layout: post
title: Clean MySQL Binary Logs
date: 2013-08-18 00:00:00.000000000 -04:00
---
Cuando llegu&eacute; a mi actual trabajo, me econtr&eacute; con muchas cosas que estaban hechas *-en buen chileno-* al lote. Un ejemplo claro: Una base de datos de aproximadamente 700MB con al rededor de **375GB de binary log**.

Mirando en la configuraci&oacute;n de la base de datos me econtr&eacute; lo siguiente:

{% highlight mysql %}
mysql > show variables like '%expire%';
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| expire_logs_days | 75    |
+------------------+-------+
1 row in set (0.00 sec)
{% endhighlight %}

Ah&iacute; vino la pregunta si realmente necesitamos 75 d&iacute;as de binary logs?. En este caso, no. Entonces, c&oacute;mo arreglar el problema? En este caso, hay dos opciones: La primera es hacerlo *on-the-fly* y la otra es agregar un parametro a la configuraci&oacute;n de MySQL.

Para probar, lo hice *on-the-fly* y como obtuve buenos resultados, posteriormente lo agregu&eacute; al `my.cnf`.

{% highlight mysql %}
mysql> set global expire_logs_days=1;
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like '%expire%';
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| expire_logs_days | 1     |
+------------------+-------+
1 row in set (0.00 sec)
{% endhighlight %}

Con esto solo guardaremos 1 d&iacute;a de historia del binary log, lo que es m&aacute;s que suficiente para lo que necesito.

*Para los que no lo saben, el binary log de MySQL es el lugar donde se registran todas las queries que se ejecutan, y su finalidad est&aacute; relacionada netamente con la replicaci&oacute;n de la data: Cuando tenemos un replica set, el binary log es la funte de datos desde el master al slave en caso de que el proceso de replicaci&oacute;n falle :)*
