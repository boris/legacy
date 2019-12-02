---
layout: post
title: SQLite3 to MySQL
date: 2015-09-19 20:45:52.000000000 -03:00
---
Hoy me vi enfrentado al problema de migrar desde [SQLite](https://www.sqlite.org/) a [MySQL](http://dev.mysql.com/) sin perder data. 
Acá les dejo el proceso por si alguien más tiene que hacerlo:

1. Obtener el dump desde sqlite:
    `sqlite3 db/development.sqlite3 .dump > dump.sql`
1. Eliminar lo que no necesitamos:
    `sqlite_sequence
     BEGIN TRANSACTION;
     COMMIT;`
1. Reemplazar lo que no usaremos en MySQL, en vim:
    ```%s/AUTOINCREMENT/AUTO_INCREMENT/g
     %s/"/`/g
    ```
1. Importar el dump:
    `mysql -u user -p database < dump.sql`
