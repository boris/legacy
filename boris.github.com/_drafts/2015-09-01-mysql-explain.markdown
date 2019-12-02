---
layout: post
title: MySQL Explain!
---
![](http://allthingsd.com/files/2011/11/explanation-i-demand-one.png)
¿Alguna vez se han encontrado con una consulta MySQL que toma mucho tiempo y no saben por qué? Y una vez que detectaron la consulta, ¿Qué han hecho para optimizarla?

Lo que yo siempre hago es usar [**explain**](https://dev.mysql.com/doc/refman/5.1/en/using-explain.html), que lo que hace es mostrarnos como MySQL procesa cada query antes de ejecutarla. Sí, el motor de MySQL es **tan** groso que antes de ejecutar cualquier query intentará optimizarla. **De hecho, la salida del comando `explain` nos muestra la forma en que el motor de MySQL decidiría como ejecutar una query**.

Ejemplo:

```mysql
mysql> explain select 1\G
*************************** 1. row ***************************
           id: 1
  select_type: SIMPLE
        table: NULL
         type: NULL
possible_keys: NULL
          key: NULL
      key_len: NULL
          ref: NULL
         rows: NULL
        Extra: No tables used
1 row in set (0.00 sec)
```

