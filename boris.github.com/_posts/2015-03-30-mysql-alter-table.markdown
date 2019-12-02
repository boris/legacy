---
layout: post
title: MySQL Alter Table
date: 2015-03-30 00:00:00.000000000 -03:00
---
Modificar la estructura de una tabla en MySQL es algo bastante común estos días. Los que trabajamos en el mundo de Rails tenemos que ejecutar regularmente uno que otro `rake db:migrate`, pero en ése caso gran parte del trabajo lo hace el [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html).

Sin importar el framework que usemos, en el bajo nivel de MySQL siempre ocurrirá lo mismo y por esta razón es que siempre existirán diferentes formas de hacer una modificación a la estructura de la tabla. La opción que elijamos siempre dependerá de las caracterísiticas propias de nuestra tabla: si tiene o no índices, si esos índices son coherentes con el storage engine que se usa, el storage engine que se usará, el largo de la tabla, la cantidad de columnas que queremos modificar, etc.

A continuación dejaré tres opciones para tener en cuenta al momento de modificar un componente fundamental de una tabla: su storage engine.

## ALTER TABLE

Por goleada la forma más fácil de hacerlo.

```
mysql> ALTER TABLE cool_table ENGINE = InnoDB;
```

Fácil y bonito. El problema? Se puede demorar **MUCHO** tiempo ya que MySQL hara una copia fila por fila (*row-by-row copy*) de la tabla antigua a la tabla nueva con InnoDB. Y lo que es peor, durante la ejecución del`ALTER` veremos un aumento significativo en el uso de I/O de nuestro disco al tiempo que vemos un *read-lock* en la tabla en cuestión mientras se ejecuta la tarea. Esto provocará contención y degradación del servicio.

## Dump && Import
Otra opción es el viejo y querido `mysqldump`. Y de verdad es muy simple! Basta con hacer un dump de la tabla que queremos modificar y luego editar el archivo `.sql` ajustando los valores necesarios. Acá hay que tener cuidado con el `DROP TABLE` que hay en el archivo que genera `mysqldump`.

Parece una opción conveniente, pero hay que tener en cuenta que mientras se ejecuta el dump hay un `LOCK TABLE` de por medio...

## CREATE && SELECT
Según yo esta es la mejor opción, aunque también es la más pajera. El fujo es más o menos el siguiente: Crear una tabla nueva "como" la antigua, ejecutar el `ALTER` sobre la tabla nueva, sacar los datos de la tabla antigua e intertarlos en la tabla nueva. De ser necesario, eliminar la tabla antigua y renombrar la nueva.

```sql
mysql> CREATE TABLE new_table LIKE old_table;
mysql> ALTER TABLE new_table ENGINE = InnoDB;
mysql> INSERT INTO new_table SELECT * FROM old_table;
```

Excelente, pero qué pasa si la tabla `old_table` es **muy** grande? Ahí lo que podemos hacer es usar los índices y ejecutar una transacción como esta:

```sql
mysql> START TRANSACTION;
mysql> INSERT INTO new_table SELECT * FROM old_table
    -> WHERE id BETWEEN x AND y;
mysql> COMMIT;
```
