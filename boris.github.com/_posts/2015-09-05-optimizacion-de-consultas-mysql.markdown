---
layout: post
title: Optimización de consultas MySQL
date: 2015-09-05 21:47:17.000000000 -03:00
---
Más allá del "cómo" y el "qué", en este post me centraré en el "con qué", y escribiré siempre desde la experiencia que he tenido trabajando hace muchos años con MySQL. A decir verdad, ya no recuerdo cuando fue la primera vez que usé MySQL en producción por lo que asumo que fue hace mucho. Estamos viejos :(

#### MySQL EXPLAIN!
El comando `EXPLAIN` es la principal forma que tenemos para saber cómo el *query optimizer* de MySQL decidirá cómo ejecutar las queries. Su funcionamiento interno es un tanto complejo, pero después de harto estudio lo podría resumir así.

Cuando ejecutamos una query, digamos `EXPLAIN SELECT 1;`, MySQL le pondrá un "flag" a esta query y cuando ejecute la query[^1] el flag causará que se entregue información sobre cada paso del [plan de ejecución](https://dev.mysql.com/doc/refman/5.5/en/execution-plan-information.html), en lugar de entregar el resultado de la query.

#### Variantes
Además del `explain` común existen dos variantes, que son el `EXPLAIN EXTENDED` y el `EXPLAIN PARTITIONS`.

El primero, `EXPLAIN EXTENDED`, a primera vista parece comportarse igual que el `EXPLAIN` "normal", pero la variante `EXTENDED` le dirá a nuestro servidor que debe hacer un **reverse compile** del plan de ejecución en una sola sentencia `SELECT`. Si queremos ver la sentencia "resultado", bastará con ejecutar un `SHOW WARNINGS` inmediatamente después.

Esta nueva sentencia viene directamente del plan de ejecución, no de la query original que en este punto no es más que una estructura de datos, por lo en la mayoría de los casos, la nueva sentencia no será la misma que la query original.

El `EXPLAIN EXTENDED` es una buena herramienta para saber exactamente cómo el optimizador de MySQL transforma nuestras consultas antes de ejecutarlas.

Por otro lado, el `EXPLAIN PARTITIONS` cumple una función similar pero aplicado a queries que involucran más de una partición.

#### Limitaciones
Debemos tener claro que el resultado de `EXPLAIN` es sólo una aproximación. En algunos casos es buen, en otros más o menos, y en otros puede estar muy lejos de la verdad.

Aquí un pequeño listado con las que considero algunas de sus limitaciones:

- No nos dice nada sobre como los triggers, funciones almacenadas o UDFs[^2] afectan la query.
- No funciona con procedimientos almacenados, así que la opción es extraer las queries y ejecutar el `EXPLAIN` manualmente.
- Algunas de las estadísticas que muestra son estimaciones, por lo que pueden ser poco precisas.


A pesar de todo lo anterior, `EXPLAIN` es la mejor herramienta que tenemos hasta ahora para conocer cómo se ejecutan nuestras queries y poder optimizarlas. Como meta personal, pretendo escribir un post más extenso sobre este tema, con ejemplos y explicación detallada, pero no sé cuanto tiempo pueda tomarme. Ya veremos.

* * * 

[^1]: Es un error común creer que el EXPLAIN no ejecuta las queries, pero si la query que queremos analizar contiene una subquery en el FROM, **se ejecutará** la subquery, se pondrá el resultado en una tabla temporal y luego se optimizará la query.

[^2]: User Defined Function.
