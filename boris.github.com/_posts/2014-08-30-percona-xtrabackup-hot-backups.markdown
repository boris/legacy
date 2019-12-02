---
layout: post
title: Hot backups usando XtraBackup
date: 2014-08-30 00:00:00.000000000 -04:00
---
Por temas de confidencialidad no mencionaré donde pasó, cómo era la configuración del sistema y sólo me centraré en el punto fundamental de este post: Explicar cómo hacer un hot-backup usando Xtrabackup asumiendo una configuración Master/Slave de MySQL, MariaDB (premio (un sticker) para el que en los comentarios diga por qué se llama MariaDB) y cualquier otro MySQL-like.

Para hacer un backup usando innobackupex hacemos lo siguiente:

```
db-master:~ $ innobackupex --user=<user> --password=<passwd> --slave-info \
--defaults-file=/etc/mysql/my.cnf --databases="db1 db2" \
--stream=tar /var/lib/mysql |gzip -c1 > /backups/backup-mysql.tar.gz
```

Lo que hacemos con el comando anterior es indicarle a XtraBackup entregarnos el dump en formato tar, el cual será comprimido usando gzip. Esto tomará un buen rato, dependiendo del tamaño de nuestras bases de datos y una vez que termine debemos enviar el archivo al servidor slave. Para esto recomiendo usar `nc`.

## Restore.
Una vez tenemos el backup debemos restaurar (o preparar *from scratch*) una máquina slave, para lo cual debemos descomprimir el dump que copiamos desde `db-master` y descomprimirlo en algún lugar, el cual típicamente será `/var/lib/mysql`. Les recomiendo que el directorio de destino esté limpio antes de descomprimir el dump. Una vez que tenemos el dump en su lugar, ejecutamos:

```
db-slave:/var/lib/mysql $ innobackupex --apply-log --ibbackup=xtrabackup_51 ./
db-slave:/var/lib/mysql $ chown -R mysql: /var/lib/mysql
db-slave:/var/lib/mysql $ service mysql start
```

## Replication.
Está listo el dump, así que lo siguiente será habilitar la replicación contra `db-master`. Para esto debemos tener encuenta algunos datos importantes relacionados con el *binlog*:

```
db-slave:/var/lib/mysql $ cat /var/lib/mysql/xtrabackup_binlog_info
mysql-bin.000123      1234567
```

El primer valor nos indica el nombre del `binlog` en donde escribió el `db-master` por última vez antes de hacer el dump y el segundo valor es la posición del log desde el cual `db-slave` debe comenzar a registrar la data que el envíe `db-master`. Ahora que sabemos eso, hacemos lo siguiente:

```sql
mysql> CHANGE MASTER TO MASTER_HOST='db-master', MASTER_USER='replication', \ 
MASTER_PASSWORD='passwordsupersegura', MASTER_LOG_FILE='mysql-bin.000123', \
MASTER_LOG_POS=1234567;
mysql> START SLAVE;
```

Finalmente, y si todo funcionó bien, veremos que los segundos de diferencia con `db-master` disminuyen cada vez que hacemos:

```sql
mysql> SHOW SLAVE STATUS\G
...
Slave_IO_Running: Yes
Slave_SQL_Running: Yes
...
Seconds_Behind_Master: 1337
```

Ojo que al ejecutar el `show slave status` es mejor usar `\G` que `;` ;)
