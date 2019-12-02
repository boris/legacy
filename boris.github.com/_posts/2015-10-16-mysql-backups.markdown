---
layout: post
title: MySQL Backups
date: 2015-10-16 15:48:58.000000000 -03:00
---
Imaginen que tenemos una DB de, digamos, unos 200GB y necesitan respaldarla. ¿Cómo lo hacen? En este post les mostraré como lo revolví yo.

Al momento de respaldar una base de datos, lo primero que tenemos que tener en cuenta es el volumen de datos con el que estaremos trabajando. Esto impacta en aspectos tan importantes como el espacio que necesitamos, qué herramienta usaremos, cómo moveremos los datos respaldados a un lugar seguro, cómo recuperaremos la información en caso que tengamos que hacerlo y cuánto tiempo nos tomará. Todas estas preguntas deben tener una respuesta que nos sea convincente durante el proceso de *planning* de nuestro backup.

El primer acercamiento que uno haría para respaldar una base de datos es [`mysqldump`](https://dev.mysql.com/doc/refman/5.5/en/mysqldump.html). Esta herramienta nos permite hacer respaldos de forma simple[^1], pero si bien tienen ventajas interesantes, como la posibilidad de editar el contenido antes de restaurar una base de datos, la escalabilidad no es una de sus mejores características. Y es cosa de leer su documentación:

> It is not intended as a fast or scalable solution for backing up substantial amounts of data. With large data sizes, even if the backup step takes a reasonable time, restoring the data can be very slow because replaying the SQL statements involves disk I/O for insertion, index creation, and so on.

Teniendo en cuenta eso, desprendemos un segundo problema: ¿Qué hacer si nuestra DB es de gran tamaño? Digamos, unos 200GB.

Si tenemos toda esa cantidad de data, es muy probable que tengamos más de alguna tabla con millones de registros. Y lo que es peor, que esa tabla sea utilizada frecuentemente para transacciones de lectura o escritura. Pero si utilizamos `mysqldump`, lo primero que ejecutaremos será un `lock table` para asegurarse que el respaldo sea consistente. Todo bien hasta ahí, pero ¿Qué pasa con nuestros usuarios? ¿Cómo les damos respuesta? ¿Cómo actualizamos la data de esa tabla mientras se hace el dump?[^2] 

Supongamos que logramos, de alguna forma eficiente, y tenemos un backup de una DB que pesa 200GB y estando comprimido pesa al rededor de 50GB. ¡Excelente! Pero ahora, ¿Cómo recuperamos una base de datos a partir de ése archivo? ¿Cuánto tiempo nos tomaría?

Respecto a esto último, lo que tendríamos que hacer (a grandes rasgos) es:

- Levantar una nueva instancia donde correrá la nueva DB
- Instalar todo lo necesario: credenciales de acceso, paquetes de MySQL, etc.
- Configurar MySQL
- Traernos el dump
- Hacer el *restore*
- Verificar la consistencia

En el mejor de los casos, los tres primeros puntos pueden ser ejecutados con algún sistema que administre configuraciones. Yo lo haría con Chef. Per ¿Qué hay del resto? ¿Cuánto nos tardaríamos en volver a tener nuestra DB online en caso de que explotara la actual?

De acuerdo a mi **D**isaster **R**ecovery **P**lan (DRP) me tardaría menos de 2 minutos. De hecho, lo que tendría que hacer es:

- ssh a la instancia de backup
- Ejecutar `stop slave`
- Modificar la configuración de MySQL para que ahora acepte escritura (por defecto todas, excepto el mysql-master están en modo *read-only*)
- Ejecutar `sudo service mysql restart`

## Estrategia
Después de darle muchas vueltas y leer bastante sobre el tema, llegué a la conclusión que lo mejor era tener una estrategia mixta, compuesta de **live backups** en zonas de disponibilidad distintas y backups **semi-incrementales** (tengo que buscar un mejor nombre para esto) día a día.

#### Live Backups
El live backup es la primera barrera de defensa en caso de que todo explote y la forma de recuperación es la que mencioné en el listado más arriba. Mantiene un backup segundo a segundo de todo lo que ocurre en la base de datos. El problema de esto es que si se ejecuta un `drop tables` en el mysql-master, este `drop table` se replicará a todos los slaves. Si esto ocurre, el live backup se va al carajo[^3].
Pero como programáticamente esto es difícil que ocurra, no es un tema que nos preocupe mucho.

El objetivo principal de este tipo de backups es dar protección a fallas de hardware o de conectividad. En ambientes basados en cloud, es común que el proveedor realice cambios o actualizaciones en el hardware que componen la plataforma, y estos cambios puedan afectar al funcionamiento de nuestra aplicación. Si esto llegase a ocurrir, el **live backup** sería una buena solución.

#### Backups parciales
Los backups parciales es algo que se me ocurrió (pero que posiblemente ya hay mucha gente haciéndolo) debido a que considero que los backups incrementales son una estupidez, sobre todo al momento de la recuperación del backup.

Supongamos que mi estrategia de backups fuera la siguiente:

- Domingo: backup full
- Lunes: backup incremental (la diferencia entre Domingo y Lunes)
- Martes: backup incremental (lo mismo, pero entre Lunes y Martes)
- Miércoles: backup incremental (idem... y de aquí para abajo igual)
- Jueves: backup incremental
- Viernes: backup incremental
- Sábado: backup incremental

Ahora supongamos que mi base de datos muere el día Viernes. Qué tendría que hacer para recuperar la base de datos?

- Aplicar el backup completo (del domingo anterior)
- Aplicar los incrementales de Lunes a Viernes. En total, 5 archivos.

Para resolver esto, implementé lo que llamo **backups parciales** y funciona de la siguiente manera:

- Domingo: backup full
- Lunes: backup de la diferencia entre Domingo y Lunes
- Martes: backup de la diferencia entre Domingo y Martes 
- Miércoles: backup de la diferencia entre Domingo y Miércoles
- Jueves: backup de la diferencia entre Domingo y Jueves
- Viernes: backup de la diferencia entre Domingo y Viernes
- Sábado: backup de la diferencia entre Domingo y Sábado

Entonces, si la DB decide morir el día Viernes, lo que tendría que hacer para recuperar el backup es:

- Aplicar el backup full del Domingo
- Aplicar el backup parcial del Viernes

Si bien esto utiliza una mayor cantidad de espacio, da lo mismo porque el espacio en disco es más barato que lo que podría significar estar sin servicio el tiempo que nos tome recuperar la base de datos.

* * *

[^1]: Alguien diría "de forma rápida y simple", pero la rapidez del dump tiene directa relación con el tamaño de nuestra base de datos.
[^2]: Para esto podríamos usar *mysqldump --skip-lock-tables* pero nuestro respaldo no será consistente.
[^3]: Estoy seguro que en algún punto, MySQL deberá implementar algún sistema de protección contra esto.
