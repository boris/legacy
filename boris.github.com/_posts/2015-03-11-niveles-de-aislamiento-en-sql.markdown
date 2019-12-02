---
layout: post
title: Niveles de aislamiento en SQL
date: 2015-03-11 00:00:00.000000000 -03:00
---
El standard de SQL (el mismo que utilizan postgreSQL, MySQL, MariaDB, etc) define 4 niveles de aislamiento, con reglas específicas por medio de las cuales los cambios que se realizan en nuestra base de datos son o no visibles tanto dentro como fuera de una transacción. Los niveles están típicamente ordenados de menor a mayor, donde los niveles menores generalmente permiten mayor concurrencia y tienen menos *overhead*.

## Para estar en contexto...
Como escribiré sobre **niveles de aislamiento** en transacciones SQL, dejemos en claro qué se entiende por **transacción**. Y de acuerdo a la definición aceptada por la comunidad, una transacción es:

> Un grupo de consultas SQL que son tratadas de forma *atómica* como una sola unidad de trabajo.

Estas unidades de trabajo (transacciones) son tratadas por el motor de la base de datos siguiendo la lógica que siguen los equipos de fútbol en el último minuto cuando el partido está 2-1 abajo y hay córner a favor: Sube el arquero a buscar el empate, a riesgo de perder 3-1.

En palabras más simple, es **all in**. Es decir, si el motor de base de datos puede ejecutar **todas** las consultas de una transacción, lo hará. Si falla alguna, ninguna de las consultas de la transacción será aplicada. Por esto se dice que es **todo o nada**. Más bien, todas o ninguna...

### Ejemplo de una transacción

```
START TRANSACTION;
SELECT plata FROM cuentas WHERE user_id = 1337;
UPDATE cuentas SET plata = plata - 200 WHERE user_id = 1337;
COMMIT;
```

*nota: para los ejemplos de más adelante, supongamos que `plata = 500`*

## READ UNCOMMITED
En este nivel, las transacciones son capaces de ver los resultados de otras transacciones que aun no han sido aplicadas (*commited*). Aquí uno puede decir "uh, bacán... es 'en tiempo real'". Pero no. De hecho, si estamos trabajando en este nivel de aislamiento, es muy probable que nuestra base de datos tenga problemas de diversos tipos y por esta razón este nivel rara vez es utilizado en la práctica, principalmente por los problemas de integridad de data que puede tener y además porque no presenta ventajas de performance frente a otros niveles.

Como anécdota, este nivel también es conocido como *"dirty read"*.

## READ COMMITED
Este nivel es el standar de la mayoría de las bases de datos actuales, pero no de MySQL. En este nivel, sin duda se resuelve el problema del **READ UNCOMMITED** de una forma muy simple, en donde se asegurará que una transacción pueda ver sólo los cambios que ya fueron *commiteados* cuando la transacción comenzó. Y además, los cambios de la transacción no serán visibles al resto de las transacciones cuando sean *commiteados*.

Supongamos que la transacción de ejemplo, que llamaremos **TA**, se incia en el instante `T0` con el `START TRANSACCTION` y termina en el instante `T3` con el `COMMIT`. Supongamos, también, que tenemos una segunda transacción que llamaremos **TB** que se inicia en el mismo instante que **TA**, con el siguiente contenido:

```
START TRANSACTION;
SELECT plata FROM cuentas WHERE user_id = 1337;
COMMIT;
```

El resultado de **TB**, bajo el nivel de aislamiento **READ COMMITED** será `500`. Por qué? Porque en el instante que se inició **TB**, **TA** aun no pasaba por la linea `COMMIT` por lo tanto los cambios aun no eran visibles para las demás transacciones.

## REPEATABLE READ
Este es el nivel que por defecto usa MySQL (yey!) y la gran gracia que tiene es que **garantiza** que cualquier fila que sea leída por una transacción tendrá el mismo aspecto en lecturas posteriores dentro de la misma transacción. Suena *la raja*, pero en teoría genera otro problema: las lecturas fantasma.

Una lectura fantasma ocurre cuando, por ejemplo, seleccionamos un rango de filas que cumplan cierta condición y nos da como resultados 10 filas. Mientras hacemos este `SELECT`, otra transacción inserta una nueva fila dentro de este rango. Cuando volvamos a repetir la lectura (el `SELECT`) veremos que una nueva fila aparecerá. La *fila fantasma*.

Tanto InnoDB como XtraDB resuelven este problema utilizando un control de concurrencia multiversión, algo así como git. En otro post explicaré esto...

## SERIALIZABLE
Este nivel de aislamiento resuelve todos los problemas anteriores fornzando a que las transacciones se ejecuten de forma ordenada de forma que no puedan existir conflictos. Esto lo hace bloqueando cada una de las columnas que lee.

El problema que genera este nivel de aislamiento es la gran cantidad de timeouts y locks que puedan ocurrir. Debe ser por esta razón que son muy pocas las aplicaciones que usan este nivel de aislamiento.

